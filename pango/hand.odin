package pango

// Declarations runic cannot generate: structs with bit fields, laid out by hand as Odin
// bit_fields in GCC's x86_64 order (first field in the least significant bit). Listed in
// docs/PATCHED.md; hand_test.odin checks every field's mask against the C structs
// (scripts/bitfields.sh).

// PangoLogAttr: one per character of a layout, plus one for the position after the last, as
// returned by layout_get_log_attrs_readonly. A bit_field of 4 bytes, so [^]LogAttr indexes like
// the C array.
LogAttr :: bit_field u32 {
    is_line_break:               bool | 1,
    is_mandatory_break:          bool | 1,
    is_char_break:               bool | 1,
    is_white:                    bool | 1,
    is_cursor_position:          bool | 1,
    is_word_start:               bool | 1,
    is_word_end:                 bool | 1,
    is_sentence_boundary:        bool | 1,
    is_sentence_start:           bool | 1,
    is_sentence_end:             bool | 1,
    backspace_deletes_character: bool | 1,
    is_expandable_space:         bool | 1,
    is_word_boundary:            bool | 1,
    break_inserts_hyphen:        bool | 1,
    break_removes_preceding:     bool | 1,
    reserved:                    u32 | 17,
}

// PangoGlyphVisAttr: two flags in a word of four bytes.
GlyphVisAttr :: bit_field u32 {
    is_cluster_start: bool | 1,
    is_color:         bool | 1,
    _:                u32 | 30,
}

// PangoAttrSize: the attribute, the size, then a word that holds `absolute` and padding.
AttrSize :: struct {
    attr:    Attribute,
    size:    i32,
    using _: bit_field u32 {
        absolute: bool | 1,
        _:        u32 | 31,
    },
}
