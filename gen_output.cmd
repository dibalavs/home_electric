@echo on
setlocal EnableDelayedExpansion
set files=
FOR /F "tokens=* USEBACKQ" %%i IN (`dir /s /b  src\*.md`) DO set files=!files! %%i

set output_pdf=output\electric.pdf
set output_html=output\electric.html
set metadata=src\metadata.yaml
set template=templates\electric.tmpl
set style=styles\github.css

set format=%1
if not defined format (
  set format="pdf"
)

if "%format%" == "html" (
    set output=%output_html%
    set engine_flags=

    mkdir output\src\images
    mkdir output\styles
    copy styles output\styles
    copy src\images output\src\images

) else (
    set output=%output_pdf%
    set engine_flags="--pdf-engine=weasyprint"
)

pandoc --output %output% ^
  --from markdown+link_attributes+pipe_tables+fenced_divs ^
  --to html ^
  %engine_flags% ^
  --standalone ^
  --toc ^
  --metadata-file=%metadata% ^
  --template %template% ^
  --css=%style% ^
  %files:"=%
