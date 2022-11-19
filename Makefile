.PHONY: clean
clean: clean-catalog clean-engelking

.PHONY: clean-engelking
clean-engelking:
	find . -name '*.tex' -type f -exec latexmk -C -cd -norc -r ${PWD}/documents/engelking/.latexmkrc {} + 2> /dev/null

.PHONY: clean-catalog
clean-catalog:
	find . -name '*.tex' -type f -exec latexmk -C -cd -norc -r ${PWD}/documents/catalog/.latexmkrc {} + 2> /dev/null
