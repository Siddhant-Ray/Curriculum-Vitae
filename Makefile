
NOTE  = !! change the next line to fit your filename; no spaces at file name end !!
FULL  = main
SINGLE = onepage

all:
	pdflatex -jobname='cv' $(FULL)
	pdflatex -jobname='cv' $(FULL)
	xelatex -jobname='resume' $(SINGLE)
	xelatex -jobname='resume' $(SINGLE)

full:
	pdflatex -jobname='cv' $(FULL)
	pdflatex -jobname='cv' $(FULL)

one:
	xelatex -jobname='resume' $(SINGLE)
	xelatex -jobname='resume' $(SINGLE)

clean:
	rm -f *.dvi *.log *.aux *.bbl *.blg *.toc *.lof *.lot *.cb *.~ *.out *.fdb_latexmk *.fls
	rm -f sections/*.aux
	rm -f *.pdf
