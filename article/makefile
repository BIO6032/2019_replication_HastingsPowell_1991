article.pdf:
  pandoc --standalone --filter pandoc-crossref --pdf-engine=xelatex --biblatex --bibliography=bibliography.bib -M "crossrefYaml=crossref.yaml" --output article.tex article.md
  xelatex article
  biber article
  xelatex article
  xelatex article
