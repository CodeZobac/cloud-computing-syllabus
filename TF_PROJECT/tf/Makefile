start:
	terraform init
	@for ws in Netflix Rockstar Meta; do \
		terraform workspace new $$ws || terraform workspace select $$ws; \
	done

plan:
	terraform plan -out=plan

apply:
	@CURRENT_WS=$$(terraform workspace show) && \
	terraform apply -auto-approve -var-file="$$CURRENT_WS.tfvars" plan

select-workspace:
	@echo "Available workspaces:"
	@terraform workspace list
	@read -p "Enter workspace name: " WS && terraform workspace select $$WS

add-env:
	@WORKSPACE=$$(terraform workspace show) && \
	read -p "Enter the new environment name (e.g., staging): " NEW_ENV && \
	read -p "Enter the number of replicas for $$NEW_ENV: " REPLICAS && \
	TFVARS_FILE="$$WORKSPACE.tfvars" && \
	if [ ! -f "$$TFVARS_FILE" ]; then \
		echo 'envs = []' > "$$TFVARS_FILE"; \
		echo 'replicas = {}' >> "$$TFVARS_FILE"; \
		echo "Initialized $$TFVARS_FILE"; \
	fi && \
	if grep -q 'envs = \[' "$$TFVARS_FILE"; then \
		sed -i 's/envs = \[/& "'"$$NEW_ENV"'" ,/' "$$TFVARS_FILE"; \
	else \
		echo "envs = [\"$$NEW_ENV\"]" >> "$$TFVARS_FILE"; \
	fi && \
	if grep -q 'replicas = {' "$$TFVARS_FILE"; then \
		sed -i '/replicas = {/a\  '"$$NEW_ENV"' = '"$$REPLICAS"',' "$$TFVARS_FILE"; \
	else \
		echo 'replicas = {' >> "$$TFVARS_FILE"; \
		echo '  '"$$NEW_ENV"' = '"$$REPLICAS"'' >> "$$TFVARS_FILE"; \
		echo '}' >> "$$TFVARS_FILE"; \
	fi && \
	echo "Added environment '$$NEW_ENV' with $$REPLICAS replicas to workspace '$$WORKSPACE'." && \
	terraform plan -out=plan && \
	terraform apply -auto-approve plan

create-workspace:
	@read -p "Enter the new client name: " NEW_CLIENT && \
	terraform workspace new $$NEW_CLIENT && \
	echo 'envs = ["dev", "qa", "prod"]' > "$$NEW_CLIENT.tfvars" && \
	echo 'replicas = {' >> "$$NEW_CLIENT.tfvars" && \
	echo '  dev  = 1' >> "$$NEW_CLIENT.tfvars" && \
	echo '  qa   = 2' >> "$$NEW_CLIENT.tfvars" && \
	echo '  prod = 3' >> "$$NEW_CLIENT.tfvars" && \
	echo '}' >> "$$NEW_CLIENT.tfvars" && \
	echo "Workspace and tfvars file for '$$NEW_CLIENT' created."

list-workspaces:
	terraform workspace list

destroy:
	terraform destroy -auto-approve

docs:
	terraform-docs markdown . > ../TF_DOCS.md
	echo "Project documentation generated in TF_DOCS.md"
	
help:
	@echo "Available Makefile commands:"
	@echo "  start            Initialize Terraform and create/select workspaces for existing clients"
	@echo "  plan             Generate and save an execution plan"
	@echo "  apply            Apply the saved execution plan"
	@echo "  select-workspace Select an existing workspace"
	@echo "  add-env          Add a new environment to the current workspace"
	@echo "  create-workspace Create a new workspace for a new client"
	@echo "  list-workspaces  List all Terraform workspaces"
	@echo "  destroy          Destroy all resources in the current workspace"
	@echo "  help             Show this help menu"