# Interactive Prolog Book Example #
[![Licence](https://img.shields.io/github/license/simply-logical/prolog-book-template.svg)](https://github.com/simply-logical/prolog-book-template/blob/master/LICENCE)
[![Online](https://img.shields.io/badge/read-online-green.svg)](https://book-template.simply-logical.space)

This repository holds a [*Jupyter Book*](https://jupyterbook.org/)
template for building interactive Prolog books using
[SWI Prolog](https://www.swi-prolog.org/) and
[SWISH](https://swish.swi-prolog.org/).
The Prolog support is enabled with our custom
[`sphinx-prolog`](https://github.com/simply-logical/sphinx-prolog) extension.
The built book is hosted on *GitHub Pages* and is available under
<https://book-template.simply-logical.space>.
**This page describes the process of building interactive Prolog content with
the aforementioned technology stack.**

## Building the book ##
1. Pull the book repository
   ```bash
   git clone https://github.com/simply-logical/prolog-book-template.git

   cd prolog-book-template
   ```
2. Install [*Jupyter Book*](https://pypi.org/project/jupyter-book/) with the
   [`sphinx-prolog`](https://pypi.org/project/sphinx-prolog/) extension
   ```bash
   pip install -r requirements.txt
   ```
3. Build the book
   ```bash
   jb build .
   ```
4. Open the html build
   ```bash
   open _build/html/index.html
   ```
   or run it as a server
   ```bash
   python -m http.server --directory _build/html
   open http://localhost:8000
   ```
