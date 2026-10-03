package pangocairo

import cairo "cairo:cairo"
import pango "pango:pango"

// Typed pins for the post-generation rules (docs/PATCHED.md). A regeneration that drops one
// fails to compile here.

// runic names cairo's context `cairo.cairo_t`; odin-cairo calls it `cairo.context_t`.
patched_update_context: proc "c" (cr: ^cairo.context_t, context_p: ^pango.Context) = update_context
patched_create_layout: proc "c" (cr: ^cairo.context_t) -> ^pango.Layout = create_layout

// Pointers to one object (glyphs, options), not multi-pointers.
@(private)
_pin_context_set_font_options: proc "c" (context_p: ^pango.Context, options: ^cairo.font_options_t) = context_set_font_options

@(private)
_pin_show_glyph_string: proc "c" (cr: ^cairo.context_t, font: ^pango.Font, glyphs: ^pango.GlyphString) = show_glyph_string
