pandoc .\README.md -s -o  .\assets\pdfs\changelog.pdf --pdf-engine  wkhtmltopdf && python convert.py && flutter run -d windows --verbose