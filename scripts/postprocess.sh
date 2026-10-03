#!/usr/bin/env bash
# Rewrites runic's output where runic gets Odin wrong. Run by `make generate` after runic,
# once per package: scripts/postprocess.sh pango|pangocairo. Deterministic: the same runic
# output always gives the same file. Every rule is listed in docs/PATCHED.md.
# Flag enums become bit_sets (bit_sets below).
#
# layout_get_log_attrs_readonly returns a run of LogAttr (its length is the out-parameter), which
# runic writes as ^LogAttr; the rule at the end of the pango sed list makes it [^]LogAttr.
#
# The rules are odin-gtk's (MIT, docs/LICENSE-odin-gtk.md), kept where they still apply to
# runic 0.8 on the system headers.
set -euo pipefail

# The GFlags types. runic emits them as `enum u32` of the C values; a value rule cannot tell
# them from sequential enums, so they are listed. The list is the <bitfield> entries of
# Pango-1.0.gir that pango's headers declare.
pango_flags="FontMask LayoutDeserializeFlags LayoutSerializeFlags ShapeFlags ShowFlags"

# bit_sets <file> <strip-prefix> <enum>...: `Foo :: enum u32 {A = 1, B = 4, C = 5, NONE = 0}`
# becomes
#   FooBit :: enum u32 {A = 0, B = 2}        bit indices, prefix stripped from the members
#   Foo :: bit_set[FooBit; u32]              same size and bits as the C type
#   C :: Foo{.A, .B}                         composite masks, by their C names
#   NONE :: Foo{}                            zero members, by their C names; a name with no
#                                            underscore (NONE, FAMILY) is prefixed FOO_ so it is unique
# Members that are not one bit or zero are composites; a composite with a bit that has no
# member is a transmute of the C value. Fails if a listed enum is missing, has a negative
# value or has no single-bit member, so a header bump that changes a flag type is noticed.
bit_sets() {
    local file=$1 strip=$2
    shift 2
    STRIP=$strip NAMES="$*" perl -i -ne '
        BEGIN { $strip = $ENV{STRIP}; %want = map { $_ => 1 } split " ", $ENV{NAMES}; }
        if (/^(\w+) :: enum u32 \{(.*)\}\s*$/ && $want{$1}) {
            my ($name, $body) = ($1, $2);
            delete $want{$name};
            my (@bits, @zero, @comp, $all);
            (my $pre = uc($name =~ s/([a-z0-9])([A-Z])/$1_$2/gr)) .= "_";
            for my $m (split /,\s*/, $body =~ s/\s+$//r) {
                $m =~ /^(\w+) = (-?\d+)$/ or die "postprocess: $name: cannot read member $m\n";
                my ($id, $v) = ($1, $2);
                die "postprocess: $name.$id is negative\n" if $v < 0;
                if ($v == 0) { push @zero, $id }
                elsif (($v & ($v - 1)) == 0) { push @bits, [$id, $v] }
                else { push @comp, [$id, $v] }
            }
            die "postprocess: $name has no single-bit member\n" unless @bits;
            my %idx; my $mask = 0;
            for (@bits) {
                my $i = 0; $i++ while (1 << $i) != $_->[1];
                ($id = $_->[0]) =~ s/^\Q$strip\E//;
                $idx{$_->[1]} = $id; $mask |= $_->[1];
                $_ = [$id, $i];
            }
            print "${name}Bit :: enum u32 {", join(", ", map { "$_->[0] = $_->[1]" } @bits), "}\n";
            print "$name :: bit_set[${name}Bit; u32]\n";
            for (@zero) { my $c = /_/ ? $_ : "$pre$_"; print "$c :: $name\{}\n" }
            for (@comp) {
                my ($id, $v) = @$_;
                $id = "$pre$id" unless $id =~ /_/;
                if (($v & ~$mask) == 0) {
                    print "$id :: $name\{", join(", ", map { ".$idx{$_}" } grep { $v & $_ } sort { $a <=> $b } keys %idx), "}\n";
                } else { print "$id :: transmute($name)u32($v)\n" }
            }
        } else { print }
        END { die "postprocess: flag enum(s) not found: " . join(" ", sort keys %want) . "\n" if %want; }
    ' "$file"
}

# retype <file>: reads `name parameter from to` lines on stdin and rewrites the type of that
# parameter (name is a procedure, a callback typedef, or Struct.field for a struct member) from
# the prefix `from` to `to`. `parameters: declared` makes every procedure parameter ^T and leaves
# callback typedefs and struct members to runic's name heuristic, so these are the places it
# cannot say what C means: an out-array (`T **` that returns a run) is `^[^]T`, a callback's run
# is `[^]T`, a struct member that holds one object is `^T`. Fails if a listed declaration is
# missing or typed otherwise, so a header bump that changes one is noticed.
retype() {
    local file=$1
    LIST="$(cat)" perl -i -ne '
        BEGIN { for (split /\n/, $ENV{LIST}) { next unless /\S/; my @f = split " "; push @todo, [@f, 0] } }
        $struct = $1 if /^(\w+) :: (?:#type )?struct/;
        $struct = "" if /^\}/;
        for my $t (@todo) {
            my ($proc, $param, $from, $to) = @$t;
            my ($s, $f) = split /\./, $proc;
            if (defined $f) { next unless $struct eq $s && /^\s+\Q$f\E: / }
            else { next unless /^\s*(?:\@\(.*?\)\s*)?\Q$proc\E :: / }
            next unless /\b\Q$param\E: (\S+)/;
            my $type = $1;
            die "postprocess: $proc $param is $type, want $from\n" if index($type, $from) != 0;
            s/\b\Q$param\E: \Q$from\E/$param: $to/;
            $t->[4] = 1;
        }
        print;
        END { for (@todo) { die "postprocess: $_->[0] $_->[1] not found\n" unless $_->[4] } }
    ' "$file"
}

pkg=${1:?usage: postprocess.sh pango|pangocairo}
cd "$(dirname "$0")/.."
file="$pkg/$pkg.odin"
[ -f "$file" ] || { echo "postprocess: $file not found" >&2; exit 2; }

case "$pkg" in
pango)
    # `typedef struct _PangoFoo PangoFoo` comes out as `Foo :: _PangoFoo` plus `_PangoFoo :: ...`:
    # drop the alias, rename the struct. gchar * is ^char (cstring). Macro constants runic emits
    # as backtick strings become Odin expressions. LogAttr, AttrSize and GlyphVisAttr have bit
    # fields and are declared by hand (pango/hand.odin): runic's one-byte placeholders are deleted,
    # so a regeneration that emits a real declaration of one fails to compile with a redeclaration.
    sed -i "$file" \
        -e 's/\^glib\.char/cstring/g' \
        -e 's/\[\^\]glib\.char/cstring/g' \
        -e '/^\(TYPE_\|LAYOUT_\|VERSION_\)/ {s/`//g; s/(//g; s/)//g; s/pango_//g; s/ *$//}' \
        -e '/^SCALE_/ {s/`//g; s/(double)//g}' \
        -e '/^GLYPH_/ {s/`//g; s/(PangoGlyph)//g}' \
        -e '/^ATTR_/ {s/`//g; s/(guint)//g; s/UINT_MAX/glib.MAXUINT/g}' \
        -e '/^ANALYSIS_/ s/`//g' \
        -e '/^ERROR ::/d' \
        -e 's/^VERSION :: .*/VERSION :: VERSION_MAJOR * 10000 + VERSION_MINOR * 100 + VERSION_MICRO/' \
        -e '/^\(RENDER_TYPE\|ENGINE_TYPE\)/ {s/`//g; s/\\//g}' \
        -e 's#^\([a-zA-Z][a-zA-Z_0-9]*\)\s*::\s*_Pango\1$##' \
        -e 's#^_Pango\([a-zA-Z][a-zA-Z_0-9]*\)\s*::\s*\(.*\)$#\1 :: \2#' \
        -e '/^\(LogAttr\|AttrSize\|GlyphVisAttr\) :: \[1\]i8$/d' \
        -e '/^    layout_get_log_attrs_readonly :: / s/-> \^LogAttr/-> [^]LogAttr/'
    # shellcheck disable=SC2086
    bit_sets "$file" "" $pango_flags
    retype "$file" <<'LIST'
list_faces_func_ptr_anon_0 faces ^^ ^[^]
list_sizes_func_ptr_anon_8 sizes ^^ ^[^]
list_families_func_ptr_anon_33 families ^^ ^[^]
et_features_func_ptr_anon_19 features ^ [^]
script_break_func_ptr_anon_39 attrs ^ [^]
Attribute.klass klass [^] ^
Analysis.extra_attrs extra_attrs [^] ^
GlyphItem.glyphs glyphs [^] ^
coverage_to_bytes bytes ^^ ^[^]
font_family_list_faces faces ^^ ^[^]
font_face_list_sizes sizes ^^ ^[^]
font_map_list_families families ^^ ^[^]
context_list_families families ^^ ^[^]
script_engine_list engines ^^ ^[^]
tab_array_get_tabs alignments ^^ ^[^]
tab_array_get_tabs locations ^^ ^[^]
layout_get_log_attrs attrs ^^ ^[^]
layout_line_get_x_ranges ranges ^^ ^[^]
LIST
    ;;
pangocairo)
    sed -i "$file" \
        -e 's/\^glib\.char/cstring/g' \
        -e 's/cairo\.cairo_t\b/cairo.context_t/g' \
        -e 's/cairo\.cairo_\([a-z_]*_t\)/cairo.\1/g' \
        -e '/^TYPE_/ {s/`//g; s/(//g; s/)//g; s/pango_cairo_//g; s/ *$//}' \
        -e 's#^\([a-zA-Z][a-zA-Z_0-9]*\)\s*::\s*_PangoCairo\1$##' \
        -e 's#^_PangoCairo\([a-zA-Z][a-zA-Z_0-9]*\)\s*::\s*\(.*\)$#\1 :: \2#'
    ;;
*)
    echo "postprocess: unknown package $pkg" >&2
    exit 2
    ;;
esac

