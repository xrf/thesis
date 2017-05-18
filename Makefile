metadata=-M title="Addition and removal energies via the in-medium similarity renormalization group method" \
         -M author="Fei Yuan"

pandoc_args=-S \
	    --natbib \
	    -M bibliography=book.bib \
	    -M biblio-title=References \
	    -M colorlinks \
	    -M date=2017 \
	    -M documentclass=msudissertation \
	    -M link-citations=true \
	    -M lof \
	    -M lot \
	    -M toc

latex_pandoc_args=-H head.tex

tool_dir=.local/src/book-mk
include $(tool_dir)/book.mk
