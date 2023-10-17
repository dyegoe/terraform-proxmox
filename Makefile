TARGETS := .terraform .terraform.lock.hcl *.tfstate *.tfstate.* *.tfvars *tfplan*

.PHONY: examples
examples: ## run examples
	@echo "Running examples"
	@cd examples && make

.PHONY: clean-all ## clean all
clean-all:
	@echo "Cleaning root directory"
	@rm -rf $(TARGETS)
	@echo "Cleaning modules/vm"
	@cd modules/vm && rm -rf $(TARGETS)
	@echo "Cleaning modules/images"
	@cd modules/images && rm -rf $(TARGETS)
	@echo "Cleaning examples"
	@cd examples && rm -rf $(TARGETS)

.PHONY: help
help:
	@printf "${COLOR_GREEN}${COLOR_BOLD}[Available targets]${COLOR_RESET}\n"
	@grep -E '^\S+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "${COLOR_BLUE}%-30s${COLOR_RESET} %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

########## Colors ##########

COLOR_GREEN := \033[0;32m
COLOR_BLUE := \033[0;34m
COLOR_CIAN := \033[0;36m
COLOR_BOLD := \033[1m
COLOR_RESET := \033[0m

########## Functions ##########
define msg_tfinit_start
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Setting up Terraform backend ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_tfinit_end
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Terraform backend set up finished ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_tfupgrade_start
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Upgrading Terraform modules ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_tfupgrade_end
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Terraform modules upgrade finished ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_tfplan_start
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Planning Terraform ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_tfplan_end
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## terraform plan -out finished ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_tfapply_start
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Applying Terraform ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_tfapply_end
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Terraform apply finished ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_tfdestroy_start
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Destroying Terraform ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_tfdestroy_end
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Terraform destroy finished ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_clean_init
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Cleaning Terraform init ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_clean_plan
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Cleaning Terraform plan ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
define msg_clean_end
	@printf "${COLOR_BLUE}${COLOR_BOLD}########## Terraform clean finished ${COLOR_CIAN}${COLOR_BOLD}[${1}] ${COLOR_BLUE}${COLOR_BOLD}##########${COLOR_RESET}\n"
endef
