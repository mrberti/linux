#!/bin/bash
outname="out.pdf"


if [ -e $outname ] ;
then
	mv $outname $outname.old
fi

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$outname *.pdf
#gs -sDEVICE=pdfwrite -dCompatibilityLevel=1. -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=$outname files
