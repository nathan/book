elm.js: src/*.elm src/**/*.elm src/Native/*.js
	elm-make src/Main.elm

gh-pages:
	$(eval sha = $(shell git rev-parse HEAD))
	git checkout --detach
	git symbolic-ref HEAD refs/heads/gh-pages
	make elm.js
	git checkout gh-pages -- .gitignore
	git rm -rf --cached .
	git add .
	git commit --amend -m 'Build $(sha)'$$'\n\n''This branch should not have any history. It is automatically generated by the gh-pages target of the makefile on the master branch.'
	git checkout -
	make elm.js

publish: gh-pages
	git push origin gh-pages --force

.PHONY: gh-pages publish
