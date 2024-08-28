#!/bin/bash
set -e

files=src/*.md
output_pdf=output/electric.pdf
output_html=output/electric.html
metadata=src/metadata.yaml
template=templates/electric.tmpl
style=styles/github.css

format=$1
if [[ "$format" == "" ]]; then
  format="pdf"
fi

if [[ "$format" == "html" ]]; then
    output=${output_html}
    engine_flags=""

    cp -r -f styles output/
    mkdir -p output/src
    cp -r -f src/images output/src
else
    output=${output_pdf}
    engine_flags="--pdf-engine=weasyprint"
fi

pandoc --output ${output} \
--from markdown+link_attributes+pipe_tables \
--to html \
${engine_flags} \
--standalone \
--toc \
--metadata-file=${metadata} \
--template ${template} \
--css=${style} \
${files}
