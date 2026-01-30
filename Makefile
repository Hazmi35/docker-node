# Makefile for Docker Node.js Images
# Uses Docker Bake for efficient multi-platform builds

.PHONY: help generate-bake build build-all push test clean list-targets

# Default target
help: ## Show this help message
	@echo "Docker Node.js Images - Build Commands"
	@echo "======================================"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

generate-bake: ## Generate docker-bake.hcl from Dockerfile metadata
	@echo "Generating Docker Bake configuration..."
	@python3 scripts/generate-bake.py
	@echo "✅ Generated docker-bake.hcl"
	@if git diff --quiet docker-bake.hcl; then \
		echo "📝 No changes to docker-bake.hcl"; \
	else \
		echo "📝 docker-bake.hcl has changes - consider committing"; \
	fi

build: generate-bake ## Build all images (dry-run, no push)
	@echo "Building all Docker images..."
	@docker buildx bake all

build-25: generate-bake ## Build only Node.js 25 images
	@echo "Building Node.js 25 images..."
	@docker buildx bake node-25

build-24: generate-bake ## Build only Node.js 24 images
	@echo "Building Node.js 24 images..."
	@docker buildx bake node-24

build-22: generate-bake ## Build only Node.js 22 images
	@echo "Building Node.js 22 images..."
	@docker buildx bake node-22

build-20: generate-bake ## Build only Node.js 20 images
	@echo "Building Node.js 20 images..."
	@docker buildx bake node-20

push: generate-bake ## Build and push all images to registries
	@echo "Building and pushing all Docker images..."
	@docker buildx bake all --push

push-25: generate-bake ## Build and push only Node.js 25 images
	@echo "Building and pushing Node.js 25 images..."
	@docker buildx bake node-25 --push

test: generate-bake ## Test bake configuration without building
	@echo "Testing Docker Bake configuration..."
	@docker buildx bake --print all > /dev/null && echo "✅ Configuration is valid!"

list-targets: generate-bake ## List all available build targets
	@echo "Available Docker Bake targets:"
	@echo "============================="
	@docker buildx bake --print all | jq -r '.group | keys[]' | sort
	@echo ""
	@echo "Individual targets:"
	@docker buildx bake --print all | jq -r '.target | keys[]' | sort

clean: ## Clean up generated files and Docker build cache
	@echo "Cleaning up..."
	@rm -f docker-bake.hcl
	@docker buildx prune -f
	@echo "✅ Cleanup complete"

validate-dockerfiles: ## Validate all Dockerfiles with hadolint
	@echo "Validating Dockerfiles with hadolint..."
	@find . -name "Dockerfile" -not -path "./.devcontainer/*" -exec hadolint {} \; || true

lint: validate-dockerfiles ## Run linting checks

# Development targets
dev-build-single: ## Build a single target (usage: make dev-build-single TARGET=25-alpine)
ifndef TARGET
	@echo "❌ Error: TARGET is required. Usage: make dev-build-single TARGET=25-alpine"
	@exit 1
endif
	@echo "Building target: $(TARGET)"
	@docker buildx bake $(TARGET)

dev-shell: ## Start an interactive shell in the latest image
	@docker run -it --rm hazmi35/node:latest sh

# CI targets (used by GitHub Actions)
ci-generate: generate-bake ## Generate bake config for CI
	@echo "docker-bake.hcl generated for CI"

ci-build: ## CI build target (no push)
	@PUSH=false docker buildx bake all

ci-push: ## CI push target
	@PUSH=true docker buildx bake all

# Test workflow changes locally
test-pr: generate-bake ## Test PR workflow (build only, no push)
	@echo "Testing PR workflow (build only)..."
	@PUSH=false docker buildx bake all

test-main: generate-bake ## Test main branch workflow (build and push)
	@echo "Testing main branch workflow (build and push)..."
	@PUSH=true docker buildx bake all

# Simulate change detection
check-changes: ## Show what would be built based on git changes
	@echo "Checking for changes..."
	@python3 scripts/generate-bake.py --detect-changes

detect-targets: check-changes ## Alias for check-changes

# Build only changed targets
build-changed: generate-bake ## Build only targets that have changed
	@echo "Building only changed targets..."
	@output=$$(python3 scripts/generate-bake.py --detect-changes); \
	targets=$$(echo "$$output" | grep "TARGETS=" | cut -d'=' -f2-); \
	if [ "$$targets" = "none" ]; then \
		echo "No changes detected, nothing to build"; \
	elif [ "$$targets" = "all" ]; then \
		echo "Building all targets"; \
		docker buildx bake all; \
	else \
		echo "Building targets: $$targets"; \
		IFS=',' read -ra TARGET_ARRAY <<< "$$targets"; \
		for target in "$${TARGET_ARRAY[@]}"; do \
			docker buildx bake "$$target"; \
		done; \
	fi
