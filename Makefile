SOURCES=$(shell find . -name "*.md")
OUT=$(SOURCES:%.md=%.html) 

HEADER=./templates/header.html
FOOTER=./templates/footer.html

all: $(OUT)

%.html: %.md
	cat $(HEADER) > $@
	pandoc $< >> $@
	cat $(FOOTER) >> $@

.PHONY: clean

clean:
	rm -f $(OUT)

