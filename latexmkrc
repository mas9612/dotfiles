#!/usr/bin/perl

$latex = 'platex -interaction=nonstopmode -kanji=utf-8 %O %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$bibtex = 'pbibtex';
$max_repeat = 5;
$pdf_mode = 3; # use dvipdf
$pdf_update_command = 'open -a Preview %S';
