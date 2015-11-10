jobname = part-extraction
texmfhome = $(HOME)/texmf
projectpath = $(texmfhome)/tex/lualatex/$(jobname)

all:
	install
	doc

install:
	luatex $(jobname).ins
	mkdir -p $(projectpath)
	cp -f $(jobname).cls $(projectpath)
	cp -f $(jobname).lua $(projectpath)

doc:	
	lualatex $(jobname).dtx
	makeindex -s gglo.ist -o $(jobname).gls $(jobname).glo
	makeindex -s gind.ist -o $(jobname).ind $(jobname).idx
	lualatex $(jobname).dtx
	mkdir -p $(texmfhome)/docs
	cp -f $(jobname).pdf $(texmfhome)/docs

test:
	lualatex tests/example.tex

clean:
	./.githook_pre-commit
