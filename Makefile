all:
	luatex part-extraction.ins
	lualatex part-extraction.dtx
	makeindex -s gglo.ist -o part-extraction.gls part-extraction.glo
	makeindex -s gind.ist -o part-extraction.ind part-extraction.idx
	lualatex part-extraction.dtx

test:
	lualatex tests/example.tex

clean:
	./.githook_pre-commit

.PHONY: all test clean
