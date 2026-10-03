#+test
package pango

import "core:strconv"
import "core:strings"
import "core:testing"

// bitfields.txt is the output of scripts/bitfields.sh: the masks the C compiler gives each
// bit field, found by setting one field and reading the word back. `make check-bitfields`
// keeps it equal to a fresh C compile.
BITFIELDS :: #load("bitfields.txt", string)

// c_value looks a `Struct.field` up in bitfields.txt.
c_value :: proc(t: ^testing.T, name: string) -> (v: u64, ok: bool) {
    rest := BITFIELDS
    for line in strings.split_lines_iterator(&rest) {
        key, _, val := strings.partition(line, " ")
        if key == name do return strconv.parse_u64(val)
    }
    testing.expectf(t, false, "%s is not in bitfields.txt", name)
    return
}

expect_mask :: proc(t: ^testing.T, name: string, got: u32) {
    want, ok := c_value(t, name)
    if ok do testing.expectf(t, u64(got) == want, "%s: Odin mask %#x, C mask %#x", name, got, want)
}

expect_c :: proc(t: ^testing.T, name: string, got: int) {
    want, ok := c_value(t, name)
    if ok do testing.expectf(t, u64(got) == want, "%s: Odin %d, C %d", name, got, want)
}

@(test)
test_log_attr_layout_matches_c :: proc(t: ^testing.T) {
    expect_c(t, "LogAttr.size", size_of(LogAttr))
    a: LogAttr
    a = {}; a.is_line_break = true; expect_mask(t, "LogAttr.is_line_break", transmute(u32)a)
    a = {}; a.is_mandatory_break = true; expect_mask(t, "LogAttr.is_mandatory_break", transmute(u32)a)
    a = {}; a.is_char_break = true; expect_mask(t, "LogAttr.is_char_break", transmute(u32)a)
    a = {}; a.is_white = true; expect_mask(t, "LogAttr.is_white", transmute(u32)a)
    a = {}; a.is_cursor_position = true; expect_mask(t, "LogAttr.is_cursor_position", transmute(u32)a)
    a = {}; a.is_word_start = true; expect_mask(t, "LogAttr.is_word_start", transmute(u32)a)
    a = {}; a.is_word_end = true; expect_mask(t, "LogAttr.is_word_end", transmute(u32)a)
    a = {}; a.is_sentence_boundary = true; expect_mask(t, "LogAttr.is_sentence_boundary", transmute(u32)a)
    a = {}; a.is_sentence_start = true; expect_mask(t, "LogAttr.is_sentence_start", transmute(u32)a)
    a = {}; a.is_sentence_end = true; expect_mask(t, "LogAttr.is_sentence_end", transmute(u32)a)
    a = {}; a.backspace_deletes_character = true; expect_mask(t, "LogAttr.backspace_deletes_character", transmute(u32)a)
    a = {}; a.is_expandable_space = true; expect_mask(t, "LogAttr.is_expandable_space", transmute(u32)a)
    a = {}; a.is_word_boundary = true; expect_mask(t, "LogAttr.is_word_boundary", transmute(u32)a)
    a = {}; a.break_inserts_hyphen = true; expect_mask(t, "LogAttr.break_inserts_hyphen", transmute(u32)a)
    a = {}; a.break_removes_preceding = true; expect_mask(t, "LogAttr.break_removes_preceding", transmute(u32)a)
    a = {}; a.reserved = 0x1ffff; expect_mask(t, "LogAttr.reserved", transmute(u32)a)
}

@(test)
test_glyph_vis_attr_layout_matches_c :: proc(t: ^testing.T) {
    expect_c(t, "GlyphVisAttr.size", size_of(GlyphVisAttr))
    a: GlyphVisAttr
    a = {}; a.is_cluster_start = true; expect_mask(t, "GlyphVisAttr.is_cluster_start", transmute(u32)a)
    a = {}; a.is_color = true; expect_mask(t, "GlyphVisAttr.is_color", transmute(u32)a)
}

@(test)
test_attr_size_layout_matches_c :: proc(t: ^testing.T) {
    expect_c(t, "AttrSize.size", size_of(AttrSize))
    expect_c(t, "AttrSize.size_offset", int(offset_of(AttrSize, size)))
    a: AttrSize
    a.absolute = true
    word := (^u32)(rawptr(uintptr(&a) + uintptr(offset_of(AttrSize, size) + size_of(i32))))^
    expect_c(t, "AttrSize.absolute_word_offset", int(offset_of(AttrSize, size)) + size_of(i32))
    expect_mask(t, "AttrSize.absolute", word)
}
