#!/bin/sh
latexmk &&
pandoc praca.tex -f latex -t docx --default-image-extension=pdf -o praca.docx
