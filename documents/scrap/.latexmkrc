#! /usr/bin/env perl
$latex         = 'uplatex %O -synctex=1 -kanji=utf8 -no-guess-input-enc -interaction=nonstopmode -file-line-error %S';
$latex_silent  = 'uplatex %O -synctex=1 -kanji=utf8 -no-guess-input-enc -interaction=batchmode -file-line-error %S';
$bibtex        = 'upbibtex %O %B';
$biber         = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$dvipdf        = 'dvipdfmx %O -g 1.5pt -o %D %S';
# $makeindex     = 'upmendex %O -o %D %S';
$max_repeat    = 5;
$pdf_mode      = 3;
$pdf_previewer = "open -g -a /Applications/Skim.app %S"; # at macOS
$clean_ext     = "thm synctex.gz dvi bbl";

$pvc_view_file_via_temporary = 0;
