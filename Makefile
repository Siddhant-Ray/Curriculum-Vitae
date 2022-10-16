
NOTE  = !! change the next line to fit your filename; no spaces at file name end !!
FULL  = main
SINGLE = onepage

FNAME  = cv
SNAME = resume

all:
	pdflatex -jobname=$(FNAME) $(FULL)
	bibtex $(FNAME)
	pdflatex -jobname=$(FNAME) $(FULL)
	pdflatex -jobname=$(FNAME) $(FULL)

	xelatex -jobname=$(SNAME) $(SINGLE)
	xelatex -jobname=$(SNAME) $(SINGLE)

full:
	pdflatex -jobname=$(FNAME) $(FULL)
	bibtex $(FNAME)
	pdflatex -jobname=$(FNAME) $(FULL)
	pdflatex -jobname=$(FNAME) $(FULL)

one:
	xelatex -jobname=$(SNAME) $(SINGLE)
	xelatex -jobname=$(SNAME) $(SINGLE)

.PHONY: clean	
clean:
	rm -f *.dvi *.log *.aux *.bbl *.blg *.toc *.lof *.lot *.cb *.~ *.out *.fdb_latexmk *.fls
	rm -f sections/*.aux
	rm -f *.pdf
