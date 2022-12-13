
NOTE  = !! change the next line to fit your filename; no spaces at file name end !!
FULL  = main
SINGLE = onepage

FNAME  = cv
SNAME = resume

# Config path
PUBS = fonts/config/pubs.config
CP = fonts/config/cp.config

################
#### NATIVE ####
################

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

################
#### Docker ####
################

# Docker command (sudo if needed)
DOCKER-CMD := ./docker.sh

# Current directory
CVDIR := $$(pwd)

# Docker image
IMAGE := ethsrilab/latex-plus:version-4.0

# Docker container name
CONTAINER := cv-container

# Build docker image from Dockerfile
BUILD := $(DOCKER-CMD) build \
 		-t $(CONTAINER) .

# Run docker container
RUN := $(DOCKER-CMD) run \
		-it \
		--name $(CONTAINER) \
		$(CONTAINER)

# Launch a docker container using the image, which will provide a shell in the container
.PHONY: docker-run
docker-run: clean-container
	$(BUILD)
	$(RUN)

# Check for updates and remove the created docker container
.PHONY: clean-container
clean-container:
	$(DOCKER-CMD) pull $(IMAGE)
	$(DOCKER-CMD) rm /$(CONTAINER) 2>/dev/null || true

# Run everything in the docker container
.PHONY: docker-all
docker-all: clean-container
	$(RUN) make full one one-pub
	$(DOCKER-CMD) cp $(CONTAINER):/cv/cv.pdf $(CVDIR)/cv.pdf
	$(DOCKER-CMD) cp $(CONTAINER):/cv/resume.pdf $(CVDIR)/resume.pdf
	$(DOCKER-CMD) cp $(CONTAINER):/cv/resume_pub.pdf $(CVDIR)/resume_pub.pdf

# Make full CV in the docker container
.PHONY: docker-full
docker-full: clean-container
	$(RUN) make full
	$(DOCKER-CMD) cp $(CONTAINER):/cv/cv.pdf $(CVDIR)/cv.pdf

# Make single page CV in the docker container
.PHONY: docker-one
docker-one: clean-container
	$(RUN) make one
	$(DOCKER-CMD) cp $(CONTAINER):/cv/resume.pdf $(CVDIR)/resume.pdf

# Make single page CV with publications in the docker container
.PHONY: docker-one-pub
docker-one-pub: clean-container
	$(RUN) make one-pub
	$(DOCKER-CMD) cp $(CONTAINER):/cv/resume_pub.pdf $(CVDIR)/resume_pub.pdf
