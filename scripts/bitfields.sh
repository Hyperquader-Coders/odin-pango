#!/usr/bin/env bash
# Prints the C layout of the bit-field structs that pango/hand.odin declares by hand: for each
# field, the mask it occupies in the 32-bit word that holds it, found by setting that one field
# and reading the word back. `make check-bitfields` compares the output with
# pango/bitfields.txt, which pango's tests check the Odin declarations against.
# Usage: scripts/bitfields.sh [> pango/bitfields.txt]
set -euo pipefail

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

cat >"$tmp/bits.c" <<'C'
#include <pango/pango.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>

/* One field set (to all ones, 0x1ffff for the 17-bit field) in a zeroed struct; the 32-bit
   word at `off` is its mask. */
#define MASK(N, S, off, f, v) do { S x; unsigned w; memset(&x, 0, sizeof x); x.f = (v); \
    memcpy(&w, (char *)&x + (off), sizeof w); printf(#N "." #f " 0x%x\n", w); } while (0)

int main(void)
{
    printf("LogAttr.size %zu\n", sizeof(PangoLogAttr));
    MASK(LogAttr, PangoLogAttr, 0, is_line_break, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_mandatory_break, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_char_break, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_white, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_cursor_position, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_word_start, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_word_end, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_sentence_boundary, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_sentence_start, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_sentence_end, 1);
    MASK(LogAttr, PangoLogAttr, 0, backspace_deletes_character, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_expandable_space, 1);
    MASK(LogAttr, PangoLogAttr, 0, is_word_boundary, 1);
    MASK(LogAttr, PangoLogAttr, 0, break_inserts_hyphen, 1);
    MASK(LogAttr, PangoLogAttr, 0, break_removes_preceding, 1);
    MASK(LogAttr, PangoLogAttr, 0, reserved, 0x1ffff);

    printf("GlyphVisAttr.size %zu\n", sizeof(PangoGlyphVisAttr));
    MASK(GlyphVisAttr, PangoGlyphVisAttr, 0, is_cluster_start, 1);
    MASK(GlyphVisAttr, PangoGlyphVisAttr, 0, is_color, 1);

    printf("AttrSize.size %zu\n", sizeof(PangoAttrSize));
    printf("AttrSize.size_offset %zu\n", offsetof(PangoAttrSize, size));
    printf("AttrSize.absolute_word_offset %zu\n", offsetof(PangoAttrSize, size) + sizeof(int));
    MASK(AttrSize, PangoAttrSize, offsetof(PangoAttrSize, size) + sizeof(int), absolute, 1);
    return 0;
}
C

# shellcheck disable=SC2046
cc -Wall -o "$tmp/bits" "$tmp/bits.c" $(pkg-config --cflags pango)
"$tmp/bits"
