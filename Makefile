.PHONY: all help build watch

# Dependencies
DEPS := ruby gem gcc g++ make jekyll bundler
$(foreach bin,$(DEPS),\
		$(if $(shell command -v $(bin) 2> /dev/null),$(@info Found `$(bin)`),$(error Please install `$(bin)`)))

all: help

## Development:
build: ## Build the site
	@bundle exec jekyll serve

watch: ## Build and watch for changes
	@bundle exec jekyll serve --livereload

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

## Help:
help: ## Show this help.
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} { \
		if (/^[a-zA-Z_-]+:.*?##.*$$/) {printf "    ${YELLOW}%-20s${GREEN}%s${RESET}\n", $$1, $$2} \
		else if (/^## .*$$/) {printf "  ${CYAN}%s${RESET}\n", substr($$1,4)} \
		}' $(MAKEFILE_LIST)
