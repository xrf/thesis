metadata=-M title="Addition and removal energies via the in-medium similarity renormalization group method" \
         -M author="Fei Yuan"

pandoc_args=--mathjax --number-sections --biblatex \
            -M biblatexoptions=maxbibnames=99 \
            -M bibliography=book.bib \
            -M biblio-style=alphabetic \
            -M biblio-title=References,heading=bibintoc \
            -M citecolor=OliveGreen \
            -M classoption=fleqn \
            -M colorlinks \
            -M date=2017 \
            -M indent \
            -M link-citations=true \
            -M lof \
            -M lot \
            -M toc

latex_documentclass=msudissertation
latex_pandoc_deps=head.tex
latex_pandoc_args=-H $(1)
latex_pandoc_args:=$(call latex_pandoc_args,$(latex_pandoc_deps))

latex_merge_args=--front-in-body=key-to-symbols.md

assets=$(patsubst %.svg,%.pdf,$(wildcard src/*.svg))

tool_dir=.local/src/book-mk
include $(tool_dir)/book.mk

.svg.pdf:
	inkscape --without-gui --export-pdf=$@ $<
