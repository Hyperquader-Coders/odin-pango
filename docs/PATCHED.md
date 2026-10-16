# Patched bindings

The bindings are generated from the C headers by runic 0.8 in Amber's fork (`../runic`, branch `amber-patched`).
Regenerating overwrites hand fixes, so each is also pinned by a typed variable in the
package's `patched.odin`: a regeneration that drops a patch fails to compile there instead
of misbehaving at run time.

To regenerate, run `make generate` and then `make ci`.

## Generation rules

`scripts/postprocess.sh <pkg>` applies these to `<pkg>/<pkg>.odin`. They are odin-gtk's rules,
trimmed to what runic 0.8 produces from the system headers.

| package | rule | reason |
|---|---|---|
| `pango` | `^glib.char` and `[^]glib.char` become `cstring` | `gchar *` is a typedef'd char pointer, which runic leaves as a pointer to `char` |
| `pango` | backticks, parentheses, `pango_` prefixes and casts dropped from `TYPE_*`, `LAYOUT_*`, `VERSION_*`, `SCALE_*`, `GLYPH_*`, `ATTR_*`, `ANALYSIS_*`, `RENDER_TYPE_*`, `ENGINE_TYPE_*`, so `TYPE_FOO` names `foo_get_type` | macro text runic quotes as a string |
| `pango` | `UINT_MAX` becomes `glib.MAXUINT` | C limit macro |
| `pango` | `layout_get_log_attrs_readonly` returns `[^]LogAttr` | C `const PangoLogAttr *` points at a run, its length in `n_attrs`; runic writes `^LogAttr` and cannot write a multi-pointer for a return type |
| `pango` | `VERSION` becomes `VERSION_MAJOR * 10000 + VERSION_MINOR * 100 + VERSION_MICRO`; `ERROR` (`pango_layout_deserialize_error_quark ()`) is deleted | a quoted macro; the quark has its own procedure, `layout_deserialize_error_quark` |
| `pango` | `Foo :: _PangoFoo` is deleted and `_PangoFoo` becomes `Foo` | one name per struct |
| `pango` | the one-byte placeholders `LogAttr`, `AttrSize` and `GlyphVisAttr` (`rune.yml` overwrites) are deleted | these three are declared by hand in `pango/hand.odin`; a real declaration from a regeneration fails to compile with a redeclaration |
| `pango` | the GFlags enums listed in `postprocess.sh` (`pango_flags`) become `FooBit :: enum u32` of bit indices plus `Foo :: bit_set[FooBit; u32]`; zero members become constants of `Foo` | `{.SPACES, .IGNORABLES}` instead of integer ORs; the size and bits are those of C; see DECISIONS §2 |

## `pango`

`rune.yml` overwrites `LayoutLine`, which has bit fields, with a byte array of its x86_64 size
(32). Its fields are not reachable from Odin; use the accessor procedures. The pin is
`patched_layout_line` in `pango/patched.odin`; a test checks the size against `sizeof` of the C
struct.

Three structs with bit fields are declared by hand in `pango/hand.odin`, as Odin `bit_field`s in
GCC's x86_64 order (first field in the least significant bit):

- `LogAttr`: a `bit_field u32` of 15 `bool` flags and `reserved: u32 | 17`. A `[^]LogAttr` indexes
  like the C array: `layout_get_log_attrs_readonly` returns one (rewritten by `postprocess.sh`,
  pinned by `_pin_layout_get_log_attrs_readonly`), so `attrs[i].is_word_start`; slice it with
  the `n_attrs` it reports.
- `GlyphVisAttr`: `is_cluster_start` and `is_color` in a `bit_field u32`.
- `AttrSize`: a struct of `attr`, `size` and `absolute` (the bit in an anonymous `bit_field u32`,
  reached as `a.absolute`).

`rune.yml` overwrites the generated versions with one-byte placeholders that `postprocess.sh`
deletes, so a regeneration that emits one of these names with a real layout fails to compile with
a redeclaration. `scripts/bitfields.sh` compiles C against the headers, sets each field alone and
prints the mask the word takes; `pango/bitfields.txt` is its output, `make check-bitfields`
(part of `make ci`) keeps the two equal, and `pango/hand_test.odin` checks every Odin field's
mask, every size and the offsets of `AttrSize` against that file. The test in
`pangocairo/pangocairo_test.odin` lays out a string and reads `LogAttr`s from Pango.

HarfBuzz types are not bound here. Only `hb_font_t`, `hb_tag_t` and `hb_feature_t` appear in
Pango's signatures, and runic emits them as they are used.

## `pangocairo`

No hand-written code. `pangocairo/patched.odin` pins that `update_context` and `create_layout`
take odin-cairo's `cairo.context_t`, so a regeneration that loses the type rule fails to compile.

`FontMap` and `Font` are declared here as opaque structs, distinct from `pango.FontMap` and
`pango.Font`: PangoCairoFontMap and PangoCairoFont are GObject interfaces. `pangocairo.font_map_get_default` returns a `^pango.FontMap`; cast it to hand it to the
`font_map_` procedures declared here, as the tests do:
`(^pangocairo.FontMap)(pangocairo.font_map_get_default())`.

## Single-object parameters

| rule | why | pin |
|---|---|---|
| `parameters: declared` in both `rune.yml` files makes every procedure parameter `^T` unless `arrays:` lists it; callback typedefs and struct members are not covered, so `postprocess.sh` (`retype`) fixes the fields below. A pointer parameter or field whose name ends in `s` and whose C type is one object is `^T`, not `[^]T`: `glyphs` (`PangoGlyphString *`), `analysis`, `metrics`, `attrs` of `PangoAttrList`, `tabs`, `items` (`GList *`), `bytes` (`GBytes *`), `klass`, `pos` and `x_pos`, the `*_pos` rectangles, `n_*` counts (`int *`), `pos` of `skip_space` and the other scanners (`const char **`), and the `Attribute.klass`, `Analysis.extra_attrs` and `GlyphItem.glyphs` fields | runic writes `[^]T` for any such name, so a caller can index past one element. Read against the Pango headers | `_pin_layout_get_cursor_pos`, `_pin_glyph_string_extents`, `_pin_font_metrics_get_height`, `_pin_layout_set_attributes`, `_pin_skip_space`, `_pin_layout_get_log_attrs_readonly`, `_pin_attribute_klass`, `_pin_analysis_extra_attrs`, `_pin_glyph_item_glyphs`; in `pangocairo/patched.odin`, `_pin_show_glyph_string`, `_pin_context_set_font_options` |
| `T **` out-parameters that return a run, written `^[^]T` by `retype` in `postprocess.sh` (`parameters: declared` writes `^^T`; `arrays:` cannot say `^[^]T`) (`faces`, `sizes`, `families`, `engines`, `alignments`, `locations`, `ranges`, `bytes` of `coverage_to_bytes`, `attrs` of `layout_get_log_attrs`) are `^[^]T`; `extra_attrs` of `attr_iterator_get_font` (`GSList **`) is `^^glib.SList` | one out-parameter, holding a run or one pointer | `_pin_layout_get_log_attrs`, `_pin_font_map_list_families`, `_pin_tab_array_get_tabs`, `_pin_layout_line_get_x_ranges`, `_pin_coverage_to_bytes`, `_pin_attr_iterator_get_font` |

Listed under `arrays:` in `pango/rune.yml` (and, for the callbacks, rewritten by `retype`), each a real run: the `PangoLogAttr *attrs` of `break_`, `get_log_attrs`, `default_break`, `tailor_break`, `attr_break`, `glyph_string_index_to_x_full`, `shape_item`, `glyph_item_letter_space` and the script-break callback; `logical_widths` of `glyph_string_get_logical_widths` and `glyph_item_get_logical_widths`; `features` of `font_get_features`; `descs` of `font_descriptions_free`; `bytes` of `coverage_from_bytes`; the `GlyphString.glyphs`, `GlyphString.log_clusters` and `EngineInfo.scripts` fields. The whole list, with the `[^]` buffers kept, is in `scripts/check-generated.sh`, run by `make lint`.

## Out-parameters (`T **`)

runic writes `[^]^T` for some `T **` parameters; an out-parameter that returns one pointer must be `^^T`. Every `[^]^T` and `^[^]^T` in the generated output was read against the headers: none is a single-pointer out-parameter, so none is rewritten to `^^T`. `font_descriptions_free` `descs` (`PangoFontDescription **` with `n_descs`) is a counted vector and stays `[^]^FontDescription`; `font_map_list_families`, `font_family_list_faces`, `context_list_families` and the two callback types take `^[^]^T` out-arrays with a count, which stay. `scripts/check-generated.sh` fails on any `[^]^T` that is not in its `pointer_vectors` list, so a new one is noticed on the next `make generate`.
