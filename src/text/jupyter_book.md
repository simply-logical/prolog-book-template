(sec:jupyterbook)=
# Jupyter Book #

[Jupyter Book] is a static page generator based on [Sphinx] -- the
documentation engine for Python.
To get started with your first Prolog-infused Jupyter Book, clone the GitHub
repository holding the source of this book (or your own fork or copy of the
template) with
```bash
git clone https://github.com/simply-logical/prolog-book-template.git
```
Then, enter the book directory
```bash
cd prolog-book-template
```
before installing the dependencies and building the book.

## Setup ##

To set up the environment we need to install two Python dependencies:
* [`jupyter-book`] -- the Jupyter Book platform; and
* [`sphinx-prolog`] -- our custom Prolog extension for Jupyter Book and Sphinx.

Jupyter Book is required in version `0.10.0` or higher, and Sphinx Python in
version `0.5` or higher.
You can install these dependencies manually with
```bash
pip install "jupyter-book>=0.10.0"
pip install "sphinx-prolog>=0.5"
```
or by using the [`requirements.txt`] file
```bash
pip install -r requirements.txt
```

Now, you can build the book by executing
```bash
jupyter-book build .
```
or
```bash
jb build .
```
for short.
This will compose the HTML version of the book and place it in the
`_build/html` directory.
You can either open the `_build/html/index.html` file directly, or use the
built-in Python HTTP server by executing
```bash
python -m http.server --directory _build/html
```
and then pointing your web browser to <http://localhost:8000>.

(sec:jupyterbook:config)=
## Configuration ##

The configuration of this Jupyter Book can be found in the [`_config.yml`]
file.
It holds the basic parameters and build options of the book.
By default the build process will only copy the necessary files into the target
directory (`_build/html`), which will then be deployed.
To include {ref}`auxiliary files <sec:github:github-pages>` needed for proper
functioning of our GitHub Pages deployment, we need to list them under the
`sphinx.config.html_extra_path` key in the [`_config.yml`] file.
```yaml
sphinx:
  config:
    html_extra_path:
      - README.md
      - LICENCE
      - CNAME
      - .nojekyll
```
(While [`README.md`] and [`LICENCE`] are not necessary, they ensure a pleasant
look of our [`gh-pages` branch].)

:::{warning}
When using this template, you should change the Google Analytics ID defined by
the
```yaml
  google_analytics_id: '261828628'
```
line (under the `html` key) in [`_config.yml`] or remove it altogether if you
do not have your own Google Analytics token.
Similarly, you should set the book repository URL to your own GitHub repository
by amending the
```yaml
  url: https://github.com/simply-logical/prolog-book-template
```
line found under the `repository` key.
:::

:::{seealso}
For more information about configuring Jupyter Book see the
[official documentation](https://jupyterbook.org/customize/config.html).
:::

---

It is also possible to include custom *CSS rules* and *JavaScript scripts* in
your book by placing their respective files in the [`_static`] directory.
All the files with `.css` and `.js` extensions located in this folder
will automatically be copied into your HTML book build and linked in the
header of each page.
This template uses the `_static` folder to slightly customise the book
appearance with the [`_static/prolog-book-template.css`] file.

:::{seealso}
For more information about the `_static` directory see the
[official documentation](https://jupyterbook.org/advanced/sphinx.html?highlight=_static#custom-css-or-javascript).
:::

:::{note}
Additional important Jupyter Book configuration parameters are under the
`sphinx.extra_extensions` and `sphinx.config` keys.
```yaml
sphinx:
  extra_extensions:
    # Load sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    - sphinx_prolog.infobox
    - sphinx_prolog.pprolog
    - sphinx_prolog.solex
    - sphinx_prolog.swish
  config:
    # Configure sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    sp_exercise_directory: src/ex/
    sp_code_directory: src/code/
    sp_swish_url: https://swish.simply-logical.space/
    sp_swish_book_url: https://book-template.simply-logical.space/
    sp_swish_hide_examples: true
```
The first group loads external plugins -- in particular, the four modules of
our custom [`sphinx-prolog`] extension.
The latter group configures Sphinx and its extensions -- in our case, the
behaviour of our extension.
See the {ref}`sec:sphinxprolog` section for more details.
:::

## Content ##

The book content is controlled by the [`_toc.yml`] file.
It defines the *part*, *chapter* and *section* structure of the book,
as well as their numbering and source paths.
To improve the folder structure of the book template, all of the content
building blocks are kept in the [`src`] directory:
* [`src/img`] holds static images such as logos and favicons;
* [`src/fig`] holds figures; and
* [`src/text`] holds markdown files with the book text.

:::{note}
The `src` directory holds two additional folders:
* [`src/code`] with Prolog code snippets used to build interactive SWISH
  blocks and
* [`src/ex`] with exercises and solutions content,

which are specific to our `sphinx-prolog` extension.
They are discussed in more detail in {ref}`sec:sphinxprolog:swish` and
{ref}`sec:sphinxprolog:solex` sections respectively.
:::

:::{seealso}
For more information about the `_toc.yml` file structure see the
[official documentation](https://jupyterbook.org/customize/toc.html).
:::

[Jupyter Book]: https://jupyterbook.org/
[Sphinx]: https://www.sphinx-doc.org/
[`jupyter-book`]: https://pypi.org/project/jupyter-book/
[`sphinx-prolog`]: https://pypi.org/project/sphinx-prolog/
[`requirements.txt`]: https://github.com/simply-logical/prolog-book-template/blob/master/requirements.txt
[`_config.yml`]: https://github.com/simply-logical/prolog-book-template/blob/master/_config.yml
[`gh-pages` branch]: https://github.com/simply-logical/prolog-book-template/tree/gh-pages
[`README.md`]: https://github.com/simply-logical/prolog-book-template/blob/master/README.md
[`LICENCE`]: https://github.com/simply-logical/prolog-book-template/blob/master/LICENCE
[`_static`]: https://github.com/simply-logical/prolog-book-template/tree/master/_static
[`_static/prolog-book-template.css`]: https://github.com/simply-logical/prolog-book-template/tree/master/_static/prolog-book-template.css
[`_toc.yml`]: https://github.com/simply-logical/prolog-book-template/blob/master/_toc.yml
[`src`]: https://github.com/simply-logical/prolog-book-template/tree/master/src
[`src/img`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/img
[`src/fig`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/fig
[`src/text`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/text
[`src/code`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/code
[`src/ex`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/ex
