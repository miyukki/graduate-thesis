all: build-pdf build-binder-pdf

%.pdf:
	platex    -kanji=utf8 $*
	pbibtex   -kanji=utf8 $*
	platex    -kanji=utf8 $*
	platex    -kanji=utf8 $*
	dvipdfmx  -p a4 $*

build-pdf: main.pdf
build-binder-pdf: main-binder.tex main-binder.pdf
	rm main-binder.tex

main-binder.tex:
	cat main.tex | \
		perl -0pe 's/% (.*>>bindermode<<)$$/$$1/mg' | \
		perl -0pe 's/^(.*>>nobindermode<<)$$/% $$1/mg' > main-binder.tex

clean:
	/bin/rm -f *~ *.log *.dvi *.blg *.aux *.out *.bbl *.lot *.toc *.lof *.pdf
