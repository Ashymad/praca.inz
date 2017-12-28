@default_files = ("praca.Rnw");
$pdf_mode = 1;
$pdf_previewer = 'start zathura';

add_cus_dep('Rnw', 'tex', 0, 'knit');
sub knit {
	system("Rscript -e \"library(knitr); knit(\\\"$_[0].Rnw\\\");\"");
}

$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode %O %B.tex && Rscript -e "library(patchSynctex); patchSynctex(\'%B\', verbose = TRUE);"';
