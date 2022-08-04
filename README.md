# Curriculum-Vitae

This repository contains most recently updated versions of my CV.

My full CV and also a single page resume can be downloaded here:
- [CV](https://github.com/Siddhant-Ray/Curriculum-Vitae/releases/latest/download/cv.pdf) 
- [Resume](https://github.com/Siddhant-Ray/Curriculum-Vitae/releases/latest/download/resume.pdf) 

## Reusing the LaTex templates:

For reproducing, clone this repository. The file [`main.tex`](main.tex) defines the template for the full version, along with the commands and environments used. The actual content present is stored in TeX files located in the [sections](sections/) directory.

For the single page version, I use a different template, well because it just looks nicer. All the content for this is in the TeX file [`onepage.tex`](onepage.tex) and the support macros are in [`onepage.cls`](onepage.cls), along with supporting fonts in [fonts](fonts/). As the one page template uses the 
```\fontspec``` command, it can only be compiled with ```XeLaTex```.

## Compilation 
Compile both versions with with:
```sh
make
```
only the one page version with 
```sh
make one
```
or only the full verision with 
```sh
make full
```

Finally all auxiliary files can be cleaned using 
```sh
make clean
```

## Generated PDFs
GitHub Actions is used to automatically generate the PDF for both versions. This is packaged a single release, pointing to the latest commit on the `master` branch. This release creation is necessary as GitHub doesn't allow us to store binaries (unlike GitLab which is just much nicer for this). The compiled PDFs are thus available as release assests always.

