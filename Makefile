# odin-pango: Odin bindings for Pango and PangoCairo. Consumed via -collection:pango=/path/to/odin-pango
# What every runic binding does is in house/binding.mk, a copy of house-rules'
# scripts/binding/binding.mk: this repository is public, and its runner has no house-rules.
# project.toml names the kind, the steps, the packages, the siblings and the system packages.
include house/binding.mk

# pango/bitfields.txt is what hand_test.odin checks the hand-written bit_fields against;
# project.toml's steps run it in make ci.
.PHONY: check-bitfields
check-bitfields: ## compile C against the headers and compare each bit field's mask with pango/bitfields.txt
	@scripts/bitfields.sh | diff - pango/bitfields.txt && echo "bitfields OK"
