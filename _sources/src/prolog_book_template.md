(sec:intro)=
# Interactive Prolog Book Example #

## About ##
This online book describes the process of building online interactive Prolog
materials using [SWI Prolog](https://www.swi-prolog.org/) and
[SWISH](https://swish.swi-prolog.org/).
It is hosted on [*GitHub Pages*](https://pages.github.com/), and built with
[*Jupyter Book*](https://jupyterbook.org/) and our custom
[`sphinx-prolog`](https://github.com/simply-logical/sphinx-prolog) extension.
The source of this book can be found in the
[simply-logical/prolog-book-template](https://github.com/simply-logical/prolog-book-template)
GitHub repository, which can also serve as a template and a starting point for
building your own book.

```{note}
A great example of a Prolog book built with the aforementioned technology
stack is our online edition of the *Simply Logical: Intelligent Reasoning by
Example* book by Peter Flach.
You can find it here: <https://book.simply-logical.space/>.
```

## Building the Book ##
To build this book you need two Python packages: `jupyter-book` and
`sphinx-prolog`.
You can either install them manually
```bash
pip install "jupyter-book>=0.10.0"
pip install "sphinx-prolog>=0.4"
```
or by using our `requirements.txt` file, i.e.,
`pip intsll -r requirements.txt`.
Then, the book can be built with `jb build .`.

```{note}
For more details about installing necessary dependencies and building this book
see the [`README.md`](https://github.com/simply-logical/prolog-book-template#building-the-book)
file included in the GitHub repository holding the source of this book.
```

## Contents ##
In this book you will find information on how to:

* {ref}`deploy your book to GitHub Pages <sec:github>`;
* {ref}`configure Jupyter Book to generate interactive Prolog content <sec:jupyterbook>`; and
* {ref}`use Prolog-specific content, including interactive SWISH code boxes <sec:sphinxprolog>`.
