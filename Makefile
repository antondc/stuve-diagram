stuve.png: stuve.tex
	pdflatex stuve.tex
	magick -density 300 stuve.pdf \
		-background white -alpha remove -alpha off \
		-trim +repage \
		-bordercolor white -border 118x118 \
		stuve.png
