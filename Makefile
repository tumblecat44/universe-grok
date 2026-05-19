# Universe Grok - Common Development Targets

.PHONY: doctor test-local-marketplace simulate-tier0 clean-cache help

doctor:
	@./scripts/universe-doctor.sh --verbose

test-local-marketplace:
	@./scripts/create-local-marketplace.sh --print-toml-snippet

simulate-tier0:
	@bash ./scripts/simulate-contribution.sh --tier0 --verify-injection

clean-cache:
	@./scripts/clear-grok-cache.sh

help:
	@echo "Universe Grok Development Commands:"
	@echo "  make doctor                - Run full diagnostic"
	@echo "  make test-local-marketplace - Show how to register local marketplace"
	@echo "  make simulate-tier0        - Nuclear safety test for hook/Layer 0 changes"
	@echo "  make clean-cache           - Clear Grok caches (recovery after edits)"