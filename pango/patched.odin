package pango

import glib "glib:glib"

// Typed pins for the hand-fixed declarations (docs/PATCHED.md). A regeneration that drops or
// changes one fails to compile here.

// runic cannot lay out bit-field structs. LogAttr, AttrSize and GlyphVisAttr are declared by
// hand in hand.odin; hand_test.odin checks them against the C structs. LayoutLine is a byte
// array of the x86_64 size, overwritten in rune.yml; a test checks the size.
patched_layout_line: [32]i8 = LayoutLine{}

// layout_get_log_attrs_readonly returns a run of LogAttr (length in n_attrs), a multi-pointer.
@(private)
_pin_layout_get_log_attrs_readonly: proc "c" (layout: ^Layout, n_attrs: ^glib.int_) -> [^]LogAttr = layout_get_log_attrs_readonly

// Pointers to one object, and the runs out-parameters return, are not multi-pointers (docs/PATCHED.md).
@(private)
_pin_coverage_to_bytes: proc "c" (coverage: ^Coverage, bytes: ^[^]glib.uchar, n_bytes: ^i32) = coverage_to_bytes

@(private)
_pin_font_metrics_get_height: proc "c" (metrics: ^FontMetrics) -> i32 = font_metrics_get_height

@(private)
_pin_attr_iterator_get_font: proc "c" (iterator: ^AttrIterator, desc: ^FontDescription, language: ^^Language, extra_attrs: ^^glib.SList) = attr_iterator_get_font

@(private)
_pin_font_map_list_families: proc "c" (fontmap: ^FontMap, families: ^[^]^FontFamily, n_families: ^i32) = font_map_list_families

@(private)
_pin_glyph_string_extents: proc "c" (glyphs: ^GlyphString, font: ^Font, ink_rect: ^Rectangle, logical_rect: ^Rectangle) = glyph_string_extents

@(private)
_pin_tab_array_get_tabs: proc "c" (tab_array: ^TabArray, alignments: ^[^]TabAlign, locations: ^[^]glib.int_) = tab_array_get_tabs

@(private)
_pin_layout_set_attributes: proc "c" (layout: ^Layout, attrs: ^AttrList) = layout_set_attributes

@(private)
_pin_layout_get_log_attrs: proc "c" (layout: ^Layout, attrs: ^[^]LogAttr, n_attrs: ^glib.int_) = layout_get_log_attrs

@(private)
_pin_layout_get_cursor_pos: proc "c" (layout: ^Layout, index_: i32, strong_pos: ^Rectangle, weak_pos: ^Rectangle) = layout_get_cursor_pos

@(private)
_pin_layout_line_get_x_ranges: proc "c" (line: ^LayoutLine, start_index: i32, end_index: i32, ranges: ^[^]i32, n_ranges: ^i32) = layout_line_get_x_ranges

@(private)
_pin_skip_space: proc "c" (pos: ^cstring) -> glib.boolean = skip_space

// Struct fields that hold one object.
@(private)
_pin_attribute_klass: ^AttrClass = Attribute{}.klass

@(private)
_pin_analysis_extra_attrs: ^glib.SList = Analysis{}.extra_attrs

@(private)
_pin_glyph_item_glyphs: ^GlyphString = GlyphItem{}.glyphs
