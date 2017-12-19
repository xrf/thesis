metadata=-M title="Addition and removal energies via the in-medium similarity renormalization group method" \
         -M author="Fei Yuan"

pandoc_args=--mathjax --number-sections --natbib \
            -M bibliography=book.bib \
            -M biblio-title=References \
            -M colorlinks \
            -M date=2017 \
            -M link-citations=true \
            -M lof \
            -M lot \
            -M toc

latex_documentclass=msudissertation
latex_pandoc_deps=head.tex
latex_pandoc_args=-H $(1)
latex_pandoc_args:=$(call latex_pandoc_args,$(latex_pandoc_deps))

latex_merge_args=--front-in-body=key-to-symbols.md

tool_dir=.local/src/book-mk
include $(tool_dir)/book.mk
