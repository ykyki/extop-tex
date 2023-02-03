.DEFAULT_GOAL := help

.PHONY: help
help:
	@cat $(firstword $(MAKEFILE_LIST))

.PHONY: all
all: catalog engelking lct

.PHONY: catalog
catalog:
	sh tools/build.sh documents/catalog/root.tex product HEAD

.PHONY: engelking
engelking: outputs/engelking-list.pdf
outputs/engelking-list.pdf: documents/engelking/list.tex
	latexmk -cd -norc -r ./documents/engelking/.latexmkrc $<
	cp -a ./documents/engelking/list.pdf $@

.PHONY: lct
lct: list-commands-table
.PHONY: list-commands-table
list-commands-table: outputs/list-commands-table.pdf
outputs/list-commands-table.pdf: documents/catalog/list-commands-table.pdf
	cp -a $< $@
documents/catalog/list-commands-table.pdf: documents/catalog/list-commands-table.tex
	latexmk -cd -norc -r ./documents/catalog/.latexmkrc $<

.PHONY: clean
clean: clean-catalog clean-engelking

.PHONY: clean-engelking
clean-engelking:
	@echo "--->" $@
	find . -name '*.tex' -type f -exec latexmk -C -cd -norc -r ./documents/engelking/.latexmkrc {} + 2> /dev/null

.PHONY: clean-catalog
clean-catalog:
	@echo "--->" $@
	find . -name '*.tex' -type f -exec latexmk -C -cd -norc -r ./documents/catalog/.latexmkrc {} + 2> /dev/null

.PHONY: branch-catalog
branch-catalog:
	@read -p "Enter topic name: " name; \
	git switch -c feature/$$(date +%y%m%d)/catalog/$$name

.PHONY: branch-engelking
branch-engelking:
	@read -p "Enter topic name: " name; \
	git switch -c feature/$$(date +%y%m%d)/engelking/$$name
