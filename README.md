# Curriculum-Vitae

This repository contains my current CV and one-page resume:

- [Full CV (PDF)](https://github.com/Siddhant-Ray/Curriculum-Vitae/releases/latest/download/cv.pdf): two-page CV.
- [Resume (PDF)](https://github.com/Siddhant-Ray/Curriculum-Vitae/releases/latest/download/resume.pdf): one-page, two-column resume.

## Sources and content

[`main.tex`](main.tex) builds `cv.pdf`; [`resume.tex`](resume.tex) builds
`resume.pdf`. Both use the same Latin Modern serif typography from
[`styles/cv-preamble.tex`](styles/cv-preamble.tex), contact header, and content
files in [`sections/`](sections/).

Publications are automatically populated from [`cv.bib`](cv.bib) using
[`styles/plainyrrev.bst`](styles/plainyrrev.bst), sorted newest first by year
and month, with only years displayed. Titles are bold and linked, the author's
name is underlined, and venues appear below the author lists. Resume-only selection and layout
rules live in `resume.tex`.

## Build locally

Install Make and a TeX Live distribution with pdfLaTeX, BibTeX, Latin Modern,
Font Awesome 5, and the packages loaded by `styles/cv-preamble.tex`.
A full TeX Live installation includes these dependencies. Neither document
requires XeLaTeX or bundled font files.

```sh
make                 # Build both cv.pdf and resume.pdf (same as make all)
make full            # Build cv.pdf only (also: make cv.pdf)
make resume          # Build resume.pdf only (also: make resume.pdf)
make clean           # Remove auxiliary files, retaining the PDFs
make clean-all       # Remove auxiliary files and both generated PDFs
```

Each build runs pdfLaTeX, BibTeX, and two more pdfLaTeX passes to refresh
publications and links.

## Build with Docker

With Docker installed and running:

```sh
make docker-all      # Build both PDFs
make docker-full     # Build cv.pdf
make docker-resume   # Build resume.pdf
```

These targets build the image defined by [`Dockerfile`](Dockerfile) and mount
the repository at `/cv`, leaving the generated PDFs in the local repository.

## GitHub Actions

[The workflow](.github/workflows/update-cv.yml) runs `make all` in a full
TeX Live environment on pushes to `master`. It publishes `cv.pdf` and
`resume.pdf` as assets of the latest release and copies `cv.pdf` to the
personal website repository.
