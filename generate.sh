#!/bin/bash
NAME=main
RESULT=fs-doc

rm -rf output $NAME.idx $NAME.pdf $RESULT.synctex.gz tmp
mkdir -p output tmp
echo -e "Compilando "$NAME".tex para generar indice";
pdflatex -output-directory=output -output-format=pdf --jobname=$RESULT $NAME.tex 
#> /dev/null 2>&1
bibtex output/$RESULT  > /dev/null 2>&1

echo -e "Generando indice"
makeindex output/$RESULT  > /dev/null 2>&1

echo -e "Compilando primera pasada";
pdflatex -output-directory=output -output-format=pdf --jobname=$RESULT $NAME.tex > /dev/null 2>&1
echo -e "Compilando segunda pasada";
pdflatex -output-directory=output -output-format=pdf --jobname=$RESULT $NAME.tex > /dev/null 2>&1
mv output/$RESULT.pdf .
rm -rf output $NAME.idx $NAME.pdf $RESULT.synctex.gz tmp

#gnome-open
# -w for preview mode  
echo -e "Launching evince"
evince -f  --display=:0 $RESULT.pdf &> /dev/null 2>&1

# sudo apt-get install pdftk enscript 
#echo "Texto preliminar en desarrollo." | enscript -B -h --ul-style=filled -u"Preliminar" --ul-position='70-50' --ul-gray=.75 -f Courier-Bold@8/10 -o- | ps2pdf - | pdftk $RESULT.pdf stamp - output $RESULT-fingerprint.pdf

#echo -e "Launching fingerprint evince"
#evince -f  --display=:0 $RESULT-fingerprint.pdf > /dev/null 2>&1

echo -e 'Finished.'
#Para generar archivo .odt a partir del .tex (experimental)
#htlatex MyFile.tex "xhtml,ooffice" "ooffice/! -cmozhtf" "-coo -cvalidate"
# sudo apt-get install texlive-lang-spanish texlive-bibtex-extra texlive-latex-extra texlive-fonts-extra texlive-fonts-recommended