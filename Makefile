
NOTE  = !! change the next line to fit your filename; no spaces at file name end !!
FILE  = main

all:
	pdflatex -jobname='cv' $(FILE)
	pdflatex -jobname='cv' $(FILE)

clean:
	rm -f *.dvi *.log *.aux *.bbl *.blg *.toc *.lof *.lot *.cb *.~ *.out *.fdb_latexmk *.fls
