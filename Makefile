.PHONY: clean
clean: clean-catalog clean-engelking

.PHONY: clean-engelking
clean-engelking:
	find . -name '*.tex' -type f -exec latexmk -C -cd -norc -r ./documents/engelking/.latexmkrc {} + 2> /dev/null

.PHONY: clean-catalog
clean-catalog:
	find . -name '*.tex' -type f -exec latexmk -C -cd -norc -r ./documents/catalog/.latexmkrc {} + 2> /dev/null

.PHONY: all
all: catalog engelking

.PHONY: catalog
catalog:
	sh ./tools/build.sh ./documents/catalog/root.tex product HEAD

.PHONY: engelking
engelking:
	latexmk -cd -norc -r ./documents/engelking/.latexmkrc ./documents/engelking/list.tex
	cp -a ./documents/engelking/list.pdf ./outputs/engelking-list.pdf

.PHONY: lct
lct: list-commands-table
.PHONY: list-commands-table
list-commands-table: outputs/list-commands-table.pdf
outputs/list-commands-table.pdf: documents/catalog/list-commands-table.pdf
	cp -a $< ./outputs
documents/catalog/list-commands-table.pdf: documents/catalog/list-commands-table.tex
	latexmk -cd -norc -r ./documents/catalog/.latexmkrc $<
