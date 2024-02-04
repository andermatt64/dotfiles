FLAKE_TEMPLATE_DIR := ./templates
FLAKE_GENERATOR := ./scripts/generate-flake
FLAKE_TARGETS := flake.nix home.nix

all: ${FLAKE_TARGETS} 
	
clean:
	$(info Removing ${FLAKE_TARGETS})
	-@rm ${FLAKE_TARGETS}
	  
.PHONY: all clean

flake.nix: ${FLAKE_TEMPLATE_DIR}/flake.template.nix
	$(info Generating $@ from $<)
	@${FLAKE_GENERATOR} --output $@ $<

home.nix: ${FLAKE_TEMPLATE_DIR}/home.template.nix
	$(info Generating $@ from $<)
	@${FLAKE_GENERATOR} --output $@ $<

