(sec:intro)=
# Interactive Prolog Book Example #

:::{note}
Bugs and feature requests regarding the `sphinx-prolog` package and its
functionality should be reported as issues in the
[simply-logical/sphinx-prolog][sphinx-prolog-issues] GitHub repository.
Typographical and other presentation errors related to this template and its
content should be reported as issues in the
[simply-logical/prolog-book-template][prolog-book-template-issues] GitHub
repository.
:::

:::{tip}
In addition to Prolog, the `sphinx-prolog` package can be used to build
documents with interactive [cplint] code blocks.
More information can be found at
<https://cplint-template.simply-logical.space/>.
:::

## About ##
This online book describes the process of building online interactive Prolog
materials using [SWI Prolog] and [SWISH].
It is hosted on [*GitHub Pages*], and built with [*Jupyter Book*] and our
custom [`sphinx-prolog`] extension.
The source of this book can be found in the
[simply-logical/prolog-book-template] GitHub repository, which can also serve
as a template and a starting point for building your own book.

:::{note}
A great example of a Prolog book built with the aforementioned technology
stack is our online edition of the *Simply Logical: Intelligent Reasoning by
Example* book by Peter Flach.
You can find it here: <https://book.simply-logical.space/>.
:::

## Building the Book ##
To build this book you need two Python packages: `jupyter-book` and
`sphinx-prolog`.
You can either install them manually
```bash
pip install "jupyter-book>=0.10.0"
pip install "sphinx-prolog>=0.5"
```
or by using our `requirements.txt` file, i.e.,
`pip install -r requirements.txt`.
Then, the book can be built with `jb build .`.

:::{note}
For more details about installing necessary dependencies and building this
book see the [`README.md`] file included in the [GitHub repository] that
holds the source of this book.
:::

## Contents ##
In this book you will find information on how to:

* {ref}`deploy your book to GitHub Pages <sec:github>`;
* {ref}`configure Jupyter Book to generate interactive Prolog content <sec:jupyterbook>`; and
* {ref}`use Prolog-specific content, including interactive SWISH code boxes <sec:sphinxprolog>`.

[sphinx-prolog-issues]: https://github.com/simply-logical/sphinx-prolog/issues
[prolog-book-template-issues]: https://github.com/simply-logical/prolog-book-template/issues
[cplint]: https://friguzzi.github.io/cplint/_build/html/
[SWI Prolog]: https://www.swi-prolog.org/
[SWISH]: https://swish.swi-prolog.org/
[*GitHub Pages*]: https://pages.github.com/
[*Jupyter Book*]: https://jupyterbook.org/
[`sphinx-prolog`]: https://github.com/simply-logical/sphinx-prolog
[simply-logical/prolog-book-template]: https://github.com/simply-logical/prolog-book-template
[`README.md`]: https://github.com/simply-logical/prolog-book-template#building-the-book
[GitHub repository]: https://github.com/simply-logical/prolog-book-template
