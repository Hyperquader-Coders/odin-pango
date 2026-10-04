#+test
package pango

import "core:strings"
import "core:testing"

import glib "glib:glib"
import gobj "glib:gobject"

// Version recorded in README.md: "**Bound version:** X.Y.Z".
README :: #load("../README.md", string)

bound_version :: proc() -> (major, minor, micro: int, ok: bool) {
    marker :: "**Bound version:** "
    readme := README
    i := strings.index(readme, marker)
    if i < 0 do return
    rest := readme[i + len(marker):]
    end := strings.index_any(rest, " \n")
    if end < 0 do return
    parts := strings.split(rest[:end], ".", context.temp_allocator)
    if len(parts) != 3 do return
    nums: [3]int
    for p, n in parts {
        v := 0
        if len(p) == 0 do return
        for c in p {
            if c < '0' || c > '9' do return
            v = v * 10 + int(c - '0')
        }
        nums[n] = v
    }
    return nums[0], nums[1], nums[2], true
}

@(test)
test_readme_version_matches_header_macros :: proc(t: ^testing.T) {
    major, minor, micro, ok := bound_version()
    testing.expect(t, ok, "README.md has no '**Bound version:** X.Y.Z'")
    testing.expect_value(t, major, VERSION_MAJOR)
    testing.expect_value(t, minor, VERSION_MINOR)
    testing.expect_value(t, micro, VERSION_MICRO)
}

@(test)
test_loaded_library_is_not_older_than_the_headers :: proc(t: ^testing.T) {
    testing.expect_value(t, version(), glib.int_(VERSION))
    testing.expect_value(t, string(version_string()), VERSION_STRING)
    testing.expect(
        t,
        version_check(VERSION_MAJOR, VERSION_MINOR, VERSION_MICRO) == nil,
        "version_check rejects the bound version",
    )
}

@(test)
test_patched_struct_sizes_match_c :: proc(t: ^testing.T) {
    // sizeof() of the C structs on x86_64, from a C compile against libpango1.0-dev.
    testing.expect_value(t, size_of(LayoutLine), 32)
}

@(test)
test_font_description_round_trip :: proc(t: ^testing.T) {
    desc := font_description_from_string("Sans Bold 12")
    defer font_description_free(desc)
    testing.expect_value(t, font_description_get_weight(desc), Weight.BOLD)
    testing.expect_value(t, font_description_get_size(desc), 12 * SCALE)
    testing.expect_value(t, string(font_description_get_family(desc)), "Sans")
}

@(test)
test_attr_list_and_language :: proc(t: ^testing.T) {
    list := attr_list_new()
    defer attr_list_unref(list)
    attr_list_insert(list, attr_weight_new(.BOLD))
    testing.expect(t, attr_list_get_attributes(list) != nil)

    lang := language_from_string("en-gb")
    testing.expect_value(t, string(language_to_string(lang)), "en-gb")
    testing.expect(t, bool(language_matches(lang, "en")))
}

@(test)
test_layout_text_round_trip :: proc(t: ^testing.T) {
    // A context without a font map still holds text; no font is loaded.
    ctx := gobj.object_new(context_get_type(), nil)
    defer gobj.object_unref(ctx)
    layout := layout_new((^Context)(ctx))
    defer gobj.object_unref(layout)
    layout_set_text(layout, "h\xc3\xa9llo", -1)
    testing.expect_value(t, string(layout_get_text(layout)), "h\xc3\xa9llo")
    testing.expect_value(t, layout_get_character_count(layout), 5)
}

// Flag enums are bit_sets of the C bits (docs/DECISIONS.md §2): the size is that of the C enum
// (4 bytes) and a member's index is the position of its bit in the header (pango-font.h, pango-attributes.h, pango-glyph.h, pango-layout.h).

bits :: proc(s: $S) -> u32 {
    return transmute(u32)s
}

@(test)
test_flag_sets_are_the_size_of_the_c_enum :: proc(t: ^testing.T) {
    testing.expect_value(t, size_of(FontMask), 4)
    testing.expect_value(t, size_of(ShowFlags), 4)
    testing.expect_value(t, size_of(ShapeFlags), 4)
    testing.expect_value(t, size_of(LayoutSerializeFlags), 4)
    testing.expect_value(t, size_of(LayoutDeserializeFlags), 4)
}

@(test)
test_flag_bits_match_the_header :: proc(t: ^testing.T) {
    testing.expect_value(t, bits(FontMask{.FAMILY}), 1 << 0)
    testing.expect_value(t, bits(FontMask{.STYLE}), 1 << 1)
    testing.expect_value(t, bits(FontMask{.VARIANT}), 1 << 2)
    testing.expect_value(t, bits(FontMask{.WEIGHT}), 1 << 3)
    testing.expect_value(t, bits(FontMask{.STRETCH}), 1 << 4)
    testing.expect_value(t, bits(FontMask{.SIZE}), 1 << 5)
    testing.expect_value(t, bits(FontMask{.GRAVITY}), 1 << 6)
    testing.expect_value(t, bits(FontMask{.VARIATIONS}), 1 << 7)
    testing.expect_value(t, bits(FontMask{.FAMILY, .VARIATIONS}), 0x81)
    testing.expect_value(t, bits(ShowFlags{.SPACES}), 1)
    testing.expect_value(t, bits(ShowFlags{.LINE_BREAKS}), 2)
    testing.expect_value(t, bits(ShowFlags{.IGNORABLES}), 4)
    testing.expect_value(t, bits(ShapeFlags{.ROUND_POSITIONS}), 1)
    testing.expect_value(t, bits(LayoutSerializeFlags{.CONTEXT}), 1)
    testing.expect_value(t, bits(LayoutSerializeFlags{.OUTPUT}), 2)
    testing.expect_value(t, bits(LayoutDeserializeFlags{.CONTEXT}), 1)
}

@(test)
test_zero_members_are_the_empty_set :: proc(t: ^testing.T) {
    testing.expect_value(t, SHOW_FLAGS_NONE, ShowFlags{})
    testing.expect_value(t, SHAPE_FLAGS_NONE, ShapeFlags{})
    testing.expect_value(t, LAYOUT_SERIALIZE_FLAGS_DEFAULT, LayoutSerializeFlags{})
    testing.expect_value(t, LAYOUT_DESERIALIZE_FLAGS_DEFAULT, LayoutDeserializeFlags{})
}
