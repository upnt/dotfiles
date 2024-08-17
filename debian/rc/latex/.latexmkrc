$pdf_mode = 5;
$latex = 'latex -synctex=1 -file-line-error -halt-on-error %O %S';
$pdflatex = 'pdflatex -synctex=1 -file-line-error -halt-on-error %O %S';
$lualatex = 'lualatex -synctex=1 -file-line-error -halt-on-error %O %S';
$xelatex = 'xelatex -synctex=1 -file-line-error -halt-on-error %O %S';

$dvipdf = 'dvipdfmx -V 7 %O -o %D %S';
# $dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
# $ps2pdf = 'ps2pdf %O %S %D';
$max_repeat = 10;


$bibtex_use = 1;
$bibtex = 'bibtex %O %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %O %S';

$makeindex = 'makeindex %O -o %D %S';

$pdf_previewer = 'zathura %S';
$pdf_update_method = 3;

$emulate_aux = 1;
$aux_dir = ".tex_intermediates"
