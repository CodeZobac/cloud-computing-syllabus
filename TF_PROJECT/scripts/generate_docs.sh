#!/usr/bin/env bash

# Install terraform-docs if needed
# On Linux (x86_64):
# wget https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-linux-amd64.tar.gz
# tar xzf terraform-docs-*.tar.gz
# sudo mv terraform-docs /usr/local/bin/

# Generate docs
terraform-docs markdown . > ../README.md
echo "Project documentation generated in README.md"