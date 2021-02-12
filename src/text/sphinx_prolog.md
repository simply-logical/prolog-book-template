(sec:sphinxprolog)=
# `sphinx-prolog` Extension #

The [`sphinx-prolog`] extension implements four modules:
* [`infobox`] responsible for creating admonition-styled *information boxes*
  that are referenceable and may be given a title -- described in the
  *{ref}`sec:sphinxprolog:infobox`* section;
* [`pprolog`] implementing custom *Prolog syntax highlighting* for code boxes
  -- described in the *{ref}`sec:sphinxprolog:pprolog`* section;
* [`solex`] enabling creation of automatically numbered, referenceable and
  linked admonition-styled *exercise* and *solution boxes* -- described in the
  *{ref}`sec:sphinxprolog:solex`* section; and
* [`swish`] allowing to incorporate interactive SWI Prolog
  *[SWISH]-based code* and *query boxes* -- described in the
  *{ref}`sec:sphinxprolog:swish`* section.

These modules add useful functionality when building Prolog-infused educational
-- teaching and self-study -- content with [Sphinx] and [Jupyter Book].

:::{note}
This guide is written for `sphinx-prolog` version `0.4`.
:::

## Installation ##

The [`sphinx-prolog`] extension  source code is hosted in the
[simply-logical/sphinx-prolog] GitHub repository.
It is distributed via the *Python Package Indexer* (*[PyPI]*) and can be
installed with `pip` by executing
```bash
pip install sphinx-prolog
```

(sec:sphinxprolog:usage)=
## Usage ##

To use the functionality implemented by this extension, first you need to
enable the desired modules in your Jupyter Book or Sphinx configuration file.
In Jupyter Book this is achieved by adding the selected extension module names
under the `sphinx.extra_extensions` key in the `_config.yml` file
```yaml
sphinx:
  extra_extensions:
    # Load sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    - sphinx_prolog.infobox
    - sphinx_prolog.pprolog
    - sphinx_prolog.solex
    - sphinx_prolog.swish
```
In Sphinx, extensions are enabled by placing the module names in a Python list
stored under the `extensions` variable in the `conf.py` file
```Python
...
extensions = ['sphinx_prolog.infobox',
              'sphinx_prolog.pprolog',
              'sphinx_prolog.solex',
              'sphinx_prolog.swish',
              ]
...
```

## Documentation ##

The *technical documentation* of the [`sphinx-prolog`] extension can be found
in its [GitHub repository] in the [`README.md`] file.
This page and the following sections, on the other hand, are a
*practical user guide* sprinkled with actual usage examples for each module
implemented by the extension.
Here, we focus on the Jupyter Book platform and its [MyST Markdown] syntax,
but the same functionality is available directly in Sphinx with its
[reStructuredText] syntax.

[Jupyter Book]: https://jupyterbook.org/
[Sphinx]: https://www.sphinx-doc.org/
[PyPI]: https://pypi.org/project/sphinx-prolog/
[SWISH]: https://swish.swi-prolog.org/
[simply-logical/sphinx-prolog]: https://github.com/simply-logical/sphinx-prolog
[`sphinx-prolog`]: https://github.com/simply-logical/sphinx-prolog
[`infobox`]: https://github.com/simply-logical/sphinx-prolog/blob/master/sphinx_prolog/infobox.py
[`pprolog`]: https://github.com/simply-logical/sphinx-prolog/blob/master/sphinx_prolog/pprolog.py
[`solex`]: https://github.com/simply-logical/sphinx-prolog/blob/master/sphinx_prolog/solex.py
[`swish`]: https://github.com/simply-logical/sphinx-prolog/blob/master/sphinx_prolog/swish.py
[`README.md`]: https://github.com/simply-logical/sphinx-prolog/blob/master/README.md
[GitHub repository]: https://github.com/simply-logical/sphinx-prolog
[MyST Markdown]: https://myst-parser.readthedocs.io/
[reStructuredText]: https://docutils.sourceforge.io/rst.html
