article.pdf: article/article.md article/figures/*
	(cd article; pandoc -s --filter pandoc-crossref --filter pandoc-citeproc article.md -o article.pdf)
