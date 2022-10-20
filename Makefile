
NOTE  = !! change the next line to fit your filename; no spaces at file name end !!
FULL  = main
SINGLE = onepage

FNAME  = cv
SNAME = resume

# Config path
PUBS = fonts/config/pubs.config
CP = fonts/config/cp.config

all:
	make full one one-pub

full:
	pdflatex -jobname=$(FNAME) $(FULL)
	bibtex $(FNAME)
	pdflatex -jobname=$(FNAME) $(FULL)
	pdflatex -jobname=$(FNAME) $(FULL)

one:
	xelatex -jobname=$(SNAME) $(SINGLE)
	xelatex -jobname=$(SNAME) $(SINGLE)

one-pub:
	touch $(PUBS)
	xelatex -jobname=$(SNAME)_pub $(SINGLE)
	bibtex $(SNAME)_pub
	xelatex -jobname=$(SNAME)_pub $(SINGLE)
	xelatex -jobname=$(SNAME)_pub $(SINGLE)
	rm -f $(PUBS)

.PHONY: clean	
clean:
	rm -f *.dvi *.log *.aux *.bbl *.blg *.toc *.lof *.lot *.cb *.~ *.out *.fdb_latexmk *.fls
	rm -f sections/*.aux
	
.PHONY: clean-all
clean-all: clean
	rm -f *.pdf
