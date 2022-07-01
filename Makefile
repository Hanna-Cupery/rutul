.DEFAULT_GOAL := check

#rut.num.analyzer.hfst: rut.num.generator.hfst
#	hfst-invert $< -o $@

#rut.num.generator.hfst: rut.num.lexd
#	lexd $< | hfst-txt2fst -o $@
	
# generate transliteraters
#cy2la.transliterater.hfst: la2cy.transliterater.hfst
#	hfst-invert $< -o $@
#la2cy.transliterater.hfst: correspondence.hfst
#	hfst-repeat -f 1 $< -o $@
#correspondence.hfst: correspondence
#	hfst-strings2fst -j correspondence -o $@

# generate analizer and generator for transcription
#rut.analizer.tr.hfst: rut.num.generator.tr.hfst
#	hfst-invert $< -o $@
#rut.num.generator.tr.hfst: rut.num.generator.hfst cy2la.transliterater.hfst
#	hfst-compose $^ -o $@
	
rut.noun.analizer.hfst: rut.noun.generator.hfst
	hfst-invert $< -o $@
rut.noun.generator.hfst: rut.noun.lexd
	lexd $< | hfst-txt2fst -o $@
test.pass.txt: tests.csv
    awk -F, '$$3 == "pass" {print $$1 ":" $$2}' $^ | sort -u > $@
check: rut.noun.generator.hfst test.pass.txt
	bash compare.sh $< test.pass.txt
clean: check
	rm test.*