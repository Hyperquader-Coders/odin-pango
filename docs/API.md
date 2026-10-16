# odin-pango API

Every public declaration of every package, generated from the source by `make api`; do not
edit. The reference is the [README](../README.md); the short form is the
[cheat sheet](CHEATSHEET.md).

## pango

```text
package pango
	constants
		ANALYSIS_FLAG_CENTERED_BASELINE :: 1 << 0
		ANALYSIS_FLAG_IS_ELLIPSIS :: 1 << 1
		ANALYSIS_FLAG_NEED_HYPHEN :: 1 << 2
		ATTR_INDEX_FROM_TEXT_BEGINNING :: 0
		ATTR_INDEX_TO_TEXT_END :: glib.MAXUINT + 0
		ENGINE_TYPE_LANG :: "PangoEngineLang"
		ENGINE_TYPE_SHAPE :: "PangoEngineShape"
		GLYPH_EMPTY :: 0x0FFFFFFF
		GLYPH_INVALID_INPUT :: 0xFFFFFFFF
		GLYPH_UNKNOWN_FLAG :: 0x10000000
		LAYOUT_DESERIALIZE_FLAGS_DEFAULT :: LayoutDeserializeFlags{}
		LAYOUT_SERIALIZE_FLAGS_DEFAULT :: LayoutSerializeFlags{}
		RENDER_TYPE_NONE :: "PangoRenderNone"
		SCALE :: 1024
		SCALE_LARGE :: 1.2
		SCALE_MEDIUM :: 1.0
		SCALE_SMALL :: 0.8333333333333
		SCALE_XX_LARGE :: 1.728
		SCALE_XX_SMALL :: 0.5787037037037
		SCALE_X_LARGE :: 1.44
		SCALE_X_SMALL :: 0.6944444444444
		SHAPE_FLAGS_NONE :: ShapeFlags{}
		SHOW_FLAGS_NONE :: ShowFlags{}
		UNKNOWN_GLYPH_HEIGHT :: 14
		UNKNOWN_GLYPH_WIDTH :: 10
		VERSION :: VERSION_MAJOR * 10000 + VERSION_MINOR * 100 + VERSION_MICRO
		VERSION_1_10 :: 1 << 16 | 10 << 8
		VERSION_1_12 :: 1 << 16 | 12 << 8
		VERSION_1_14 :: 1 << 16 | 14 << 8
		VERSION_1_16 :: 1 << 16 | 16 << 8
		VERSION_1_18 :: 1 << 16 | 18 << 8
		VERSION_1_2 :: 1 << 16 | 2 << 8
		VERSION_1_20 :: 1 << 16 | 20 << 8
		VERSION_1_22 :: 1 << 16 | 22 << 8
		VERSION_1_24 :: 1 << 16 | 24 << 8
		VERSION_1_26 :: 1 << 16 | 26 << 8
		VERSION_1_28 :: 1 << 16 | 28 << 8
		VERSION_1_30 :: 1 << 16 | 30 << 8
		VERSION_1_32 :: 1 << 16 | 32 << 8
		VERSION_1_34 :: 1 << 16 | 34 << 8
		VERSION_1_36 :: 1 << 16 | 36 << 8
		VERSION_1_38 :: 1 << 16 | 38 << 8
		VERSION_1_4 :: 1 << 16 | 4 << 8
		VERSION_1_40 :: 1 << 16 | 40 << 8
		VERSION_1_42 :: 1 << 16 | 42 << 8
		VERSION_1_44 :: 1 << 16 | 44 << 8
		VERSION_1_46 :: 1 << 16 | 46 << 8
		VERSION_1_48 :: 1 << 16 | 48 << 8
		VERSION_1_50 :: 1 << 16 | 50 << 8
		VERSION_1_52 :: 1 << 16 | 52 << 8
		VERSION_1_6 :: 1 << 16 | 6 << 8
		VERSION_1_8 :: 1 << 16 | 8 << 8
		VERSION_CUR_STABLE :: 1 << 16 | 52 << 8
		VERSION_MAJOR :: 1
		VERSION_MAX_ALLOWED :: 1 << 16 | 52 << 8
		VERSION_MICRO :: 1
		VERSION_MINOR :: 52
		VERSION_MIN_REQUIRED :: 1 << 16 | 52 << 8
		VERSION_PREV_STABLE :: 1 << 16 | 52 - 2 << 8
		VERSION_STRING :: "1.52.1"

	variables
		patched_layout_line: [32]i8 = LayoutLine{}
			runic cannot lay out bit-field structs. LogAttr, AttrSize and GlyphVisAttr are declared by
			hand in hand.odin; hand_test.odin checks them against the C structs. LayoutLine is a byte
			array of the x86_64 size, overwritten in rune.yml; a test checks the size.

	procedures
		alignment_get_type :: proc() -> gobj.Type ---
		alignment_get_type :: proc() -> gobj.Type ---
		attr_allow_breaks_new :: proc(allow_breaks: glib.boolean) -> ^Attribute ---
		attr_background_alpha_new :: proc(alpha: glib.uint16) -> ^Attribute ---
		attr_background_new :: proc(red: glib.uint16, green: glib.uint16, blue: glib.uint16) -> ^Attribute ---
		attr_baseline_shift_new :: proc(shift: i32) -> ^Attribute ---
		attr_break :: proc(text: cstring, length: i32, attr_list: ^AttrList, offset: i32, attrs: [^]LogAttr, attrs_len: i32) ---
		attr_fallback_new :: proc(enable_fallback: glib.boolean) -> ^Attribute ---
		attr_family_new :: proc(family: cstring) -> ^Attribute ---
		attr_font_desc_new :: proc(desc: ^FontDescription) -> ^Attribute ---
		attr_font_features_new :: proc(features: cstring) -> ^Attribute ---
		attr_font_scale_new :: proc(scale: FontScale) -> ^Attribute ---
		attr_foreground_alpha_new :: proc(alpha: glib.uint16) -> ^Attribute ---
		attr_foreground_new :: proc(red: glib.uint16, green: glib.uint16, blue: glib.uint16) -> ^Attribute ---
		attr_gravity_hint_new :: proc(hint: GravityHint) -> ^Attribute ---
		attr_gravity_new :: proc(gravity: Gravity) -> ^Attribute ---
		attr_insert_hyphens_new :: proc(insert_hyphens: glib.boolean) -> ^Attribute ---
		attr_iterator_copy :: proc(iterator: ^AttrIterator) -> ^AttrIterator ---
		attr_iterator_destroy :: proc(iterator: ^AttrIterator) ---
		attr_iterator_get :: proc(iterator: ^AttrIterator, type: AttrType) -> ^Attribute ---
		attr_iterator_get_attrs :: proc(iterator: ^AttrIterator) -> ^glib.SList ---
		attr_iterator_get_font :: proc(iterator: ^AttrIterator, desc: ^FontDescription, language: ^^Language, extra_attrs: ^^glib.SList) ---
		attr_iterator_get_type :: proc() -> gobj.Type ---
		attr_iterator_next :: proc(iterator: ^AttrIterator) -> glib.boolean ---
		attr_iterator_range :: proc(iterator: ^AttrIterator, start: ^i32, end: ^i32) ---
		attr_language_new :: proc(language: ^Language) -> ^Attribute ---
		attr_letter_spacing_new :: proc(letter_spacing: i32) -> ^Attribute ---
		attr_line_height_new :: proc(factor: f64) -> ^Attribute ---
		attr_line_height_new_absolute :: proc(height: i32) -> ^Attribute ---
		attr_list_change :: proc(list: ^AttrList, attr: ^Attribute) ---
		attr_list_copy :: proc(list: ^AttrList) -> ^AttrList ---
		attr_list_equal :: proc(list: ^AttrList, other_list: ^AttrList) -> glib.boolean ---
		attr_list_filter :: proc(list: ^AttrList, func: AttrFilterFunc, data: glib.pointer) -> ^AttrList ---
		attr_list_from_string :: proc(text: cstring) -> ^AttrList ---
		attr_list_get_attributes :: proc(list: ^AttrList) -> ^glib.SList ---
		attr_list_get_iterator :: proc(list: ^AttrList) -> ^AttrIterator ---
		attr_list_get_type :: proc() -> gobj.Type ---
		attr_list_get_type :: proc() -> gobj.Type ---
		attr_list_insert :: proc(list: ^AttrList, attr: ^Attribute) ---
		attr_list_insert_before :: proc(list: ^AttrList, attr: ^Attribute) ---
		attr_list_new :: proc() -> ^AttrList ---
		attr_list_ref :: proc(list: ^AttrList) -> ^AttrList ---
		attr_list_splice :: proc(list: ^AttrList, other: ^AttrList, pos: i32, len: i32) ---
		attr_list_to_string :: proc(list: ^AttrList) -> cstring ---
		attr_list_unref :: proc(list: ^AttrList) ---
		attr_list_update :: proc(list: ^AttrList, pos: i32, remove: i32, add: i32) ---
		attr_overline_color_new :: proc(red: glib.uint16, green: glib.uint16, blue: glib.uint16) -> ^Attribute ---
		attr_overline_new :: proc(overline: Overline) -> ^Attribute ---
		attr_rise_new :: proc(rise: i32) -> ^Attribute ---
		attr_scale_new :: proc(scale_factor: f64) -> ^Attribute ---
		attr_sentence_new :: proc() -> ^Attribute ---
		attr_shape_new :: proc(ink_rect: ^Rectangle, logical_rect: ^Rectangle) -> ^Attribute ---
		attr_shape_new_with_data :: proc(ink_rect: ^Rectangle, logical_rect: ^Rectangle, data: glib.pointer, copy_func: AttrDataCopyFunc, destroy_func: glib.DestroyNotify) -> ^Attribute ---
		attr_show_new :: proc(flags: ShowFlags) -> ^Attribute ---
		attr_size_new :: proc(size_p: i32) -> ^Attribute ---
		attr_size_new_absolute :: proc(size_p: i32) -> ^Attribute ---
		attr_stretch_new :: proc(stretch: Stretch) -> ^Attribute ---
		attr_strikethrough_color_new :: proc(red: glib.uint16, green: glib.uint16, blue: glib.uint16) -> ^Attribute ---
		attr_strikethrough_new :: proc(strikethrough: glib.boolean) -> ^Attribute ---
		attr_style_new :: proc(style: Style) -> ^Attribute ---
		attr_text_transform_new :: proc(transform: TextTransform) -> ^Attribute ---
		attr_type_get_name :: proc(type: AttrType) -> cstring ---
		attr_type_get_type :: proc() -> gobj.Type ---
		attr_type_get_type :: proc() -> gobj.Type ---
		attr_type_register :: proc(name: cstring) -> AttrType ---
		attr_underline_color_new :: proc(red: glib.uint16, green: glib.uint16, blue: glib.uint16) -> ^Attribute ---
		attr_underline_new :: proc(underline: Underline) -> ^Attribute ---
		attr_variant_new :: proc(variant: Variant) -> ^Attribute ---
		attr_weight_new :: proc(weight: Weight) -> ^Attribute ---
		attr_word_new :: proc() -> ^Attribute ---
		attribute_as_color :: proc(attr: ^Attribute) -> ^AttrColor ---
		attribute_as_float :: proc(attr: ^Attribute) -> ^AttrFloat ---
		attribute_as_font_desc :: proc(attr: ^Attribute) -> ^AttrFontDesc ---
		attribute_as_font_features :: proc(attr: ^Attribute) -> ^AttrFontFeatures ---
		attribute_as_int :: proc(attr: ^Attribute) -> ^AttrInt ---
		attribute_as_language :: proc(attr: ^Attribute) -> ^AttrLanguage ---
		attribute_as_shape :: proc(attr: ^Attribute) -> ^AttrShape ---
		attribute_as_size :: proc(attr: ^Attribute) -> ^AttrSize ---
		attribute_as_string :: proc(attr: ^Attribute) -> ^AttrString ---
		attribute_copy :: proc(attr: ^Attribute) -> ^Attribute ---
		attribute_destroy :: proc(attr: ^Attribute) ---
		attribute_equal :: proc(attr1: ^Attribute, attr2: ^Attribute) -> glib.boolean ---
		attribute_get_type :: proc() -> gobj.Type ---
		attribute_init :: proc(attr: ^Attribute, klass: ^AttrClass) ---
		baseline_shift_get_type :: proc() -> gobj.Type ---
		baseline_shift_get_type :: proc() -> gobj.Type ---
		bidi_type_for_unichar :: proc(ch: glib.unichar) -> BidiType ---
		bidi_type_get_type :: proc() -> gobj.Type ---
		bidi_type_get_type :: proc() -> gobj.Type ---
		break_ :: proc(text: cstring, length: i32, analysis: ^Analysis, attrs: [^]LogAttr, attrs_len: i32) ---
		color_copy :: proc(src: ^Color) -> ^Color ---
		color_free :: proc(color: ^Color) ---
		color_get_type :: proc() -> gobj.Type ---
		color_get_type :: proc() -> gobj.Type ---
		color_parse :: proc(color: ^Color, spec: cstring) -> glib.boolean ---
		color_parse_with_alpha :: proc(color: ^Color, alpha: ^glib.uint16, spec: cstring) -> glib.boolean ---
		color_to_string :: proc(color: ^Color) -> cstring ---
		context_changed :: proc(context_p: ^Context) ---
		context_get_base_dir :: proc(context_p: ^Context) -> Direction ---
		context_get_base_gravity :: proc(context_p: ^Context) -> Gravity ---
		context_get_font_description :: proc(context_p: ^Context) -> ^FontDescription ---
		context_get_font_map :: proc(context_p: ^Context) -> ^FontMap ---
		context_get_gravity :: proc(context_p: ^Context) -> Gravity ---
		context_get_gravity_hint :: proc(context_p: ^Context) -> GravityHint ---
		context_get_language :: proc(context_p: ^Context) -> ^Language ---
		context_get_matrix :: proc(context_p: ^Context) -> ^Matrix ---
		context_get_metrics :: proc(context_p: ^Context, desc: ^FontDescription, language: ^Language) -> ^FontMetrics ---
		context_get_round_glyph_positions :: proc(context_p: ^Context) -> glib.boolean ---
		context_get_serial :: proc(context_p: ^Context) -> glib.uint_ ---
		context_get_type :: proc() -> gobj.Type ---
		context_get_type :: proc() -> gobj.Type ---
		context_list_families :: proc(context_p: ^Context, families: ^[^]^FontFamily, n_families: ^i32) ---
		context_load_font :: proc(context_p: ^Context, desc: ^FontDescription) -> ^Font ---
		context_load_fontset :: proc(context_p: ^Context, desc: ^FontDescription, language: ^Language) -> ^Fontset ---
		context_new :: proc() -> ^Context ---
		context_set_base_dir :: proc(context_p: ^Context, direction: Direction) ---
		context_set_base_gravity :: proc(context_p: ^Context, gravity: Gravity) ---
		context_set_font_description :: proc(context_p: ^Context, desc: ^FontDescription) ---
		context_set_font_map :: proc(context_p: ^Context, font_map: ^FontMap) ---
		context_set_gravity_hint :: proc(context_p: ^Context, hint: GravityHint) ---
		context_set_language :: proc(context_p: ^Context, language: ^Language) ---
		context_set_matrix :: proc(context_p: ^Context, matrix_p: ^Matrix) ---
		context_set_round_glyph_positions :: proc(context_p: ^Context, round_positions: glib.boolean) ---
		coverage_copy :: proc(coverage: ^Coverage) -> ^Coverage ---
		coverage_from_bytes :: proc(bytes: [^]glib.uchar, n_bytes: i32) -> ^Coverage ---
		coverage_get :: proc(coverage: ^Coverage, index_: i32) -> CoverageLevel ---
		coverage_get_type :: proc() -> gobj.Type ---
		coverage_level_get_type :: proc() -> gobj.Type ---
		coverage_level_get_type :: proc() -> gobj.Type ---
		coverage_max :: proc(coverage: ^Coverage, other: ^Coverage) ---
		coverage_new :: proc() -> ^Coverage ---
		coverage_ref :: proc(coverage: ^Coverage) -> ^Coverage ---
		coverage_set :: proc(coverage: ^Coverage, index_: i32, level: CoverageLevel) ---
		coverage_to_bytes :: proc(coverage: ^Coverage, bytes: ^[^]glib.uchar, n_bytes: ^i32) ---
		coverage_unref :: proc(coverage: ^Coverage) ---
		default_break :: proc(text: cstring, length: i32, analysis: ^Analysis, attrs: [^]LogAttr, attrs_len: i32) ---
		direction_get_type :: proc() -> gobj.Type ---
		direction_get_type :: proc() -> gobj.Type ---
		ellipsize_mode_get_type :: proc() -> gobj.Type ---
		ellipsize_mode_get_type :: proc() -> gobj.Type ---
		engine_get_type :: proc() -> gobj.Type ---
		engine_get_type :: proc() -> gobj.Type ---
		engine_lang_get_type :: proc() -> gobj.Type ---
		engine_lang_get_type :: proc() -> gobj.Type ---
		engine_shape_get_type :: proc() -> gobj.Type ---
		engine_shape_get_type :: proc() -> gobj.Type ---
		extents_to_pixels :: proc(inclusive: ^Rectangle, nearest: ^Rectangle) ---
		find_base_dir :: proc(text: cstring, length: glib.int_) -> Direction ---
		find_paragraph_boundary :: proc(text: cstring, length: i32, paragraph_delimiter_index: ^i32, next_paragraph_start: ^i32) ---
		font_describe :: proc(font: ^Font) -> ^FontDescription ---
		font_describe_with_absolute_size :: proc(font: ^Font) -> ^FontDescription ---
		font_description_better_match :: proc(desc: ^FontDescription, old_match: ^FontDescription, new_match: ^FontDescription) -> glib.boolean ---
		font_description_copy :: proc(desc: ^FontDescription) -> ^FontDescription ---
		font_description_copy_static :: proc(desc: ^FontDescription) -> ^FontDescription ---
		font_description_equal :: proc(desc1: ^FontDescription, desc2: ^FontDescription) -> glib.boolean ---
		font_description_free :: proc(desc: ^FontDescription) ---
		font_description_from_string :: proc(str: cstring) -> ^FontDescription ---
		font_description_get_family :: proc(desc: ^FontDescription) -> cstring ---
		font_description_get_gravity :: proc(desc: ^FontDescription) -> Gravity ---
		font_description_get_set_fields :: proc(desc: ^FontDescription) -> FontMask ---
		font_description_get_size :: proc(desc: ^FontDescription) -> glib.int_ ---
		font_description_get_size_is_absolute :: proc(desc: ^FontDescription) -> glib.boolean ---
		font_description_get_stretch :: proc(desc: ^FontDescription) -> Stretch ---
		font_description_get_style :: proc(desc: ^FontDescription) -> Style ---
		font_description_get_type :: proc() -> gobj.Type ---
		font_description_get_type :: proc() -> gobj.Type ---
		font_description_get_variant :: proc(desc: ^FontDescription) -> Variant ---
		font_description_get_variations :: proc(desc: ^FontDescription) -> cstring ---
		font_description_get_weight :: proc(desc: ^FontDescription) -> Weight ---
		font_description_hash :: proc(desc: ^FontDescription) -> glib.uint_ ---
		font_description_merge :: proc(desc: ^FontDescription, desc_to_merge: ^FontDescription, replace_existing: glib.boolean) ---
		font_description_merge_static :: proc(desc: ^FontDescription, desc_to_merge: ^FontDescription, replace_existing: glib.boolean) ---
		font_description_new :: proc() -> ^FontDescription ---
		font_description_set_absolute_size :: proc(desc: ^FontDescription, size_p: f64) ---
		font_description_set_family :: proc(desc: ^FontDescription, family: cstring) ---
		font_description_set_family_static :: proc(desc: ^FontDescription, family: cstring) ---
		font_description_set_gravity :: proc(desc: ^FontDescription, gravity: Gravity) ---
		font_description_set_size :: proc(desc: ^FontDescription, size_p: glib.int_) ---
		font_description_set_stretch :: proc(desc: ^FontDescription, stretch: Stretch) ---
		font_description_set_style :: proc(desc: ^FontDescription, style: Style) ---
		font_description_set_variant :: proc(desc: ^FontDescription, variant: Variant) ---
		font_description_set_variations :: proc(desc: ^FontDescription, variations: cstring) ---
		font_description_set_variations_static :: proc(desc: ^FontDescription, variations: cstring) ---
		font_description_set_weight :: proc(desc: ^FontDescription, weight: Weight) ---
		font_description_to_filename :: proc(desc: ^FontDescription) -> cstring ---
		font_description_to_string :: proc(desc: ^FontDescription) -> cstring ---
		font_description_unset_fields :: proc(desc: ^FontDescription, to_unset: FontMask) ---
		font_descriptions_free :: proc(descs: [^]^FontDescription, n_descs: i32) ---
		font_deserialize :: proc(context_p: ^Context, bytes: ^glib.Bytes, error: ^^glib.Error) -> ^Font ---
		font_face_describe :: proc(face: ^FontFace) -> ^FontDescription ---
		font_face_get_face_name :: proc(face: ^FontFace) -> cstring ---
		font_face_get_family :: proc(face: ^FontFace) -> ^FontFamily ---
		font_face_get_type :: proc() -> gobj.Type ---
		font_face_get_type :: proc() -> gobj.Type ---
		font_face_is_synthesized :: proc(face: ^FontFace) -> glib.boolean ---
		font_face_list_sizes :: proc(face: ^FontFace, sizes: ^[^]i32, n_sizes: ^i32) ---
		font_family_get_face :: proc(family: ^FontFamily, name: cstring) -> ^FontFace ---
		font_family_get_name :: proc(family: ^FontFamily) -> cstring ---
		font_family_get_type :: proc() -> gobj.Type ---
		font_family_get_type :: proc() -> gobj.Type ---
		font_family_is_monospace :: proc(family: ^FontFamily) -> glib.boolean ---
		font_family_is_variable :: proc(family: ^FontFamily) -> glib.boolean ---
		font_family_list_faces :: proc(family: ^FontFamily, faces: ^[^]^FontFace, n_faces: ^i32) ---
		font_find_shaper :: proc(font: ^Font, language: ^Language, ch: glib.uint32) -> ^EngineShape ---
		font_get_coverage :: proc(font: ^Font, language: ^Language) -> ^Coverage ---
		font_get_face :: proc(font: ^Font) -> ^FontFace ---
		font_get_features :: proc(font: ^Font, features: [^]hb_feature_t, len: glib.uint_, num_features: ^glib.uint_) ---
		font_get_font_map :: proc(font: ^Font) -> ^FontMap ---
		font_get_glyph_extents :: proc(font: ^Font, glyph: Glyph, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		font_get_hb_font :: proc(font: ^Font) -> ^hb_font_t ---
		font_get_languages :: proc(font: ^Font) -> ^^Language ---
		font_get_metrics :: proc(font: ^Font, language: ^Language) -> ^FontMetrics ---
		font_get_type :: proc() -> gobj.Type ---
		font_get_type :: proc() -> gobj.Type ---
		font_has_char :: proc(font: ^Font, wc: glib.unichar) -> glib.boolean ---
		font_map_changed :: proc(fontmap: ^FontMap) ---
		font_map_create_context :: proc(fontmap: ^FontMap) -> ^Context ---
		font_map_get_family :: proc(fontmap: ^FontMap, name: cstring) -> ^FontFamily ---
		font_map_get_serial :: proc(fontmap: ^FontMap) -> glib.uint_ ---
		font_map_get_type :: proc() -> gobj.Type ---
		font_map_get_type :: proc() -> gobj.Type ---
		font_map_list_families :: proc(fontmap: ^FontMap, families: ^[^]^FontFamily, n_families: ^i32) ---
		font_map_load_font :: proc(fontmap: ^FontMap, context_p: ^Context, desc: ^FontDescription) -> ^Font ---
		font_map_load_fontset :: proc(fontmap: ^FontMap, context_p: ^Context, desc: ^FontDescription, language: ^Language) -> ^Fontset ---
		font_map_reload_font :: proc(fontmap: ^FontMap, font: ^Font, scale: f64, context_p: ^Context, variations: cstring) -> ^Font ---
		font_mask_get_type :: proc() -> gobj.Type ---
		font_mask_get_type :: proc() -> gobj.Type ---
		font_metrics_get_approximate_char_width :: proc(metrics: ^FontMetrics) -> i32 ---
		font_metrics_get_approximate_digit_width :: proc(metrics: ^FontMetrics) -> i32 ---
		font_metrics_get_ascent :: proc(metrics: ^FontMetrics) -> i32 ---
		font_metrics_get_descent :: proc(metrics: ^FontMetrics) -> i32 ---
		font_metrics_get_height :: proc(metrics: ^FontMetrics) -> i32 ---
		font_metrics_get_strikethrough_position :: proc(metrics: ^FontMetrics) -> i32 ---
		font_metrics_get_strikethrough_thickness :: proc(metrics: ^FontMetrics) -> i32 ---
		font_metrics_get_type :: proc() -> gobj.Type ---
		font_metrics_get_type :: proc() -> gobj.Type ---
		font_metrics_get_underline_position :: proc(metrics: ^FontMetrics) -> i32 ---
		font_metrics_get_underline_thickness :: proc(metrics: ^FontMetrics) -> i32 ---
		font_metrics_ref :: proc(metrics: ^FontMetrics) -> ^FontMetrics ---
		font_metrics_unref :: proc(metrics: ^FontMetrics) ---
		font_scale_get_type :: proc() -> gobj.Type ---
		font_scale_get_type :: proc() -> gobj.Type ---
		font_serialize :: proc(font: ^Font) -> ^glib.Bytes ---
		fontset_foreach :: proc(fontset: ^Fontset, func: FontsetForeachFunc, data: glib.pointer) ---
		fontset_get_font :: proc(fontset: ^Fontset, wc: glib.uint_) -> ^Font ---
		fontset_get_metrics :: proc(fontset: ^Fontset) -> ^FontMetrics ---
		fontset_get_type :: proc() -> gobj.Type ---
		fontset_get_type :: proc() -> gobj.Type ---
		fontset_simple_append :: proc(fontset: ^FontsetSimple, font: ^Font) ---
		fontset_simple_get_type :: proc() -> gobj.Type ---
		fontset_simple_get_type :: proc() -> gobj.Type ---
		fontset_simple_new :: proc(language: ^Language) -> ^FontsetSimple ---
		fontset_simple_size :: proc(fontset: ^FontsetSimple) -> i32 ---
		get_log_attrs :: proc(text: cstring, length: i32, level: i32, language: ^Language, attrs: [^]LogAttr, attrs_len: i32) ---
		get_mirror_char :: proc(ch: glib.unichar, mirrored_ch: ^glib.unichar) -> glib.boolean ---
		glyph_item_apply_attrs :: proc(glyph_item: ^GlyphItem, text: cstring, list: ^AttrList) -> ^glib.SList ---
		glyph_item_copy :: proc(orig: ^GlyphItem) -> ^GlyphItem ---
		glyph_item_free :: proc(glyph_item: ^GlyphItem) ---
		glyph_item_get_logical_widths :: proc(glyph_item: ^GlyphItem, text: cstring, logical_widths: [^]i32) ---
		glyph_item_get_type :: proc() -> gobj.Type ---
		glyph_item_get_type :: proc() -> gobj.Type ---
		glyph_item_iter_copy :: proc(orig: ^GlyphItemIter) -> ^GlyphItemIter ---
		glyph_item_iter_free :: proc(iter: ^GlyphItemIter) ---
		glyph_item_iter_get_type :: proc() -> gobj.Type ---
		glyph_item_iter_get_type :: proc() -> gobj.Type ---
		glyph_item_iter_init_end :: proc(iter: ^GlyphItemIter, glyph_item: ^GlyphItem, text: cstring) -> glib.boolean ---
		glyph_item_iter_init_start :: proc(iter: ^GlyphItemIter, glyph_item: ^GlyphItem, text: cstring) -> glib.boolean ---
		glyph_item_iter_next_cluster :: proc(iter: ^GlyphItemIter) -> glib.boolean ---
		glyph_item_iter_prev_cluster :: proc(iter: ^GlyphItemIter) -> glib.boolean ---
		glyph_item_letter_space :: proc(glyph_item: ^GlyphItem, text: cstring, log_attrs: [^]LogAttr, letter_spacing: i32) ---
		glyph_item_split :: proc(orig: ^GlyphItem, text: cstring, split_index: i32) -> ^GlyphItem ---
		glyph_string_copy :: proc(string_p: ^GlyphString) -> ^GlyphString ---
		glyph_string_extents :: proc(glyphs: ^GlyphString, font: ^Font, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		glyph_string_extents_range :: proc(glyphs: ^GlyphString, start: i32, end: i32, font: ^Font, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		glyph_string_free :: proc(string_p: ^GlyphString) ---
		glyph_string_get_logical_widths :: proc(glyphs: ^GlyphString, text: cstring, length: i32, embedding_level: i32, logical_widths: [^]i32) ---
		glyph_string_get_type :: proc() -> gobj.Type ---
		glyph_string_get_type :: proc() -> gobj.Type ---
		glyph_string_get_width :: proc(glyphs: ^GlyphString) -> i32 ---
		glyph_string_index_to_x :: proc(glyphs: ^GlyphString, text: cstring, length: i32, analysis: ^Analysis, index_: i32, trailing: glib.boolean, x_pos: ^i32) ---
		glyph_string_index_to_x_full :: proc(glyphs: ^GlyphString, text: cstring, length: i32, analysis: ^Analysis, attrs: [^]LogAttr, index_: i32, trailing: glib.boolean, x_pos: ^i32) ---
		glyph_string_new :: proc() -> ^GlyphString ---
		glyph_string_set_size :: proc(string_p: ^GlyphString, new_len: i32) ---
		glyph_string_x_to_index :: proc(glyphs: ^GlyphString, text: cstring, length: i32, analysis: ^Analysis, x_pos: i32, index_: ^i32, trailing: ^i32) ---
		gravity_get_for_matrix :: proc(matrix_p: ^Matrix) -> Gravity ---
		gravity_get_for_script :: proc(script: Script, base_gravity: Gravity, hint: GravityHint) -> Gravity ---
		gravity_get_for_script_and_width :: proc(script: Script, wide: glib.boolean, base_gravity: Gravity, hint: GravityHint) -> Gravity ---
		gravity_get_type :: proc() -> gobj.Type ---
		gravity_get_type :: proc() -> gobj.Type ---
		gravity_hint_get_type :: proc() -> gobj.Type ---
		gravity_hint_get_type :: proc() -> gobj.Type ---
		gravity_to_rotation :: proc(gravity: Gravity) -> f64 ---
		is_zero_width :: proc(ch: glib.unichar) -> glib.boolean ---
		item_apply_attrs :: proc(item: ^Item, iter: ^AttrIterator) ---
		item_copy :: proc(item: ^Item) -> ^Item ---
		item_free :: proc(item: ^Item) ---
		item_get_type :: proc() -> gobj.Type ---
		item_get_type :: proc() -> gobj.Type ---
		item_new :: proc() -> ^Item ---
		item_split :: proc(orig: ^Item, split_index: i32, split_offset: i32) -> ^Item ---
		itemize :: proc(context_p: ^Context, text: cstring, start_index: i32, length: i32, attrs: ^AttrList, cached_iter: ^AttrIterator) -> ^glib.List ---
		itemize_with_base_dir :: proc(context_p: ^Context, base_dir: Direction, text: cstring, start_index: i32, length: i32, attrs: ^AttrList, cached_iter: ^AttrIterator) -> ^glib.List ---
		language_from_string :: proc(language: cstring) -> ^Language ---
		language_get_default :: proc() -> ^Language ---
		language_get_preferred :: proc() -> ^^Language ---
		language_get_sample_string :: proc(language: ^Language) -> cstring ---
		language_get_scripts :: proc(language: ^Language, num_scripts: ^i32) -> ^Script ---
		language_get_type :: proc() -> gobj.Type ---
		language_get_type :: proc() -> gobj.Type ---
		language_includes_script :: proc(language: ^Language, script: Script) -> glib.boolean ---
		language_matches :: proc(language: ^Language, range_list: cstring) -> glib.boolean ---
		language_to_string :: proc(language: ^Language) -> cstring ---
		layout_context_changed :: proc(layout: ^Layout) ---
		layout_copy :: proc(src: ^Layout) -> ^Layout ---
		layout_deserialize :: proc(context_p: ^Context, bytes: ^glib.Bytes, flags: LayoutDeserializeFlags, error: ^^glib.Error) -> ^Layout ---
		layout_deserialize_error_get_type :: proc() -> gobj.Type ---
		layout_deserialize_error_get_type :: proc() -> gobj.Type ---
		layout_deserialize_error_quark :: proc() -> glib.Quark ---
		layout_deserialize_flags_get_type :: proc() -> gobj.Type ---
		layout_deserialize_flags_get_type :: proc() -> gobj.Type ---
		layout_get_alignment :: proc(layout: ^Layout) -> Alignment ---
		layout_get_attributes :: proc(layout: ^Layout) -> ^AttrList ---
		layout_get_auto_dir :: proc(layout: ^Layout) -> glib.boolean ---
		layout_get_baseline :: proc(layout: ^Layout) -> i32 ---
		layout_get_caret_pos :: proc(layout: ^Layout, index_: i32, strong_pos: ^Rectangle, weak_pos: ^Rectangle) ---
		layout_get_character_count :: proc(layout: ^Layout) -> glib.int_ ---
		layout_get_context :: proc(layout: ^Layout) -> ^Context ---
		layout_get_cursor_pos :: proc(layout: ^Layout, index_: i32, strong_pos: ^Rectangle, weak_pos: ^Rectangle) ---
		layout_get_direction :: proc(layout: ^Layout, index: i32) -> Direction ---
		layout_get_ellipsize :: proc(layout: ^Layout) -> EllipsizeMode ---
		layout_get_extents :: proc(layout: ^Layout, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		layout_get_font_description :: proc(layout: ^Layout) -> ^FontDescription ---
		layout_get_height :: proc(layout: ^Layout) -> i32 ---
		layout_get_indent :: proc(layout: ^Layout) -> i32 ---
		layout_get_iter :: proc(layout: ^Layout) -> ^LayoutIter ---
		layout_get_justify :: proc(layout: ^Layout) -> glib.boolean ---
		layout_get_justify_last_line :: proc(layout: ^Layout) -> glib.boolean ---
		layout_get_line :: proc(layout: ^Layout, line: i32) -> ^LayoutLine ---
		layout_get_line_count :: proc(layout: ^Layout) -> i32 ---
		layout_get_line_readonly :: proc(layout: ^Layout, line: i32) -> ^LayoutLine ---
		layout_get_line_spacing :: proc(layout: ^Layout) -> f32 ---
		layout_get_lines :: proc(layout: ^Layout) -> ^glib.SList ---
		layout_get_lines_readonly :: proc(layout: ^Layout) -> ^glib.SList ---
		layout_get_log_attrs :: proc(layout: ^Layout, attrs: ^[^]LogAttr, n_attrs: ^glib.int_) ---
		layout_get_log_attrs_readonly :: proc(layout: ^Layout, n_attrs: ^glib.int_) -> [^]LogAttr ---
		layout_get_pixel_extents :: proc(layout: ^Layout, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		layout_get_pixel_size :: proc(layout: ^Layout, width: ^i32, height: ^i32) ---
		layout_get_serial :: proc(layout: ^Layout) -> glib.uint_ ---
		layout_get_single_paragraph_mode :: proc(layout: ^Layout) -> glib.boolean ---
		layout_get_size :: proc(layout: ^Layout, width: ^i32, height: ^i32) ---
		layout_get_spacing :: proc(layout: ^Layout) -> i32 ---
		layout_get_tabs :: proc(layout: ^Layout) -> ^TabArray ---
		layout_get_text :: proc(layout: ^Layout) -> cstring ---
		layout_get_type :: proc() -> gobj.Type ---
		layout_get_type :: proc() -> gobj.Type ---
		layout_get_unknown_glyphs_count :: proc(layout: ^Layout) -> i32 ---
		layout_get_width :: proc(layout: ^Layout) -> i32 ---
		layout_get_wrap :: proc(layout: ^Layout) -> WrapMode ---
		layout_index_to_line_x :: proc(layout: ^Layout, index_: i32, trailing: glib.boolean, line: ^i32, x_pos: ^i32) ---
		layout_index_to_pos :: proc(layout: ^Layout, index_: i32, pos: ^Rectangle) ---
		layout_is_ellipsized :: proc(layout: ^Layout) -> glib.boolean ---
		layout_is_wrapped :: proc(layout: ^Layout) -> glib.boolean ---
		layout_iter_at_last_line :: proc(iter: ^LayoutIter) -> glib.boolean ---
		layout_iter_copy :: proc(iter: ^LayoutIter) -> ^LayoutIter ---
		layout_iter_free :: proc(iter: ^LayoutIter) ---
		layout_iter_get_baseline :: proc(iter: ^LayoutIter) -> i32 ---
		layout_iter_get_char_extents :: proc(iter: ^LayoutIter, logical_rect: ^Rectangle) ---
		layout_iter_get_cluster_extents :: proc(iter: ^LayoutIter, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		layout_iter_get_index :: proc(iter: ^LayoutIter) -> i32 ---
		layout_iter_get_layout :: proc(iter: ^LayoutIter) -> ^Layout ---
		layout_iter_get_layout_extents :: proc(iter: ^LayoutIter, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		layout_iter_get_line :: proc(iter: ^LayoutIter) -> ^LayoutLine ---
		layout_iter_get_line_extents :: proc(iter: ^LayoutIter, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		layout_iter_get_line_readonly :: proc(iter: ^LayoutIter) -> ^LayoutLine ---
		layout_iter_get_line_yrange :: proc(iter: ^LayoutIter, y0_: ^i32, y1_: ^i32) ---
		layout_iter_get_run :: proc(iter: ^LayoutIter) -> ^LayoutRun ---
		layout_iter_get_run_baseline :: proc(iter: ^LayoutIter) -> i32 ---
		layout_iter_get_run_extents :: proc(iter: ^LayoutIter, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		layout_iter_get_run_readonly :: proc(iter: ^LayoutIter) -> ^LayoutRun ---
		layout_iter_get_type :: proc() -> gobj.Type ---
		layout_iter_get_type :: proc() -> gobj.Type ---
		layout_iter_next_char :: proc(iter: ^LayoutIter) -> glib.boolean ---
		layout_iter_next_cluster :: proc(iter: ^LayoutIter) -> glib.boolean ---
		layout_iter_next_line :: proc(iter: ^LayoutIter) -> glib.boolean ---
		layout_iter_next_run :: proc(iter: ^LayoutIter) -> glib.boolean ---
		layout_line_get_extents :: proc(line: ^LayoutLine, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		layout_line_get_height :: proc(line: ^LayoutLine, height: ^i32) ---
		layout_line_get_length :: proc(line: ^LayoutLine) -> i32 ---
		layout_line_get_pixel_extents :: proc(layout_line: ^LayoutLine, ink_rect: ^Rectangle, logical_rect: ^Rectangle) ---
		layout_line_get_resolved_direction :: proc(line: ^LayoutLine) -> Direction ---
		layout_line_get_start_index :: proc(line: ^LayoutLine) -> i32 ---
		layout_line_get_type :: proc() -> gobj.Type ---
		layout_line_get_type :: proc() -> gobj.Type ---
		layout_line_get_x_ranges :: proc(line: ^LayoutLine, start_index: i32, end_index: i32, ranges: ^[^]i32, n_ranges: ^i32) ---
		layout_line_index_to_x :: proc(line: ^LayoutLine, index_: i32, trailing: glib.boolean, x_pos: ^i32) ---
		layout_line_is_paragraph_start :: proc(line: ^LayoutLine) -> glib.boolean ---
		layout_line_ref :: proc(line: ^LayoutLine) -> ^LayoutLine ---
		layout_line_unref :: proc(line: ^LayoutLine) ---
		layout_line_x_to_index :: proc(line: ^LayoutLine, x_pos: i32, index_: ^i32, trailing: ^i32) -> glib.boolean ---
		layout_move_cursor_visually :: proc(layout: ^Layout, strong: glib.boolean, old_index: i32, old_trailing: i32, direction: i32, new_index: ^i32, new_trailing: ^i32) ---
		layout_new :: proc(context_p: ^Context) -> ^Layout ---
		layout_serialize :: proc(layout: ^Layout, flags: LayoutSerializeFlags) -> ^glib.Bytes ---
		layout_serialize_flags_get_type :: proc() -> gobj.Type ---
		layout_serialize_flags_get_type :: proc() -> gobj.Type ---
		layout_set_alignment :: proc(layout: ^Layout, alignment: Alignment) ---
		layout_set_attributes :: proc(layout: ^Layout, attrs: ^AttrList) ---
		layout_set_auto_dir :: proc(layout: ^Layout, auto_dir: glib.boolean) ---
		layout_set_ellipsize :: proc(layout: ^Layout, ellipsize: EllipsizeMode) ---
		layout_set_font_description :: proc(layout: ^Layout, desc: ^FontDescription) ---
		layout_set_height :: proc(layout: ^Layout, height: i32) ---
		layout_set_indent :: proc(layout: ^Layout, indent: i32) ---
		layout_set_justify :: proc(layout: ^Layout, justify: glib.boolean) ---
		layout_set_justify_last_line :: proc(layout: ^Layout, justify: glib.boolean) ---
		layout_set_line_spacing :: proc(layout: ^Layout, factor: f32) ---
		layout_set_markup :: proc(layout: ^Layout, markup: cstring, length: i32) ---
		layout_set_markup_with_accel :: proc(layout: ^Layout, markup: cstring, length: i32, accel_marker: glib.unichar, accel_char: ^glib.unichar) ---
		layout_set_single_paragraph_mode :: proc(layout: ^Layout, setting: glib.boolean) ---
		layout_set_spacing :: proc(layout: ^Layout, spacing: i32) ---
		layout_set_tabs :: proc(layout: ^Layout, tabs: ^TabArray) ---
		layout_set_text :: proc(layout: ^Layout, text: cstring, length: i32) ---
		layout_set_width :: proc(layout: ^Layout, width: i32) ---
		layout_set_wrap :: proc(layout: ^Layout, wrap: WrapMode) ---
		layout_write_to_file :: proc(layout: ^Layout, flags: LayoutSerializeFlags, filename: cstring, error: ^^glib.Error) -> glib.boolean ---
		layout_xy_to_index :: proc(layout: ^Layout, x: i32, y: i32, index_: ^i32, trailing: ^i32) -> glib.boolean ---
		log2vis_get_embedding_levels :: proc(text: cstring, length: i32, pbase_dir: ^Direction) -> ^glib.uint8 ---
		markup_parser_finish :: proc(context_p: ^glib.MarkupParseContext, attr_list: ^^AttrList, text: ^cstring, accel_char: ^glib.unichar, error: ^^glib.Error) -> glib.boolean ---
		markup_parser_new :: proc(accel_marker: glib.unichar) -> ^glib.MarkupParseContext ---
		matrix_concat :: proc(matrix_p: ^Matrix, new_matrix: ^Matrix) ---
		matrix_copy :: proc(matrix_p: ^Matrix) -> ^Matrix ---
		matrix_free :: proc(matrix_p: ^Matrix) ---
		matrix_get_font_scale_factor :: proc(matrix_p: ^Matrix) -> f64 ---
		matrix_get_font_scale_factors :: proc(matrix_p: ^Matrix, xscale: ^f64, yscale: ^f64) ---
		matrix_get_slant_ratio :: proc(matrix_p: ^Matrix) -> f64 ---
		matrix_get_type :: proc() -> gobj.Type ---
		matrix_get_type :: proc() -> gobj.Type ---
		matrix_rotate :: proc(matrix_p: ^Matrix, degrees: f64) ---
		matrix_scale :: proc(matrix_p: ^Matrix, scale_x: f64, scale_y: f64) ---
		matrix_transform_distance :: proc(matrix_p: ^Matrix, dx: ^f64, dy: ^f64) ---
		matrix_transform_pixel_rectangle :: proc(matrix_p: ^Matrix, rect: ^Rectangle) ---
		matrix_transform_point :: proc(matrix_p: ^Matrix, x: ^f64, y: ^f64) ---
		matrix_transform_rectangle :: proc(matrix_p: ^Matrix, rect: ^Rectangle) ---
		matrix_translate :: proc(matrix_p: ^Matrix, tx: f64, ty: f64) ---
		overline_get_type :: proc() -> gobj.Type ---
		overline_get_type :: proc() -> gobj.Type ---
		parse_enum :: proc(type: gobj.Type, str: cstring, value: ^i32, warn: glib.boolean, possible_values: ^cstring) -> glib.boolean ---
		parse_markup :: proc(markup_text: cstring, length: i32, accel_marker: glib.unichar, attr_list: ^^AttrList, text: ^cstring, accel_char: ^glib.unichar, error: ^^glib.Error) -> glib.boolean ---
		parse_stretch :: proc(str: cstring, stretch: ^Stretch, warn: glib.boolean) -> glib.boolean ---
		parse_style :: proc(str: cstring, style: ^Style, warn: glib.boolean) -> glib.boolean ---
		parse_variant :: proc(str: cstring, variant: ^Variant, warn: glib.boolean) -> glib.boolean ---
		parse_weight :: proc(str: cstring, weight: ^Weight, warn: glib.boolean) -> glib.boolean ---
		quantize_line_geometry :: proc(thickness: ^i32, position: ^i32) ---
		read_line :: proc(stream: ^libc.FILE, str: ^glib.String) -> glib.int_ ---
		render_part_get_type :: proc() -> gobj.Type ---
		render_part_get_type :: proc() -> gobj.Type ---
		renderer_activate :: proc(renderer: ^Renderer) ---
		renderer_deactivate :: proc(renderer: ^Renderer) ---
		renderer_draw_error_underline :: proc(renderer: ^Renderer, x: i32, y: i32, width: i32, height: i32) ---
		renderer_draw_glyph :: proc(renderer: ^Renderer, font: ^Font, glyph: Glyph, x: f64, y: f64) ---
		renderer_draw_glyph_item :: proc(renderer: ^Renderer, text: cstring, glyph_item: ^GlyphItem, x: i32, y: i32) ---
		renderer_draw_glyphs :: proc(renderer: ^Renderer, font: ^Font, glyphs: ^GlyphString, x: i32, y: i32) ---
		renderer_draw_layout :: proc(renderer: ^Renderer, layout: ^Layout, x: i32, y: i32) ---
		renderer_draw_layout_line :: proc(renderer: ^Renderer, line: ^LayoutLine, x: i32, y: i32) ---
		renderer_draw_rectangle :: proc(renderer: ^Renderer, part: RenderPart, x: i32, y: i32, width: i32, height: i32) ---
		renderer_draw_trapezoid :: proc(renderer: ^Renderer, part: RenderPart, y1_: f64, x11: f64, x21: f64, y2: f64, x12: f64, x22: f64) ---
		renderer_get_alpha :: proc(renderer: ^Renderer, part: RenderPart) -> glib.uint16 ---
		renderer_get_color :: proc(renderer: ^Renderer, part: RenderPart) -> ^Color ---
		renderer_get_layout :: proc(renderer: ^Renderer) -> ^Layout ---
		renderer_get_layout_line :: proc(renderer: ^Renderer) -> ^LayoutLine ---
		renderer_get_matrix :: proc(renderer: ^Renderer) -> ^Matrix ---
		renderer_get_type :: proc() -> gobj.Type ---
		renderer_get_type :: proc() -> gobj.Type ---
		renderer_part_changed :: proc(renderer: ^Renderer, part: RenderPart) ---
		renderer_set_alpha :: proc(renderer: ^Renderer, part: RenderPart, alpha: glib.uint16) ---
		renderer_set_color :: proc(renderer: ^Renderer, part: RenderPart, color: ^Color) ---
		renderer_set_matrix :: proc(renderer: ^Renderer, matrix_p: ^Matrix) ---
		reorder_items :: proc(items: ^glib.List) -> ^glib.List ---
		scan_int :: proc(pos: ^cstring, out: ^i32) -> glib.boolean ---
		scan_string :: proc(pos: ^cstring, out: ^glib.String) -> glib.boolean ---
		scan_word :: proc(pos: ^cstring, out: ^glib.String) -> glib.boolean ---
		script_engine_create :: proc(id: cstring) -> ^Engine ---
		script_engine_exit :: proc() ---
		script_engine_init :: proc(module: ^gobj.TypeModule) ---
		script_engine_list :: proc(engines: ^[^]EngineInfo, n_engines: ^i32) ---
		script_for_unichar :: proc(ch: glib.unichar) -> Script ---
		script_get_sample_language :: proc(script: Script) -> ^Language ---
		script_get_type :: proc() -> gobj.Type ---
		script_get_type :: proc() -> gobj.Type ---
		script_iter_free :: proc(iter: ^ScriptIter) ---
		script_iter_get_range :: proc(iter: ^ScriptIter, start: ^cstring, end: ^cstring, script: ^Script) ---
		script_iter_get_type :: proc() -> gobj.Type ---
		script_iter_new :: proc(text: cstring, length: i32) -> ^ScriptIter ---
		script_iter_next :: proc(iter: ^ScriptIter) -> glib.boolean ---
		shape :: proc(text: cstring, length: i32, analysis: ^Analysis, glyphs: ^GlyphString) ---
		shape_flags_get_type :: proc() -> gobj.Type ---
		shape_flags_get_type :: proc() -> gobj.Type ---
		shape_full :: proc(item_text: cstring, item_length: i32, paragraph_text: cstring, paragraph_length: i32, analysis: ^Analysis, glyphs: ^GlyphString) ---
		shape_item :: proc(item: ^Item, paragraph_text: cstring, paragraph_length: i32, log_attrs: [^]LogAttr, glyphs: ^GlyphString, flags: ShapeFlags) ---
		shape_with_flags :: proc(item_text: cstring, item_length: i32, paragraph_text: cstring, paragraph_length: i32, analysis: ^Analysis, glyphs: ^GlyphString, flags: ShapeFlags) ---
		show_flags_get_type :: proc() -> gobj.Type ---
		show_flags_get_type :: proc() -> gobj.Type ---
		skip_space :: proc(pos: ^cstring) -> glib.boolean ---
		split_file_list :: proc(str: cstring) -> ^cstring ---
		stretch_get_type :: proc() -> gobj.Type ---
		stretch_get_type :: proc() -> gobj.Type ---
		style_get_type :: proc() -> gobj.Type ---
		style_get_type :: proc() -> gobj.Type ---
		tab_align_get_type :: proc() -> gobj.Type ---
		tab_align_get_type :: proc() -> gobj.Type ---
		tab_array_copy :: proc(src: ^TabArray) -> ^TabArray ---
		tab_array_free :: proc(tab_array: ^TabArray) ---
		tab_array_from_string :: proc(text: cstring) -> ^TabArray ---
		tab_array_get_decimal_point :: proc(tab_array: ^TabArray, tab_index: i32) -> glib.unichar ---
		tab_array_get_positions_in_pixels :: proc(tab_array: ^TabArray) -> glib.boolean ---
		tab_array_get_size :: proc(tab_array: ^TabArray) -> glib.int_ ---
		tab_array_get_tab :: proc(tab_array: ^TabArray, tab_index: glib.int_, alignment: ^TabAlign, location: ^glib.int_) ---
		tab_array_get_tabs :: proc(tab_array: ^TabArray, alignments: ^[^]TabAlign, locations: ^[^]glib.int_) ---
		tab_array_get_type :: proc() -> gobj.Type ---
		tab_array_get_type :: proc() -> gobj.Type ---
		tab_array_new :: proc(initial_size: glib.int_, positions_in_pixels: glib.boolean) -> ^TabArray ---
		tab_array_new_with_positions :: proc(size_p: glib.int_, positions_in_pixels: glib.boolean, first_alignment: TabAlign, first_position: glib.int_, #c_vararg var_args: ..any) -> ^TabArray ---
		tab_array_resize :: proc(tab_array: ^TabArray, new_size: glib.int_) ---
		tab_array_set_decimal_point :: proc(tab_array: ^TabArray, tab_index: i32, decimal_point: glib.unichar) ---
		tab_array_set_positions_in_pixels :: proc(tab_array: ^TabArray, positions_in_pixels: glib.boolean) ---
		tab_array_set_tab :: proc(tab_array: ^TabArray, tab_index: glib.int_, alignment: TabAlign, location: glib.int_) ---
		tab_array_sort :: proc(tab_array: ^TabArray) ---
		tab_array_to_string :: proc(tab_array: ^TabArray) -> cstring ---
		tailor_break :: proc(text: cstring, length: i32, analysis: ^Analysis, offset: i32, attrs: [^]LogAttr, attrs_len: i32) ---
		text_transform_get_type :: proc() -> gobj.Type ---
		text_transform_get_type :: proc() -> gobj.Type ---
		trim_string :: proc(str: cstring) -> cstring ---
		underline_get_type :: proc() -> gobj.Type ---
		underline_get_type :: proc() -> gobj.Type ---
		unichar_direction :: proc(ch: glib.unichar) -> Direction ---
		units_from_double :: proc(d: f64) -> i32 ---
		units_to_double :: proc(i: i32) -> f64 ---
		variant_get_type :: proc() -> gobj.Type ---
		variant_get_type :: proc() -> gobj.Type ---
		version :: proc() -> i32 ---
		version_check :: proc(required_major: i32, required_minor: i32, required_micro: i32) -> cstring ---
		version_string :: proc() -> cstring ---
		weight_get_type :: proc() -> gobj.Type ---
		weight_get_type :: proc() -> gobj.Type ---
		wrap_mode_get_type :: proc() -> gobj.Type ---
		wrap_mode_get_type :: proc() -> gobj.Type ---

	types
		Alignment :: enum u32 {ALIGN_LEFT = 0, ALIGN_CENTER = 1, ALIGN_RIGHT = 2}
		Analysis :: struct {shape_engine: ^EngineShape, lang_engine: ^EngineLang, font: ^Font, level: glib.uint8, gravity: glib.uint8, flags: glib.uint8, script: glib.uint8, language: ^Language, extra_attrs: ^glib.SList}
		AttrClass :: struct {type: AttrType, copy: copy_func_ptr_anon_21, destroy: destroy_func_ptr_anon_22, equal: equal_func_ptr_anon_23}
		AttrColor :: struct {attr: Attribute, color: Color}
		AttrDataCopyFunc :: #type proc(user_data: glib.constpointer) -> glib.pointer
		AttrFilterFunc :: #type proc(attribute: ^Attribute, user_data: glib.pointer) -> glib.boolean
		AttrFloat :: struct {attr: Attribute, value: f64}
		AttrFontDesc :: struct {attr: Attribute, desc: ^FontDescription}
		AttrFontFeatures :: struct {attr: Attribute, features: cstring}
		AttrInt :: struct {attr: Attribute, value: i32}
		AttrIterator :: struct #packed {}
		AttrLanguage :: struct {attr: Attribute, value: ^Language}
		AttrList :: struct #packed {}
		AttrShape :: struct {attr: Attribute, ink_rect: Rectangle, logical_rect: Rectangle, data: glib.pointer, copy_func: AttrDataCopyFunc, destroy_func: glib.DestroyNotify}
		AttrSize :: struct {attr: Attribute, size: i32, using _: bit_field u32 {absolute: bool | 1, _: u32 | 31}}
			PangoAttrSize: the attribute, the size, then a word that holds `absolute` and padding.

		AttrString :: struct {attr: Attribute, value: cstring}
		AttrType :: enum u32 {ATTR_INVALID = 0, ATTR_LANGUAGE = 1, ATTR_FAMILY = 2, ATTR_STYLE = 3, ATTR_WEIGHT = 4, ATTR_VARIANT = 5, ATTR_STRETCH = 6, ATTR_SIZE = 7, ATTR_FONT_DESC = 8, ATTR_FOREGROUND = 9, ATTR_BACKGROUND = 10, ATTR_UNDERLINE = 11, ATTR_STRIKETHROUGH = 12, ATTR_RISE = 13, ATTR_SHAPE = 14, ATTR_SCALE = 15, ATTR_FALLBACK = 16, ATTR_LETTER_SPACING = 17, ATTR_UNDERLINE_COLOR = 18, ATTR_STRIKETHROUGH_COLOR = 19, ATTR_ABSOLUTE_SIZE = 20, ATTR_GRAVITY = 21, ATTR_GRAVITY_HINT = 22, ATTR_FONT_FEATURES = 23, ATTR_FOREGROUND_ALPHA = 24, ATTR_BACKGROUND_ALPHA = 25, ATTR_ALLOW_BREAKS = 26, ATTR_SHOW = 27, ATTR_INSERT_HYPHENS = 28, ATTR_OVERLINE = 29, ATTR_OVERLINE_COLOR = 30, ATTR_LINE_HEIGHT = 31, ATTR_ABSOLUTE_LINE_HEIGHT = 32, ATTR_TEXT_TRANSFORM = 33, ATTR_WORD = 34, ATTR_SENTENCE = 35, ATTR_BASELINE_SHIFT = 36, ATTR_FONT_SCALE = 37}
		Attribute :: struct {klass: ^AttrClass, start_index: glib.uint_, end_index: glib.uint_}
		BaselineShift :: enum u32 {NONE = 0, SUPERSCRIPT = 1, SUBSCRIPT = 2}
		BidiType :: enum u32 {L = 0, LRE = 1, LRO = 2, R = 3, AL = 4, RLE = 5, RLO = 6, PDF = 7, EN = 8, ES = 9, ET = 10, AN = 11, CS = 12, NSM = 13, BN = 14, B = 15, S = 16, WS = 17, ON = 18, LRI = 19, RLI = 20, FSI = 21, PDI = 22}
		Color :: struct {red: glib.uint16, green: glib.uint16, blue: glib.uint16}
		Context :: struct #packed {}
		ContextClass :: struct #packed {}
		Coverage :: struct #packed {}
		CoverageLevel :: enum u32 {COVERAGE_NONE = 0, COVERAGE_FALLBACK = 1, COVERAGE_APPROXIMATE = 2, COVERAGE_EXACT = 3}
		Direction :: enum u32 {LTR = 0, RTL = 1, TTB_LTR = 2, TTB_RTL = 3, WEAK_LTR = 4, WEAK_RTL = 5, NEUTRAL = 6}
		EllipsizeMode :: enum u32 {ELLIPSIZE_NONE = 0, ELLIPSIZE_START = 1, ELLIPSIZE_MIDDLE = 2, ELLIPSIZE_END = 3}
		Engine :: struct {parent_instance: gobj.Object}
		EngineClass :: struct {parent_class: gobj.ObjectClass}
		EngineInfo :: struct {id: cstring, engine_type: cstring, render_type: cstring, scripts: [^]EngineScriptInfo, n_scripts: glib.int_}
		EngineLang :: struct {parent_instance: Engine}
		EngineLangClass :: struct {parent_class: EngineClass, script_break: script_break_func_ptr_anon_39}
		EngineScriptInfo :: struct {script: Script, langs: cstring}
		EngineShape :: struct {parent_instance: Engine}
		EngineShapeClass :: struct {parent_class: EngineClass, script_shape: script_shape_func_ptr_anon_40, covers: covers_func_ptr_anon_41}
		Font :: struct {parent_instance: gobj.Object}
		FontClass :: struct {parent_class: gobj.ObjectClass, describe: describe_func_ptr_anon_13, get_coverage: et_coverage_func_ptr_anon_14, get_glyph_extents: et_glyph_extents_func_ptr_anon_15, get_metrics: et_metrics_func_ptr_anon_16, get_font_map: et_font_map_func_ptr_anon_17, describe_absolute: describe_absolute_func_ptr_anon_18, get_features: et_features_func_ptr_anon_19, create_hb_font: create_hb_font_func_ptr_anon_20}
		FontDescription :: struct #packed {}
		FontFace :: struct {parent_instance: gobj.Object}
		FontFaceClass :: struct {parent_class: gobj.ObjectClass, get_face_name: et_face_name_func_ptr_anon_6, describe: describe_func_ptr_anon_7, list_sizes: list_sizes_func_ptr_anon_8, is_synthesized: is_synthesized_func_ptr_anon_9, get_family: et_family_func_ptr_anon_10, _pango_reserved3: _pango_reserved3_func_ptr_anon_11, _pango_reserved4: _pango_reserved4_func_ptr_anon_12}
		FontFamily :: struct {parent_instance: gobj.Object}
		FontFamilyClass :: struct {parent_class: gobj.ObjectClass, list_faces: list_faces_func_ptr_anon_0, get_name: et_name_func_ptr_anon_1, is_monospace: is_monospace_func_ptr_anon_2, is_variable: is_variable_func_ptr_anon_3, get_face: et_face_func_ptr_anon_4, _pango_reserved2: _pango_reserved2_func_ptr_anon_5}
		FontMap :: struct {parent_instance: gobj.Object}
		FontMapClass :: struct {parent_class: gobj.ObjectClass, load_font: load_font_func_ptr_anon_32, list_families: list_families_func_ptr_anon_33, load_fontset: load_fontset_func_ptr_anon_34, shape_engine_type: cstring, get_serial: et_serial_func_ptr_anon_35, changed: changed_func_ptr_anon_36, get_family: et_family_func_ptr_anon_37, get_face: et_face_func_ptr_anon_38}
		FontMask :: bit_set[FontMaskBit]
		FontMaskBit :: enum u32 {FAMILY = 0, STYLE = 1, VARIANT = 2, WEIGHT = 3, STRETCH = 4, SIZE = 5, GRAVITY = 6, VARIATIONS = 7}
		FontMetrics :: struct {ref_count: glib.uint_, ascent: i32, descent: i32, height: i32, approximate_char_width: i32, approximate_digit_width: i32, underline_position: i32, underline_thickness: i32, strikethrough_position: i32, strikethrough_thickness: i32}
		FontScale :: enum u32 {NONE = 0, SUPERSCRIPT = 1, SUBSCRIPT = 2, SMALL_CAPS = 3}
		Fontset :: struct {parent_instance: gobj.Object}
		FontsetClass :: struct {parent_class: gobj.ObjectClass, get_font: et_font_func_ptr_anon_24, get_metrics: et_metrics_func_ptr_anon_25, get_language: et_language_func_ptr_anon_26, foreach: foreach_func_ptr_anon_27, _pango_reserved1: _pango_reserved1_func_ptr_anon_28, _pango_reserved2: _pango_reserved2_func_ptr_anon_29, _pango_reserved3: _pango_reserved3_func_ptr_anon_30, _pango_reserved4: _pango_reserved4_func_ptr_anon_31}
		FontsetForeachFunc :: #type proc(fontset: ^Fontset, font: ^Font, user_data: glib.pointer) -> glib.boolean
		FontsetSimple :: struct #packed {}
		FontsetSimpleClass :: struct #packed {}
		Glyph :: glib.uint32
		GlyphGeometry :: struct {width: GlyphUnit, x_offset: GlyphUnit, y_offset: GlyphUnit}
		GlyphInfo :: struct {glyph: Glyph, geometry: GlyphGeometry, attr: GlyphVisAttr}
		GlyphItem :: struct {item: ^Item, glyphs: ^GlyphString, y_offset: i32, start_x_offset: i32, end_x_offset: i32}
		GlyphItemIter :: struct {glyph_item: ^GlyphItem, text: cstring, start_glyph: i32, start_index: i32, start_char: i32, end_glyph: i32, end_index: i32, end_char: i32}
		GlyphString :: struct {num_glyphs: i32, glyphs: [^]GlyphInfo, log_clusters: [^]i32, space: i32}
		GlyphUnit :: glib.int32
		GlyphVisAttr :: bit_field u32 {is_cluster_start: bool | 1, is_color: bool | 1, _: u32 | 30}
			PangoGlyphVisAttr: two flags in a word of four bytes.

		Gravity :: enum u32 {SOUTH = 0, EAST = 1, NORTH = 2, WEST = 3, AUTO = 4}
		GravityHint :: enum u32 {NATURAL = 0, STRONG = 1, LINE = 2}
		Item :: struct {offset: i32, length: i32, num_chars: i32, analysis: Analysis}
		Language :: struct #packed {}
		Layout :: struct #packed {}
		LayoutClass :: struct #packed {}
		LayoutDeserializeError :: enum u32 {INVALID = 0, INVALID_VALUE = 1, MISSING_VALUE = 2}
		LayoutDeserializeFlags :: bit_set[LayoutDeserializeFlagsBit]
		LayoutDeserializeFlagsBit :: enum u32 {CONTEXT = 0}
		LayoutIter :: struct #packed {}
		LayoutLine :: [32]i8
		LayoutRun :: GlyphItem
		LayoutSerializeFlags :: bit_set[LayoutSerializeFlagsBit]
		LayoutSerializeFlagsBit :: enum u32 {CONTEXT = 0, OUTPUT = 1}
		LogAttr :: bit_field u32 {is_line_break: bool | 1, is_mandatory_break: bool | 1, is_char_break: bool | 1, is_white: bool | 1, is_cursor_position: bool | 1, is_word_start: bool | 1, is_word_end: bool | 1, is_sentence_boundary: bool | 1, is_sentence_start: bool | 1, is_sentence_end: bool | 1, backspace_deletes_character: bool | 1, is_expandable_space: bool | 1, is_word_boundary: bool | 1, break_inserts_hyphen: bool | 1, break_removes_preceding: bool | 1, reserved: u32 | 17}
			PangoLogAttr: one per character of a layout, plus one for the position after the last, as
			returned by layout_get_log_attrs_readonly. A bit_field of 4 bytes, so [^]LogAttr indexes like
			the C array.

		Matrix :: struct {xx: f64, xy: f64, yx: f64, yy: f64, x0: f64, y0: f64}
		Overline :: enum u32 {NONE = 0, SINGLE = 1}
		Rectangle :: struct {x: i32, y: i32, width: i32, height: i32}
		RenderPart :: enum u32 {FOREGROUND = 0, BACKGROUND = 1, UNDERLINE = 2, STRIKETHROUGH = 3, OVERLINE = 4}
		Renderer :: struct {parent_instance: gobj.Object, underline: Underline, strikethrough: glib.boolean, active_count: i32, matrix_m: ^Matrix, priv: ^RendererPrivate}
		RendererClass :: struct {parent_class: gobj.ObjectClass, draw_glyphs: draw_glyphs_func_ptr_anon_42, draw_rectangle: draw_rectangle_func_ptr_anon_43, draw_error_underline: draw_error_underline_func_ptr_anon_44, draw_shape: draw_shape_func_ptr_anon_45, draw_trapezoid: draw_trapezoid_func_ptr_anon_46, draw_glyph: draw_glyph_func_ptr_anon_47, part_changed: part_changed_func_ptr_anon_48, begin: begin_func_ptr_anon_49, end: end_func_ptr_anon_50, prepare_run: prepare_run_func_ptr_anon_51, draw_glyph_item: draw_glyph_item_func_ptr_anon_52, _pango_reserved2: _pango_reserved2_func_ptr_anon_53, _pango_reserved3: _pango_reserved3_func_ptr_anon_54, _pango_reserved4: _pango_reserved4_func_ptr_anon_55}
		RendererPrivate :: struct #packed {}
		Script :: enum i32 {INVALID_CODE = -1, COMMON = 0, INHERITED = 1, ARABIC = 2, ARMENIAN = 3, BENGALI = 4, BOPOMOFO = 5, CHEROKEE = 6, COPTIC = 7, CYRILLIC = 8, DESERET = 9, DEVANAGARI = 10, ETHIOPIC = 11, GEORGIAN = 12, GOTHIC = 13, GREEK = 14, GUJARATI = 15, GURMUKHI = 16, HAN = 17, HANGUL = 18, HEBREW = 19, HIRAGANA = 20, KANNADA = 21, KATAKANA = 22, KHMER = 23, LAO = 24, LATIN = 25, MALAYALAM = 26, MONGOLIAN = 27, MYANMAR = 28, OGHAM = 29, OLD_ITALIC = 30, ORIYA = 31, RUNIC = 32, SINHALA = 33, SYRIAC = 34, TAMIL = 35, TELUGU = 36, THAANA = 37, THAI = 38, TIBETAN = 39, CANADIAN_ABORIGINAL = 40, YI = 41, TAGALOG = 42, HANUNOO = 43, BUHID = 44, TAGBANWA = 45, BRAILLE = 46, CYPRIOT = 47, LIMBU = 48, OSMANYA = 49, SHAVIAN = 50, LINEAR_B = 51, TAI_LE = 52, UGARITIC = 53, NEW_TAI_LUE = 54, BUGINESE = 55, GLAGOLITIC = 56, TIFINAGH = 57, SYLOTI_NAGRI = 58, OLD_PERSIAN = 59, KHAROSHTHI = 60, UNKNOWN = 61, BALINESE = 62, CUNEIFORM = 63, PHOENICIAN = 64, PHAGS_PA = 65, NKO = 66, KAYAH_LI = 67, LEPCHA = 68, REJANG = 69, SUNDANESE = 70, SAURASHTRA = 71, CHAM = 72, OL_CHIKI = 73, VAI = 74, CARIAN = 75, LYCIAN = 76, LYDIAN = 77, BATAK = 78, BRAHMI = 79, MANDAIC = 80, CHAKMA = 81, MEROITIC_CURSIVE = 82, MEROITIC_HIEROGLYPHS = 83, MIAO = 84, SHARADA = 85, SORA_SOMPENG = 86, TAKRI = 87, BASSA_VAH = 88, CAUCASIAN_ALBANIAN = 89, DUPLOYAN = 90, ELBASAN = 91, GRANTHA = 92, KHOJKI = 93, KHUDAWADI = 94, LINEAR_A = 95, MAHAJANI = 96, MANICHAEAN = 97, MENDE_KIKAKUI = 98, MODI = 99, MRO = 100, NABATAEAN = 101, OLD_NORTH_ARABIAN = 102, OLD_PERMIC = 103, PAHAWH_HMONG = 104, PALMYRENE = 105, PAU_CIN_HAU = 106, PSALTER_PAHLAVI = 107, SIDDHAM = 108, TIRHUTA = 109, WARANG_CITI = 110, AHOM = 111, ANATOLIAN_HIEROGLYPHS = 112, HATRAN = 113, MULTANI = 114, OLD_HUNGARIAN = 115, SIGNWRITING = 116}
		ScriptIter :: struct #packed {}
		ShapeFlags :: bit_set[ShapeFlagsBit]
		ShapeFlagsBit :: enum u32 {ROUND_POSITIONS = 0}
		ShowFlags :: bit_set[ShowFlagsBit]
		ShowFlagsBit :: enum u32 {SPACES = 0, LINE_BREAKS = 1, IGNORABLES = 2}
		Stretch :: enum u32 {ULTRA_CONDENSED = 0, EXTRA_CONDENSED = 1, CONDENSED = 2, SEMI_CONDENSED = 3, NORMAL = 4, SEMI_EXPANDED = 5, EXPANDED = 6, EXTRA_EXPANDED = 7, ULTRA_EXPANDED = 8}
		Style :: enum u32 {NORMAL = 0, OBLIQUE = 1, ITALIC = 2}
		TabAlign :: enum u32 {TAB_LEFT = 0, TAB_RIGHT = 1, TAB_CENTER = 2, TAB_DECIMAL = 3}
		TabArray :: struct #packed {}
		TextTransform :: enum u32 {NONE = 0, LOWERCASE = 1, UPPERCASE = 2, CAPITALIZE = 3}
		Underline :: enum u32 {NONE = 0, SINGLE = 1, DOUBLE = 2, LOW = 3, ERROR = 4, SINGLE_LINE = 5, DOUBLE_LINE = 6, ERROR_LINE = 7}
		Variant :: enum u32 {NORMAL = 0, SMALL_CAPS = 1, ALL_SMALL_CAPS = 2, PETITE_CAPS = 3, ALL_PETITE_CAPS = 4, UNICASE = 5, TITLE_CAPS = 6}
		Weight :: enum u32 {THIN = 100, ULTRALIGHT = 200, LIGHT = 300, SEMILIGHT = 350, BOOK = 380, NORMAL = 400, MEDIUM = 500, SEMIBOLD = 600, BOLD = 700, ULTRABOLD = 800, HEAVY = 900, ULTRAHEAVY = 1000}
		WrapMode :: enum u32 {WRAP_WORD = 0, WRAP_CHAR = 1, WRAP_WORD_CHAR = 2}
		_pango_reserved1_func_ptr_anon_28 :: #type proc()
		_pango_reserved2_func_ptr_anon_29 :: #type proc()
		_pango_reserved2_func_ptr_anon_5 :: #type proc()
		_pango_reserved2_func_ptr_anon_53 :: #type proc()
		_pango_reserved3_func_ptr_anon_11 :: #type proc()
		_pango_reserved3_func_ptr_anon_30 :: #type proc()
		_pango_reserved3_func_ptr_anon_54 :: #type proc()
		_pango_reserved4_func_ptr_anon_12 :: #type proc()
		_pango_reserved4_func_ptr_anon_31 :: #type proc()
		_pango_reserved4_func_ptr_anon_55 :: #type proc()
		begin_func_ptr_anon_49 :: #type proc(renderer: ^Renderer)
		changed_func_ptr_anon_36 :: #type proc(fontmap: ^FontMap)
		copy_func_ptr_anon_21 :: #type proc(attr: ^Attribute) -> ^Attribute
		covers_func_ptr_anon_41 :: #type proc(engine: ^EngineShape, font: ^Font, language: ^Language, wc: glib.unichar) -> CoverageLevel
		create_hb_font_func_ptr_anon_20 :: #type proc(font: ^Font) -> ^hb_font_t
		describe_absolute_func_ptr_anon_18 :: #type proc(font: ^Font) -> ^FontDescription
		describe_func_ptr_anon_13 :: #type proc(font: ^Font) -> ^FontDescription
		describe_func_ptr_anon_7 :: #type proc(face: ^FontFace) -> ^FontDescription
		destroy_func_ptr_anon_22 :: #type proc(attr: ^Attribute)
		draw_error_underline_func_ptr_anon_44 :: #type proc(renderer: ^Renderer, x: i32, y: i32, width: i32, height: i32)
		draw_glyph_func_ptr_anon_47 :: #type proc(renderer: ^Renderer, font: ^Font, glyph: Glyph, x: f64, y: f64)
		draw_glyph_item_func_ptr_anon_52 :: #type proc(renderer: ^Renderer, text: cstring, glyph_item: ^GlyphItem, x: i32, y: i32)
		draw_glyphs_func_ptr_anon_42 :: #type proc(renderer: ^Renderer, font: ^Font, glyphs: ^GlyphString, x: i32, y: i32)
		draw_rectangle_func_ptr_anon_43 :: #type proc(renderer: ^Renderer, part: RenderPart, x: i32, y: i32, width: i32, height: i32)
		draw_shape_func_ptr_anon_45 :: #type proc(renderer: ^Renderer, attr: ^AttrShape, x: i32, y: i32)
		draw_trapezoid_func_ptr_anon_46 :: #type proc(renderer: ^Renderer, part: RenderPart, y1_: f64, x11: f64, x21: f64, y2: f64, x12: f64, x22: f64)
		end_func_ptr_anon_50 :: #type proc(renderer: ^Renderer)
		equal_func_ptr_anon_23 :: #type proc(attr1: ^Attribute, attr2: ^Attribute) -> glib.boolean
		et_coverage_func_ptr_anon_14 :: #type proc(font: ^Font, language: ^Language) -> ^Coverage
		et_face_func_ptr_anon_38 :: #type proc(fontmap: ^FontMap, font: ^Font) -> ^FontFace
		et_face_func_ptr_anon_4 :: #type proc(family: ^FontFamily, name: cstring) -> ^FontFace
		et_face_name_func_ptr_anon_6 :: #type proc(face: ^FontFace) -> cstring
		et_family_func_ptr_anon_10 :: #type proc(face: ^FontFace) -> ^FontFamily
		et_family_func_ptr_anon_37 :: #type proc(fontmap: ^FontMap, name: cstring) -> ^FontFamily
		et_features_func_ptr_anon_19 :: #type proc(font: ^Font, features: [^]hb_feature_t, len: glib.uint_, num_features: ^glib.uint_)
		et_font_func_ptr_anon_24 :: #type proc(fontset: ^Fontset, wc: glib.uint_) -> ^Font
		et_font_map_func_ptr_anon_17 :: #type proc(font: ^Font) -> ^FontMap
		et_glyph_extents_func_ptr_anon_15 :: #type proc(font: ^Font, glyph: Glyph, ink_rect: ^Rectangle, logical_rect: ^Rectangle)
		et_language_func_ptr_anon_26 :: #type proc(fontset: ^Fontset) -> ^Language
		et_metrics_func_ptr_anon_16 :: #type proc(font: ^Font, language: ^Language) -> ^FontMetrics
		et_metrics_func_ptr_anon_25 :: #type proc(fontset: ^Fontset) -> ^FontMetrics
		et_name_func_ptr_anon_1 :: #type proc(family: ^FontFamily) -> cstring
		et_serial_func_ptr_anon_35 :: #type proc(fontmap: ^FontMap) -> glib.uint_
		foreach_func_ptr_anon_27 :: #type proc(fontset: ^Fontset, func: FontsetForeachFunc, data: glib.pointer)
		hb_feature_t :: struct {tag: hb_tag_t, value: u32, start: u32, end: u32}
		hb_font_t :: rawptr
		hb_tag_t :: u32
		is_monospace_func_ptr_anon_2 :: #type proc(family: ^FontFamily) -> glib.boolean
		is_synthesized_func_ptr_anon_9 :: #type proc(face: ^FontFace) -> glib.boolean
		is_variable_func_ptr_anon_3 :: #type proc(family: ^FontFamily) -> glib.boolean
		list_faces_func_ptr_anon_0 :: #type proc(family: ^FontFamily, faces: ^[^]^FontFace, n_faces: ^i32)
		list_families_func_ptr_anon_33 :: #type proc(fontmap: ^FontMap, families: ^[^]^FontFamily, n_families: ^i32)
		list_sizes_func_ptr_anon_8 :: #type proc(face: ^FontFace, sizes: ^[^]i32, n_sizes: ^i32)
		load_font_func_ptr_anon_32 :: #type proc(fontmap: ^FontMap, context_p: ^Context, desc: ^FontDescription) -> ^Font
		load_fontset_func_ptr_anon_34 :: #type proc(fontmap: ^FontMap, context_p: ^Context, desc: ^FontDescription, language: ^Language) -> ^Fontset
		part_changed_func_ptr_anon_48 :: #type proc(renderer: ^Renderer, part: RenderPart)
		prepare_run_func_ptr_anon_51 :: #type proc(renderer: ^Renderer, run: ^LayoutRun)
		script_break_func_ptr_anon_39 :: #type proc(engine: ^EngineLang, text: cstring, len: i32, analysis: ^Analysis, attrs: [^]LogAttr, attrs_len: i32)
		script_shape_func_ptr_anon_40 :: #type proc(engine: ^EngineShape, font: ^Font, item_text: cstring, item_length: u32, analysis: ^Analysis, glyphs: ^GlyphString, paragraph_text: cstring, paragraph_length: u32)

	files:
		hand.odin
		pango.odin
		patched.odin
```

## pangocairo

```text
package pangocairo
	variables
		patched_create_layout: proc(cr: ^cairo.context_t) -> ^pango.Layout = create_layout
		patched_update_context: proc(cr: ^cairo.context_t, context_p: ^pango.Context) = update_context
			runic names cairo's context `cairo.cairo_t`; odin-cairo calls it `cairo.context_t`.

	procedures
		context_get_font_options :: proc(context_p: ^pango.Context) -> ^cairo.font_options_t ---
		context_get_resolution :: proc(context_p: ^pango.Context) -> f64 ---
		context_get_shape_renderer :: proc(context_p: ^pango.Context, data: ^glib.pointer) -> ShapeRendererFunc ---
		context_set_font_options :: proc(context_p: ^pango.Context, options: ^cairo.font_options_t) ---
		context_set_resolution :: proc(context_p: ^pango.Context, dpi: f64) ---
		context_set_shape_renderer :: proc(context_p: ^pango.Context, func: ShapeRendererFunc, data: glib.pointer, dnotify: glib.DestroyNotify) ---
		create_context :: proc(cr: ^cairo.context_t) -> ^pango.Context ---
		create_layout :: proc(cr: ^cairo.context_t) -> ^pango.Layout ---
		error_underline_path :: proc(cr: ^cairo.context_t, x: f64, y: f64, width: f64, height: f64) ---
		font_get_scaled_font :: proc(font: ^Font) -> ^cairo.scaled_font_t ---
		font_get_type :: proc() -> gobj.Type ---
		font_get_type :: proc() -> gobj.Type ---
		font_map_create_context :: proc(fontmap: ^FontMap) -> ^pango.Context ---
		font_map_get_default :: proc() -> ^pango.FontMap ---
		font_map_get_font_type :: proc(fontmap: ^FontMap) -> cairo.font_type_t ---
		font_map_get_resolution :: proc(fontmap: ^FontMap) -> f64 ---
		font_map_get_type :: proc() -> gobj.Type ---
		font_map_get_type :: proc() -> gobj.Type ---
		font_map_new :: proc() -> ^pango.FontMap ---
		font_map_new_for_font_type :: proc(fonttype: cairo.font_type_t) -> ^pango.FontMap ---
		font_map_set_default :: proc(fontmap: ^FontMap) ---
		font_map_set_resolution :: proc(fontmap: ^FontMap, dpi: f64) ---
		glyph_string_path :: proc(cr: ^cairo.context_t, font: ^pango.Font, glyphs: ^pango.GlyphString) ---
		layout_line_path :: proc(cr: ^cairo.context_t, line: ^pango.LayoutLine) ---
		layout_path :: proc(cr: ^cairo.context_t, layout: ^pango.Layout) ---
		show_error_underline :: proc(cr: ^cairo.context_t, x: f64, y: f64, width: f64, height: f64) ---
		show_glyph_item :: proc(cr: ^cairo.context_t, text: cstring, glyph_item: ^pango.GlyphItem) ---
		show_glyph_string :: proc(cr: ^cairo.context_t, font: ^pango.Font, glyphs: ^pango.GlyphString) ---
		show_layout :: proc(cr: ^cairo.context_t, layout: ^pango.Layout) ---
		show_layout_line :: proc(cr: ^cairo.context_t, line: ^pango.LayoutLine) ---
		update_context :: proc(cr: ^cairo.context_t, context_p: ^pango.Context) ---
		update_layout :: proc(cr: ^cairo.context_t, layout: ^pango.Layout) ---

	types
		Font :: struct #packed {}
		FontMap :: struct #packed {}
		ShapeRendererFunc :: #type proc(cr: ^cairo.context_t, attr: ^pango.AttrShape, do_path: glib.boolean, data: glib.pointer)

	files:
		pangocairo.odin
		patched.odin
```
