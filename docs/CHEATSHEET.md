# odin-pango cheat sheet

One screen per job: the calls a program makes, in the order it makes them, and the few rules
worth remembering. Pango and PangoCairo have hundreds of declarations; this is the part a
program uses. Every name here is a public declaration in [API.md](API.md), and `make lint`
fails when one is not. Every code block is compiled against the binding before it is
committed. Drawing needs a cairo context: see the odin-cairo cheat sheet.

Conventions that hold everywhere: the `pango_` prefix is dropped, so `pango_layout_new` is
`pango.layout_new`, and `pango_cairo_show_layout` is `pangocairo.show_layout`; types are
`Layout`, `FontDescription`; enums are named by member, `.WRAP_WORD_CHAR`, `.ALIGN_LEFT`, `.BOLD`;
flag sets are `bit_set`s ([PATCHED](PATCHED.md#generation-rules)). Pango sizes are `i32`
(`c.int`) in Pango units, 1/1024 of a pixel or point.

## pango:pango — units, fonts and a layout

```odin
import "core:c"
import "core:math"
import "glib:gobject"
import "pango:pango"
import "pango:pangocairo"

px := 14.0
w := 300
n := pango.units_from_double(px)                           // pixels * pango.SCALE (1024) as an i32; units_to_double goes back

ctx := pango.font_map_create_context(pangocairo.font_map_get_default())  // the font map is shared: not yours
defer gobject.object_unref(ctx)                                          // the context is yours
lay := pango.layout_new(ctx)
defer gobject.object_unref(lay)                                          // so is the layout

desc := pango.font_description_from_string("Inter Bold")   // "Family Style Size"; yours until freed
pango.font_description_set_absolute_size(desc, math.round(px) * pango.SCALE)  // pixels; set_size takes points * SCALE
pango.font_description_set_weight(desc, .BOLD)
pango.layout_set_font_description(lay, desc)                // the layout copies it
pango.font_description_free(desc)                           // so free it now

text := "Hello, wörld"
pango.layout_set_text(lay, cstring(raw_data(text)), c.int(len(text)))   // the byte length, so no NUL is needed
pango.layout_set_width(lay, c.int(w) * pango.SCALE)         // -1 means no wrapping
pango.layout_set_wrap(lay, .WRAP_WORD_CHAR)
pango.layout_set_alignment(lay, .ALIGN_LEFT)
pango.layout_set_ellipsize(lay, .ELLIPSIZE_END)             // needs a width, or a height in lines
pango.layout_set_height(lay, -2)                            // negative: at most that many lines

pw, ph: c.int
pango.layout_get_pixel_size(lay, &pw, &ph)                  // already rounded to pixels
logical: pango.Rectangle
pango.layout_get_extents(lay, nil, &logical)                // Pango units; nil skips the ink rectangle
lines := pango.layout_get_line_count(lay)
```

| remember | |
|---|---|
| Two units | pixel sizes come from `layout_get_pixel_size`; everything else is Pango units, so multiply and divide by `pango.SCALE` |
| `FontDescription` is freed, `Layout` and `Context` are unreffed | `font_description_free`, `gobject.object_unref`; the default font map is neither |
| `set_text` wants the byte length | pass `c.int(len(s))` and an Odin string needs no terminator; `-1` reads to a NUL |
| Absolute size is pixels, plain size is points | use `set_absolute_size` for screen work and round it: glyph caches are keyed by size |

## pangocairo — drawing a layout

```odin
import "cairo:cairo"
import "core:c"
import "glib:gobject"
import "pango:pango"
import "pango:pangocairo"

surf := cairo.image_surface_create(.ARGB32, 300, 100)
defer cairo.surface_destroy(surf)
cr := cairo.create(surf)
defer cairo.destroy(cr)

lay := pangocairo.create_layout(cr)                 // a layout with cr's font options and resolution; yours
defer gobject.object_unref(lay)
pango.layout_set_text(lay, "Hello", -1)

cairo.set_source_rgba(cr, 1, 1, 1, 1)               // the text takes the current source
cairo.move_to(cr, 10, 10)                           // the layout's top left
pangocairo.show_layout(cr, lay)

pangocairo.update_layout(cr, lay)                   // after cr's transform or font options changed
cairo.save(cr)
cairo.scale(cr, 2, 2)
pangocairo.update_layout(cr, lay)
cairo.move_to(cr, 5, 5)
pangocairo.show_layout(cr, lay)
cairo.restore(cr)

ctx := pango.font_map_create_context(pangocairo.font_map_get_default())   // one context for many layouts
defer gobject.object_unref(ctx)
pangocairo.update_context(cr, ctx)                  // copy cr's resolution and options into it
other := pango.layout_new(ctx)
defer gobject.object_unref(other)

pangocairo.layout_path(cr, lay)                     // text as a path, to fill with a gradient or stroke
cairo.fill(cr)
```

| remember | |
|---|---|
| `show_layout` draws from the current point | `move_to` first; the point is the layout's top-left, not its baseline |
| Update when the transform changes | `update_layout` or `update_context` after a `scale`, a new surface or a changed font option, or the metrics are stale |
| `pangocairo.create_layout` takes a `cairo.context_t` | the odin-cairo type, [pinned](PATCHED.md#pangocairo) so a regeneration cannot lose it |
| `pangocairo.FontMap` is not `pango.FontMap` | `font_map_get_default` returns the `pango` one; the `font_map_` procedures declared in `pangocairo` take the other, so cast: `(^pangocairo.FontMap)(fm)` |
| Layout and context are unreffed, not freed | `gobject.object_unref`, once each; the context outlives its layouts |

## pango:pango — attributes and markup

```odin
import "core:c"
import "glib:glib"
import "glib:gobject"
import "pango:pango"
import "pango:pangocairo"

ctx := pango.font_map_create_context(pangocairo.font_map_get_default())
defer gobject.object_unref(ctx)
lay := pango.layout_new(ctx)
defer gobject.object_unref(lay)
pango.layout_set_text(lay, "Hello, world", -1)

list := pango.attr_list_new()
defer pango.attr_list_unref(list)                   // the layout takes its own reference below
bold := pango.attr_weight_new(.BOLD)
bold.start_index, bold.end_index = 0, 5             // byte offsets, c.uint; the default covers everything
pango.attr_list_insert(list, bold)                  // the list owns the attribute from here
pango.attr_list_insert(list, pango.attr_foreground_new(65535, 32768, 0))   // u16 channels, 0..65535
pango.attr_list_insert(list, pango.attr_underline_new(.SINGLE))
pango.layout_set_attributes(lay, list)

pango.layout_set_markup(lay, "<b>bold</b> <span foreground=\"#ff8800\">orange</span> &amp; more", -1)

raw := "a < b"
esc := glib.markup_escape_text(cstring(raw_data(raw)), glib.ssize(len(raw)))   // text that must not be read as markup
defer glib.free(rawptr(esc))                        // a new g_malloc'd string

attrs: ^pango.AttrList
plain: cstring
gerr: ^glib.Error
if pango.parse_markup("<i>x</i> y", -1, 0, &attrs, &plain, nil, &gerr) {   // the markup's attributes and plain text
	pango.attr_list_unref(attrs)
	glib.free(rawptr(plain))
} else {
	glib.error_free(gerr)
}
```

| remember | |
|---|---|
| `attr_list_insert` takes the attribute | never free an `attr_*_new` result you inserted; do unref the list you made |
| An attribute spans bytes, not characters | set `start_index` and `end_index` before inserting; the default is the whole text |
| `set_markup` replaces the text and the attributes | `set_text` keeps the attributes, so set the text first and the attribute list after |
| Markup is XML | escape `<`, `>` and `&` in text you did not write; `markup_escape_text` and `glib.free` the copy |
| Colours are `u16` | `attr_foreground_new(r, g, b)` takes 0..65535, where cairo takes 0..1 |

## pango:pango — carets, hit testing and log attributes

```odin
import "core:c"
import "glib:gobject"
import "pango:pango"
import "pango:pangocairo"

ctx := pango.font_map_create_context(pangocairo.font_map_get_default())
defer gobject.object_unref(ctx)
lay := pango.layout_new(ctx)
defer gobject.object_unref(lay)
pango.layout_set_text(lay, "two words", -1)

r: pango.Rectangle
pango.layout_get_cursor_pos(lay, 3, &r, nil)             // the strong caret at byte 3, in Pango units; nil skips the weak one
caret := f64(r.x) / pango.SCALE

idx, trail: c.int
inside := pango.layout_xy_to_index(lay, c.int(12.5 * pango.SCALE), 4 * pango.SCALE, &idx, &trail)   // idx is a byte; trail counts chars past it
pos: pango.Rectangle
pango.layout_index_to_pos(lay, idx, &pos)                // the character's box

n: c.int
p := pango.layout_get_log_attrs_readonly(lay, &n)        // borrowed from the layout; one per character plus one
attrs := p[:n]                                           // a [^]pango.LogAttr; index by character, not byte
starts_word := attrs[4].is_word_start                    // the 'w' of "words"

it := pango.layout_get_iter(lay)
defer pango.layout_iter_free(it)                         // an iterator is invalid once the layout changes
for {
	line := pango.layout_iter_get_line_readonly(it)      // borrowed; do not free
	start := pango.layout_line_get_start_index(line)
	length := pango.layout_line_get_length(line)
	ext: pango.Rectangle
	pango.layout_iter_get_line_extents(it, nil, &ext)    // the line's box, in Pango units
	if !pango.layout_iter_next_line(it) { break }
}
```

| remember | |
|---|---|
| `LogAttr` is a bit_field | read and set fields by name, `attrs[i].is_word_start`, `.is_line_break`, `.is_cursor_position`, `.backspace_deletes_character`; [hand-written and proven against C](PATCHED.md#pango) |
| `layout_get_log_attrs_readonly` returns `[^]LogAttr` | slice it with `n` (`p[:n]`); there is one more entry than characters |
| Indices are bytes, counts are characters | `xy_to_index`, `cursor_pos` and `index_to_pos` use byte offsets into the UTF-8; `trail` and `log_attrs` count characters |
| Hit testing takes Pango units | multiply pixels by `pango.SCALE` going in, divide coming out |
| `LayoutLine` has no fields | use `layout_line_get_*`; it is a byte array of the C struct's size |
