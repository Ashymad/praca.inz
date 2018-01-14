@default_files = ("praca.tex");
$pdf_mode = 1;
$pdf_previewer = 'start zathura';
$force_mode = 1;
push @generated_exts, "bbl";
push @generated_exts, "synctex.gz";
push @generated_exts, "run.xml";
push @generated_exts, "fls";
push @generated_exts, "tex";

add_cus_dep('Rnw', 'tex', 0, 'knit');
sub knit {
	system("r -e \"library(knitr); knit(\\\"$_[0].Rnw\\\");\"");
}

$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode %O %B.tex && r -e "library(patchSynctex); patchSynctex(\'%B\', verbose = TRUE);"';
