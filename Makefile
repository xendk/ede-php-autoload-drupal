CASK=cask

.PHONY: test test-unit test-functional test-all elc package clean

test-unit:
	$(CASK) exec buttercup

test-functional:
	$(CASK) exec ecukes -r magnars

test-all:
	$(MAKE) test-unit
	$(MAKE) test-functional

test:
	$(MAKE) clean
	$(MAKE) test-all
	$(MAKE) elc
	$(MAKE) test-all

elc:
	$(CASK) build

clean:
	$(CASK) clean-elc

package:
	$(CASK) package
