all: build-pdf build-binder-pdf
comment: build-comment-pdf

build-pdf: main.tex
	platex    -kanji=utf8 $(<:.tex=)
	pbibtex   -kanji=utf8 $(<:.tex=)
	platex    -kanji=utf8 $(<:.tex=)
	platex    -kanji=utf8 $(<:.tex=)
	dvipdfmx  -p a4 $(<:.tex=)

main-binder.tex: main.tex
	cat $< | \
		perl -0pe 's/% (.*>>bindermode<<)$$/$$1/mg' | \
		perl -0pe 's/^(.*>>nobindermode<<)$$/% $$1/mg' > $@

build-binder-pdf: main-binder.tex
	platex    -kanji=utf8 $(<:.tex=)
	pbibtex   -kanji=utf8 $(<:.tex=)
	platex    -kanji=utf8 $(<:.tex=)
	platex    -kanji=utf8 $(<:.tex=)
	dvipdfmx  -p a4 $(<:.tex=)
	rm $<

build-comment-pdf: comment.tex
	platex    -kanji=utf8 $(<:.tex=)
	# pbibtex   -kanji=utf8 $(<:.tex=)
	# platex    -kanji=utf8 $(<:.tex=)
	platex    -kanji=utf8 $(<:.tex=)
	dvipdfmx  -p a4 $(<:.tex=)

test: main-binder.tex
	echo 	$(<:.tex=)

clean:
	/bin/rm -f *~ *.log *.dvi *.blg *.aux *.out *.bbl *.lot *.toc *.lof *.pdf
	cd section && /bin/rm -f *~ *.log *.dvi *.blg *.aux *.out *.bbl *.lot *.toc *.lof *.pdf
