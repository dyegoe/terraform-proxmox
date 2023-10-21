include ../Makefile

ifndef TF_VAR_ssh_public_key
$(error TF_VAR_ssh_public_key is not set. Please export TF_VAR_ssh_public_key=<you_ssh_public_key>)
endif
ifndef TF_VAR_proxmox_password
$(error TF_VAR_proxmox_password is not set. Please export TF_VAR_proxmox_password=<your_password>)
endif
ifndef TF_VAR_cloudflare_api_token
$(error TF_VAR_cloudflare_api_token is not set. Please export TF_VAR_cloudflare_api_token=<your_token>)
endif

TFNAME := example
TFMSG := example

INIT_FILES := .terraform .terraform.lock.hcl
PLAN_FILES := $(TFNAME).tfplan

$(INIT_FILES):
	@$(call msg_tfinit_start,$(TFMSG))
	@terraform init
	@$(call msg_tfinit_end,$(TFMSG))

$(PLAN_FILES): $(INIT_FILES)
	@$(call msg_tfplan_start,$(TFMSG))
	@terraform plan -out=$(PLAN_FILES)
	@$(call msg_tfplan_end,$(TFMSG))

.PHONY: tfinit tfupgrade tfplan tfapply tfdestroy clean-init clean-plan clean

tfinit: $(INIT_FILES) ## terraform init

tfupgrade: tfinit ## terraform init -upgrade
	@$(call msg_tfupgrade_start,$(TFMSG))
	@terraform init -upgrade
	@$(call msg_tfupgrade_end,$(TFMSG))

tfplan: $(PLAN_FILES) ## terraform plan -out
tfplan-force: clean-plan $(PLAN_FILES) ## clean plan files && terraform plan

tfapply: $(PLAN_FILES) ## terraform apply
	@$(call msg_tfapply_start,$(TFMSG))
	@terraform apply $(PLAN_FILES)
	@rm -f $(PLAN_FILES)
	@$(call msg_tfapply_end,$(TFMSG))

tfdestroy: ## terraform destroy
	@$(call msg_tfdestroy_start,$(TFMSG))
	@terraform destroy
	@$(call msg_tfdestroy_end,$(TFMSG))

clean-init: ## clean init files
	@$(call msg_clean_init,$(TFMSG))
	@rm -rf $(INIT_FILES)

clean-plan: ## clean plan files
	@$(call msg_clean_plan,$(TFMSG))
	@rm -f $(PLAN_FILES)

clean: clean-init clean-plan ## clean init and plan files
	@$(call msg_clean_end,$(TFMSG))

.DEFAULT_GOAL := tfapply
