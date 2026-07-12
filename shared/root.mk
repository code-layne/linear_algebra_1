# shared/root.mk — included by the project-root Makefile (just `include shared/root.mk`).
# Discovers every unit*/Makefile, delegates to it, and merges the per-unit packets
# into target/compiled/curriculum_{student,full}.pdf.

PROJECT_ROOT := $(CURDIR)
COMPILED_DIR := $(PROJECT_ROOT)/target/compiled

# Auto-discover units that have a Makefile, in sorted order.
UNITS := $(patsubst %/Makefile,%,$(sort $(wildcard unit*/Makefile)))

.PHONY: all student full clean distclean $(UNITS)

all: $(UNITS)

$(UNITS):
	$(MAKE) -C $@

student:
	@for u in $(UNITS); do $(MAKE) -C $$u student || exit 1; done
	@mkdir -p $(COMPILED_DIR)
	@unit_pdfs=$$(ls $(COMPILED_DIR)/unit*_student.pdf 2>/dev/null | sort); \
	if [ -n "$$unit_pdfs" ]; then \
	  pdfunite $$unit_pdfs $(COMPILED_DIR)/curriculum_student.pdf; \
	  echo "✓  Curriculum student packet → target/compiled/curriculum_student.pdf"; \
	else \
	  echo "  (no unit student PDFs found)"; \
	fi

full:
	@for u in $(UNITS); do $(MAKE) -C $$u full || exit 1; done
	@mkdir -p $(COMPILED_DIR)
	@unit_pdfs=$$(ls $(COMPILED_DIR)/unit*_full.pdf 2>/dev/null | sort); \
	if [ -n "$$unit_pdfs" ]; then \
	  pdfunite $$unit_pdfs $(COMPILED_DIR)/curriculum_full.pdf; \
	  echo "✓  Curriculum full packet    → target/compiled/curriculum_full.pdf"; \
	else \
	  echo "  (no unit full PDFs found)"; \
	fi

clean:
	@for u in $(UNITS); do $(MAKE) -C $$u clean; done

distclean: clean
	rm -rf $(PROJECT_ROOT)/target $(PROJECT_ROOT)/.stamps
