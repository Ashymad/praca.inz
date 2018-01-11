#!/bin/sh
latexmk &&
pandoc praca.tex -f latex -t docx --default-image-extension=pdf --bibliography=bibliografia.bib -o praca.docx
