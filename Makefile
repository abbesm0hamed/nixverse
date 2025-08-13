# NixOS Flakes Management Makefile
# Usage: make <target>

.PHONY: help build switch boot test update upgrade clean check format lint

# Default target
help:
	@echo "NixOS Flakes Management Commands:"
	@echo ""
	@echo "Build Commands:"
	@echo "  build-workstation  - Build workstation configuration"
	@echo "  build-minimal      - Build minimal configuration"
	@echo ""
	@echo "System Commands:"
	@echo "  switch-workstation - Build and switch to workstation configuration"
	@echo "  switch-minimal     - Build and switch to minimal configuration"
	@echo "  boot-workstation   - Build and set workstation as next boot"
	@echo "  boot-minimal       - Build and set minimal as next boot"
	@echo "  test-workstation   - Test workstation configuration (temporary)"
	@echo "  test-minimal       - Test minimal configuration (temporary)"
	@echo ""
	@echo "Home Manager Commands:"
	@echo "  home-switch        - Switch home-manager configuration"
	@echo ""
	@echo "Maintenance Commands:"
	@echo "  update             - Update flake inputs"
	@echo "  upgrade            - Update and rebuild system"
	@echo "  clean              - Clean old generations and garbage collect"
	@echo "  check              - Check flake for errors"
	@echo "  format             - Format Nix files with nixpkgs-fmt"
	@echo ""
	@echo "Git Commands:"
	@echo "  commit             - Add, commit and push changes"
	@echo ""

# Build configurations
build-workstation:
	@echo "Building workstation configuration..."
	sudo nixos-rebuild build --flake .#workstation

build-minimal:
	@echo "Building minimal configuration..."
	sudo nixos-rebuild build --flake .#minimal

# Switch configurations
switch-workstation:
	@echo "Switching to workstation configuration..."
	sudo nixos-rebuild switch --flake .#workstation

switch-minimal:
	@echo "Switching to minimal configuration..."
	sudo nixos-rebuild switch --flake .#minimal

# Boot configurations
boot-workstation:
	@echo "Setting workstation as next boot configuration..."
	sudo nixos-rebuild boot --flake .#workstation

boot-minimal:
	@echo "Setting minimal as next boot configuration..."
	sudo nixos-rebuild boot --flake .#minimal

# Test configurations (temporary, reverts on reboot)
test-workstation:
	@echo "Testing workstation configuration (temporary)..."
	sudo nixos-rebuild test --flake .#workstation

test-minimal:
	@echo "Testing minimal configuration (temporary)..."
	sudo nixos-rebuild test --flake .#minimal

# Home Manager
home-switch:
	@echo "Switching home-manager configuration..."
	home-manager switch --flake .

# Maintenance
update:
	@echo "Updating flake inputs..."
	nix flake update

upgrade: update switch-workstation
	@echo "System upgraded successfully!"

clean:
	@echo "Cleaning old generations and garbage collecting..."
	sudo nix-collect-garbage -d
	sudo nixos-rebuild switch --flake .#workstation
	@echo "Cleanup completed!"

check:
	@echo "Checking flake for errors..."
	nix flake check

format:
	@echo "Formatting Nix files..."
	find . -name "*.nix" -exec nixpkgs-fmt {} \;

# Development helpers
lint:
	@echo "Linting Nix files..."
	find . -name "*.nix" -exec statix check {} \;

# Git workflow
commit:
	@echo "Committing changes..."
	@read -p "Enter commit message: " msg; \
	git add . && \
	git commit -m "$$msg" && \
	git push origin main

# Hardware configuration helpers
copy-hardware:
	@echo "Copying hardware configuration from /etc/nixos/..."
	@read -p "Enter host name (workstation/minimal): " host; \
	sudo cp /etc/nixos/hardware-configuration.nix ./hosts/$$host/hardware-configuration.nix && \
	sudo chown $(USER):$(USER) ./hosts/$$host/hardware-configuration.nix && \
	echo "Hardware configuration copied to ./hosts/$$host/hardware-configuration.nix"

# Show system info
info:
	@echo "System Information:"
	@echo "Current generation: $$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | tail -1)"
	@echo "Flake inputs:"
	@nix flake metadata

# Emergency rollback
rollback:
	@echo "Rolling back to previous generation..."
	sudo nixos-rebuild switch --rollback
