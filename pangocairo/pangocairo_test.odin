#+test
package pangocairo

import "core:testing"

import cairo "cairo:cairo"
import glib "glib:glib"
import gobj "glib:gobject"
import pango "pango:pango"

@(test)
test_default_font_map_and_resolution :: proc(t: ^testing.T) {
    fm := font_map_get_default()
    testing.expect(t, fm != nil)
    font_map := (^FontMap)(fm)
    testing.expect_value(t, font_map_get_font_type(font_map), cairo.font_type_t.FT)

    ctx := font_map_create_context(font_map)
    defer gobj.object_unref(ctx)
    context_set_resolution(ctx, 144)
    testing.expect_value(t, context_get_resolution(ctx), 144)
}

@(test)
test_layout_on_image_surface :: proc(t: ^testing.T) {
    surface := cairo.image_surface_create(.ARGB32, 200, 60)
    defer cairo.surface_destroy(surface)
    testing.expect_value(t, cairo.surface_status(surface), cairo.status_t.SUCCESS)
    cr := cairo.create(surface)
    defer cairo.destroy(cr)

    layout := create_layout(cr)
    defer gobj.object_unref(layout)
    pango.layout_set_text(layout, "Amber", -1)
    update_layout(cr, layout)
    show_layout(cr, layout)
    testing.expect_value(t, string(pango.layout_get_text(layout)), "Amber")
    testing.expect_value(t, cairo.status(cr), cairo.status_t.SUCCESS)
}

// A layout of "Hello world": the bits Pango sets are the ones pango.LogAttr declares, read back
// through the [^]LogAttr it returns, indexed by character (pango's own tests have no font map to lay out with).
@(test)
test_layout_log_attrs_readonly :: proc(t: ^testing.T) {
    ctx := font_map_create_context((^FontMap)(font_map_get_default()))
    defer gobj.object_unref(ctx)
    layout := pango.layout_new(ctx)
    defer gobj.object_unref(layout)
    pango.layout_set_text(layout, "Hello world", -1)

    n: i32
    attrs := pango.layout_get_log_attrs_readonly(layout, &n)
    testing.expect_value(t, n, 12) // one more than the characters: the end position
    if attrs == nil || n != 12 do return
    log := attrs[:n]

    testing.expect(t, log[0].is_word_start)
    testing.expect(t, log[0].is_cursor_position)
    testing.expect(t, log[5].is_word_end)
    testing.expect(t, log[5].is_white)
    testing.expect(t, !log[5].is_word_start)
    testing.expect(t, log[6].is_word_start)
    testing.expect(t, log[6].is_line_break)
    testing.expect(t, !log[3].is_word_start)
    testing.expect(t, !log[3].is_white)
    testing.expect(t, log[3].is_cursor_position)
    testing.expect(t, log[11].is_word_end)
    testing.expect(t, log[11].is_cursor_position)
    testing.expect_value(t, log[3].reserved, 0)
}

// layout_get_log_attrs hands back a run through `PangoLogAttr **attrs` (^[^]LogAttr) and its length
// through `gint *n_attrs` (^i32); the cursor positions are one Rectangle each.
@(test)
test_layout_log_attrs_out_parameters :: proc(t: ^testing.T) {
    ctx := font_map_create_context((^FontMap)(font_map_get_default()))
    defer gobj.object_unref(ctx)
    layout := pango.layout_new(ctx)
    defer gobj.object_unref(layout)
    pango.layout_set_text(layout, "Hello world", -1)

    attrs: [^]pango.LogAttr
    n: i32
    pango.layout_get_log_attrs(layout, &attrs, &n)
    defer glib.free(attrs)
    testing.expect_value(t, n, 12)
    if attrs == nil || n != 12 do return
    testing.expect(t, attrs[0].is_word_start)
    testing.expect(t, attrs[6].is_word_start)

    strong, weak: pango.Rectangle
    pango.layout_get_cursor_pos(layout, 0, &strong, &weak)
    testing.expect_value(t, strong.x, 0)
}
