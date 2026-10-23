# Both documents share section files, typography, and the BibTeX database.
.DEFAULT_GOAL := all
PDFLATEX := pdflatex -interaction=nonstopmode -halt-on-error

.PHONY: all full resume cv.pdf resume.pdf clean clean-all
all: full resume
full: cv.pdf
resume: resume.pdf

cv.pdf:
	$(PDFLATEX) -jobname=cv main.tex
	bibtex cv
	$(PDFLATEX) -jobname=cv main.tex
	$(PDFLATEX) -jobname=cv main.tex

resume.pdf:
	$(PDFLATEX) resume.tex
	bibtex resume
	$(PDFLATEX) resume.tex
	$(PDFLATEX) resume.tex

clean:
	rm -f *.dvi *.log *.aux *.bbl *.blg *.toc *.lof *.lot *.cb *.~ *.out *.fdb_latexmk *.fls *.synctex.gz *.bcf *.run.xml *-blx.bib
	rm -f sections/*.aux

clean-all: clean
	rm -f cv.pdf resume.pdf

# Mount the workspace so generated PDFs remain available on the host.
DOCKER-CMD := ./docker.sh
CONTAINER := cv-container

.PHONY: docker-build docker-run docker-all docker-full docker-resume
docker-build:
	$(DOCKER-CMD) build -t $(CONTAINER) .

docker-run: docker-build
	$(DOCKER-CMD) run --rm -it -v "$(CURDIR):/cv" $(CONTAINER)

docker-all: docker-build
	$(DOCKER-CMD) run --rm -v "$(CURDIR):/cv" $(CONTAINER) make all

docker-full: docker-build
	$(DOCKER-CMD) run --rm -v "$(CURDIR):/cv" $(CONTAINER) make full

docker-resume: docker-build
	$(DOCKER-CMD) run --rm -v "$(CURDIR):/cv" $(CONTAINER) make resume
