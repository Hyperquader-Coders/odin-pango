# Decisions — odin-pango

Settled choices. An entry that stops being true is rewritten, not appended to.

## 1. Generated, not hand-written

The bindings are generated with runic from the headers Amber ships, so a library bump is a
regeneration. Hand fixes are the exception and are tracked in [PATCHED.md](PATCHED.md).

## 2. Flag enums are bit_sets, chosen by a list

C flag types are `bit_set[FooBit; u32]`, so callers write `{.SPACES, .IGNORABLES}`.
`postprocess.sh` rewrites the enums runic emits; the members of `FooBit` are bit indices, and the
type keeps the C size (4 bytes) and bits, so procedures take and return it by value unchanged. A
zero member is the constant `Foo{}` under its C name; a name with no underscore (`NONE`,
`DEFAULT`) gets the type's name as a prefix (`SHOW_FLAGS_NONE`), since constants share one
namespace. The list is the `<bitfield>` entries of Pango-1.0.gir: `FontMask`, `ShowFlags`,
`ShapeFlags`, `LayoutSerializeFlags` and `LayoutDeserializeFlags`. pangocairo has none. A new
GFlags type in a header bump is added to the list by hand; generation fails if a listed enum is
missing, negative or has no single-bit member. A value rule cannot tell them from plain enums:
`Gravity`, `Stretch` and `Underline` are also small integers starting at 0 and are not flags.

## 3. Bit-field structs are hand-written bit_fields, proven against C

runic cannot lay out C bit fields. `LogAttr`, `GlyphVisAttr` and `AttrSize` are declared by hand
in `pango/hand.odin` as Odin `bit_field`s with the exact C layout, because callers read them:
text editing reads `LogAttr` flags from `layout_get_log_attrs_readonly`, and a byte array offers
no field. The generated placeholders are deleted by `postprocess.sh`, so there is one
declaration. Rejected: byte arrays with accessor helpers (each caller would keep a private
copy of the layout, which is what amber-canvas did). The layout
holds because `scripts/bitfields.sh` derives it from the C compiler and `make ci` fails on a
difference. `LayoutLine` stays a byte array: Pango's accessors cover it.

## 4. Parameters are single objects unless declared

runic 0.8 writes `[^]T` for a pointer parameter whose C name ends in `s` (`settings`, `lines`),
however many elements it holds, which lets a caller index past one element, and drops a trailing
`va_list`, binding the procedure as `#c_vararg ..any`. Amber's runic fork (branch `amber-patched`)
has `parameters: declared`: with it every procedure parameter is `^T` (`T **` is `^^T`) unless
`arrays:` in the package's `rune.yml` lists it, chosen against the C headers, and a va_list
procedure is skipped. Struct members, variables and typedefs keep runic's name guess, and the
parameters of function-pointer types are plain `^T`: a limit of the fork, true in every binding.
Where a binding needs it, the `param_rules` table in `postprocess.sh` restores the `[^]` for
those parameters' real arrays, rewrites single-object struct members and corrects `T ***` outs;
a row that matches nothing fails the build. Rejected: rewriting the output in `postprocess.sh`,
which had to be told each parameter, matched `va_list` procedures by name pattern (it deleted
`list_store_insert_with_values` for containing `_va`) and was a second place to keep in step
with the headers. `scripts/check-generated.sh` stays as the guard that any regeneration, with
any runic, keeps the listed parameters right.
