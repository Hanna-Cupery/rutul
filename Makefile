.DEFAULT_GOAL := rut.num.generator.tr.hfst

rut.num.analyzer.hfst: rut.num.generator.hfst
	hfst-invert $< -o $@

rut.num.generator.hfst: rut.num.lexd
	lexd $< | hfst-txt2fst -o $@
	
# generate transliteraters
cy2la.transliterater.hfst: la2cy.transliterater.hfst
	hfst-invert $< -o $@
la2cy.transliterater.hfst: correspondence.hfst
	hfst-repeat -f 1 $< -o $@
correspondence.hfst: correspondence
	hfst-strings2fst -j correspondence -o $@

# generate analizer and generator for transcription
rut.analizer.tr.hfst: rut.num.generator.tr.hfst
	hfst-invert $< -o $@
rut.num.generator.tr.hfst: rut.num.generator.hfst cy2la.transliterater.hfst
	hfst-compose $^ -o $@