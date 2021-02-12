(sec:sphinxprolog:pprolog)=
# *Pseudo Prolog* Syntax Highlighting #

Jupyter Book comes with [*code block syntax highlighting*] for a broad
collection of programming languages.
Code blocks are introduced with a triple-backtick fence followed by
the programming language name, i.e., `` ```languageID ``.

`````{panels}
Outcome
^^^
```prolog
?- append([example, code], [snippet], A).
A = [example, code, snippet].
```

---

Syntax
^^^
````text
```prolog
?- append([example, code], [snippet], A).
A = [example, code, snippet].
```
````
`````

While Prolog syntax highlighting is available out of the box, it fails in
certain cases, e.g., when specifying [*clausal logic*]
```prolog
married;bachelor:-man,adult
```
We fix such highlighting discrepancies by defining *Pseudo Prolog* (`pProlog`)
syntax in the `sphinx_prolog.pprolog` Sphinx extension module.

:::{seealso}
See the Jupyter Book documentation for more details about the
[*code block syntax highlighting*].
:::

## Setup ##

To enable the `sphinx_prolog.pprolog` extension module in your Jupyter Book,
include its name in your `_config.yml` file under the `sphinx.extra_extensions`
key
```yaml
sphinx:
  extra_extensions:
    # Load sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    - sphinx_prolog.pprolog
```

:::{seealso}
See the {ref}`sec:sphinxprolog:usage` section of the {ref}`sec:sphinxprolog`
page for more details.
:::

## Usage ##

To use our Pseudo Prolog syntax highlighting, specify the `pProlog` language
when defining your code boxes

`````{panels}
Outcome
^^^
```pProlog
married;bachelor:-man,adult
```

---

Syntax
^^^
````text
```pProlog
married;bachelor:-man,adult
```
````
`````

---

:::{seealso}
For more information about the Pseudo Prolog syntax highlighting module see
its [*technical documentation*].
:::

[*code block syntax highlighting*]: https://jupyterbook.org/reference/cheatsheet.html#code-and-syntax-highlighting
[*technical documentation*]: https://github.com/simply-logical/sphinx-prolog#test_tube-pseudo-prolog-syntax-highlighting
[*clausal logic*]: https://book.simply-logical.space/src/text/1_part_i/2.1.html#propositional-clausal-logic
