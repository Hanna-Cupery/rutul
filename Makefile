rut.num.analyzer.hfst: rut.num.generator.hfst
	hfst-invert $< -o $@

rut.num.generator.hfst: rut.num.lexd
	lexd $< | hfst-txt2fst -o $@