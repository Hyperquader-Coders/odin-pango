#!/usr/bin/env bash
# Fails when one of runic 0.8's three known faults is back in the generated files. The fork
# (`parameters: declared`, skipped va_list procedures) prevents them; this proves it:
#   1. a #c_vararg procedure that stands for a C function taking a va_list (runic drops the
#      va_list and marks the procedure `#c_vararg ..any`, which is a wrong call);
#   2. a corrected parameter typed as runic wrote it (`[^]T` for a pointer to one object);
#   3. a `[^]^T` parameter (`T **` out-parameter for one pointer) that is not a listed vector.
# `scripts/check-generated.sh --list` prints the corrected parameters. Run by `make check-generated` (in `make lint`).
set -euo pipefail
cd "$(dirname "$0")/.."

# Procedures removed from the output because their C declaration takes a va_list.
removed_valist=""

# What a generic va_list procedure looks like, by its name or link_name.
valist_pattern='_valist|_va_list|vprintf|vsnprintf|vsprintf|vasprintf|_vfprintf|_logv|_vscanf'

# Corrected parameters, one per line: package, procedure (Struct.field for a struct field),
# parameter (-> for the return type), and what the type must start with:
#   ^      pointer to one object; runic wrote [^]T
#   ^^     out-parameter for one pointer (T **); runic wrote [^]^T
#   ^[^]   out-parameter for a run (T **, an array comes back); runic wrote [^]^T
#   [^]    a run (a byte buffer, a log-attr array) that runic wrote as ^T
# Every other [^] parameter whose name ends in "s" was read against the C header and is a run.
corrected() {
    cat <<'LIST'
pango list_faces_func_ptr_anon_0 faces ^[^]
pango list_faces_func_ptr_anon_0 n_faces ^
pango list_sizes_func_ptr_anon_8 sizes ^[^]
pango list_sizes_func_ptr_anon_8 n_sizes ^
pango et_features_func_ptr_anon_19 num_features ^
pango Attribute.klass klass ^
pango Analysis.extra_attrs extra_attrs ^
pango list_families_func_ptr_anon_33 families ^[^]
pango list_families_func_ptr_anon_33 n_families ^
pango script_break_func_ptr_anon_39 analysis ^
pango script_shape_func_ptr_anon_40 analysis ^
pango script_shape_func_ptr_anon_40 glyphs ^
pango GlyphItem.glyphs glyphs ^
pango draw_glyphs_func_ptr_anon_42 glyphs ^
pango coverage_to_bytes bytes ^[^]
pango coverage_to_bytes n_bytes ^
pango language_get_scripts num_scripts ^
pango font_metrics_ref metrics ^
pango font_metrics_unref metrics ^
pango font_metrics_get_ascent metrics ^
pango font_metrics_get_descent metrics ^
pango font_metrics_get_height metrics ^
pango font_metrics_get_approximate_char_width metrics ^
pango font_metrics_get_approximate_digit_width metrics ^
pango font_metrics_get_underline_position metrics ^
pango font_metrics_get_underline_thickness metrics ^
pango font_metrics_get_strikethrough_position metrics ^
pango font_metrics_get_strikethrough_thickness metrics ^
pango font_family_list_faces faces ^[^]
pango font_family_list_faces n_faces ^
pango font_face_list_sizes sizes ^[^]
pango font_face_list_sizes n_sizes ^
pango font_get_features num_features ^
pango font_deserialize bytes ^
pango attribute_init klass ^
pango attr_iterator_get_font extra_attrs ^^
pango reorder_items items ^
pango itemize attrs ^
pango itemize_with_base_dir attrs ^
pango break_ analysis ^
pango default_break analysis ^
pango tailor_break analysis ^
pango font_map_list_families families ^[^]
pango font_map_list_families n_families ^
pango context_list_families families ^[^]
pango context_list_families n_families ^
pango glyph_string_extents glyphs ^
pango glyph_string_get_width glyphs ^
pango glyph_string_extents_range glyphs ^
pango glyph_string_get_logical_widths glyphs ^
pango glyph_string_index_to_x glyphs ^
pango glyph_string_index_to_x analysis ^
pango glyph_string_index_to_x x_pos ^
pango glyph_string_x_to_index glyphs ^
pango glyph_string_x_to_index analysis ^
pango glyph_string_index_to_x_full glyphs ^
pango glyph_string_index_to_x_full analysis ^
pango glyph_string_index_to_x_full x_pos ^
pango shape analysis ^
pango shape glyphs ^
pango shape_full analysis ^
pango shape_full glyphs ^
pango shape_with_flags analysis ^
pango shape_with_flags glyphs ^
pango shape_item glyphs ^
pango script_engine_list engines ^[^]
pango script_engine_list n_engines ^
pango tab_array_get_tabs alignments ^[^]
pango tab_array_get_tabs locations ^[^]
pango layout_set_attributes attrs ^
pango layout_set_tabs tabs ^
pango layout_get_log_attrs attrs ^[^]
pango layout_get_log_attrs n_attrs ^
pango layout_get_log_attrs_readonly n_attrs ^
pango layout_index_to_pos pos ^
pango layout_index_to_line_x x_pos ^
pango layout_get_cursor_pos strong_pos ^
pango layout_get_cursor_pos weak_pos ^
pango layout_get_caret_pos strong_pos ^
pango layout_get_caret_pos weak_pos ^
pango layout_deserialize bytes ^
pango layout_line_index_to_x x_pos ^
pango layout_line_get_x_ranges ranges ^[^]
pango layout_line_get_x_ranges n_ranges ^
pango renderer_draw_glyphs glyphs ^
pango skip_space pos ^
pango scan_word pos ^
pango scan_string pos ^
pango scan_int pos ^
pango parse_enum possible_values ^
pango quantize_line_geometry thickness ^
pangocairo context_set_font_options options ^
pangocairo show_glyph_string glyphs ^
pangocairo glyph_string_path glyphs ^
pango layout_get_log_attrs_readonly -> [^]
LIST
}

if [ "${1:-}" = --list ]; then
    corrected
    exit 0
fi

fail=0

# 1. va_list procedures.
files=$(git ls-files '*.odin' | grep -Ev '(_test|/patched)\.odin$' || true)
[ -n "$files" ] || { echo "check-generated: no .odin files found" >&2; exit 2; }
# shellcheck disable=SC2086
hits=$(VALIST="$valist_pattern" REMOVED="$removed_valist" perl -ne '
    BEGIN { $re = $ENV{VALIST}; %gone = map { $_ => 1 } split " ", $ENV{REMOVED}; }
    $name = $1 if /^\s*(\w+) :: /;
    $link = $1 if /link_name = "(\w+)"/;
    if (/^\s*(\w+) :: / && $gone{$1}) { print "$ARGV:$.: $1 is a removed va_list procedure\n" }
    if (/#c_vararg/ && ($name =~ /$re/ || ($link // "") =~ /$re/)) {
        print "$ARGV:$.: $name takes a va_list and is bound as #c_vararg ..any\n" }
    $link = "" if /^\s*\w+ :: /;
    close ARGV if eof;
' $files)
if [ -n "$hits" ]; then
    echo "$hits"
    echo "check-generated: a va_list procedure must be skipped by runic; check ../runic is the amber-patched build"
    fail=1
fi

# 2. Corrected parameters.
while read -r pkg proc param want; do
    [ -n "$pkg" ] || continue
    file="$pkg/$pkg.odin"
    if ! msg=$(PROC="$proc" PARAM="$param" WANT="$want" perl -e '
        my ($proc, $param, $want) = @ENV{qw(PROC PARAM WANT)};
        my ($struct, $field) = split /\./, $proc;
        my $in = 0; my $seen = 0;
        while (<>) {
            if (defined $field) {
                $in = 1 if /^\Q$struct\E :: (?:#type )?struct/;
                if ($in && /^\}/) { $in = 0 }
                next unless $in && /^\s+\Q$field\E: (.*?),?\s*$/;
                $type = $1;
            } else {
                next unless /^\s*(?:\@\(.*?\)\s*)?\Q$proc\E :: /;
                if ($param eq "->") { next unless /-> (\S+)\s*(?:---)?\s*$/; $type = $1 }
                else { next unless /[(, ]\Q$param\E: ([^,)]+)/; $type = $1 }
            }
            $seen = 1;
            if (substr($type, 0, length $want) ne $want or ($want eq "^" and $type =~ /^\^[\[\^]/)) {
                print "$proc $param is typed $type, want $want\n"; exit 1 }
            last;
        }
        unless ($seen) { print "$proc $param not found\n"; exit 1 }
    ' "$file"); then
        echo "$file: $msg"
        fail=1
    fi
done < <(corrected | grep .)

# 3. A `[^]^T` parameter is runic's spelling of `T **`. It is right only for a counted vector of
# pointers; an out-parameter that returns one pointer is `^^T` (runic 0.8's third fault). Every
# such parameter was read against the C header; the vectors are listed here, one per line:
# procedure, parameter. A `^[^]^T` (the out-array itself) is not matched.
pointer_vectors() {
    cat <<'LIST'
font_descriptions_free descs
LIST
}
# shellcheck disable=SC2086
vec_hits=$(VECTORS="$(pointer_vectors | grep . || true)" perl -ne '
    BEGIN { for (split /\n/, $ENV{VECTORS}) { $ok{$_} = 1 } }
    $proc = $1 if /^\s*(\w+) :: /;
    while (/(?<![\^\w])(\w+): \[\^\]\^/g) {
        print "$ARGV:$.: $proc $1 is [^]^T; use ^^T for an out-parameter, or list it in pointer_vectors if it is a counted vector\n"
            unless $ok{"$proc $1"};
    }
    close ARGV if eof;
' $files)
if [ -n "$vec_hits" ]; then
    echo "$vec_hits"
    fail=1
fi

if [ "$fail" -ne 0 ]; then
    echo "check-generated: runic's output regressed; check rune.yml (parameters: declared) and run make generate"
    exit 1
fi
echo "check-generated: OK"
