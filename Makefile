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