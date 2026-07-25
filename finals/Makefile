# finals/Makefile — build the cumulative course final exam.
# Standalone (mirrors shared/tests.mk) — each subdirectory holding a main.tex
# compiles to target/finals/<name>/main.pdf. There is no drop/sample step: the
# practice final and its key are the study copies; the final and its key are the
# real exam, distributed separately at exam time.

PROJECT_ROOT := $(abspath ..)
TEXINPUTS    := $(PROJECT_ROOT)/shared//:
PDF_DIR      := $(PROJECT_ROOT)/target/finals
LATEXFLAGS   := -xelatex -interaction=nonstopmode -halt-on-error -file-line-error

FINALS := $(patsubst %/main.tex,%,$(wildcard */main.tex))

.PHONY: all clean $(FINALS)

all: $(FINALS)

$(FINALS):
	@mkdir -p $(PDF_DIR)/$@
	cd $@ && TEXINPUTS="$(TEXINPUTS)" latexmk $(LATEXFLAGS) \
	    -outdir="$(PDF_DIR)/$@" main.tex
	@echo "OK  final -> target/finals/$@/main.pdf"

clean:
	rm -rf $(PDF_DIR)
