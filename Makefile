FILE=main

LATEX=lualatex
BIBTEX=bibtex

LATEX_OPTS=-interaction=nonstopmode -halt-on-error

all: document

document:
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;

view:
	evince $(FILE).pdf &

cover-front:
	$(LATEX) $(LATEX_OPTS) cover_front.tex

cover-back:
	$(LATEX) $(LATEX_OPTS) cover_back.tex

cover-spine:
	$(LATEX) $(LATEX_OPTS) cover_spine.tex
	+pdftk cover_spine.pdf cat 1-endR output cover_spine_R.pdf

cover:
	$(LATEX) $(LATEX_OPTS) cover.tex

cover-all:
	make cover-front
	make cover-back
	make cover-spine
	make cover

epub:
	./helpers/generate_epub.sh

epub-validate:
	EPUBCHECK=~/bin/epubcheck asciidoctor-epub3 -D output -a ebook-validate main.adoc

mobi:
	./helpers/generate_mobi.sh

preview:
	latexmk -pvc $(FILE).tex

chapters-to-asciidoc:
	./helpers/chapters_to_asciidoc.sh

chapters-to-docx:
	./helpers/chapters_to_docx.sh

stylus-watch:
	stylus -w ./vendor/asciidoctor-epub3/assets/styles/*.styl -o ./vendor/asciidoctor-epub3/data/styles/

clean:
	+rm -fv $(FILE).{dvi,ps,pdf,aux,log,bbl,blg}

