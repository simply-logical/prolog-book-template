(sec:sphinxprolog:infobox)=
# `infobox` Blocks #

Jupyter Book implements a wealth of [admonition boxes].

``````{panels}
`````{warning}
````md
```{warning}
content
```
````
Syntax for *warnings*.
`````

---

`````{note}
````md
```{note}
content
```
````
Syntax for *notes*.
`````
``````

``````{panels}
`````{tip}
````md
```{tip}
content
```
````
Syntax for *tips*.
`````

---

`````{seealso}
````md
```{seealso}
content
```
````
Syntax for *see alsos*.
`````
``````

You can customise these admonitions by using the generic `admonition` block
with a *desired class* (specified via the `:class:` parameter) and
a *custom title*, for example

:::{admonition} My Custom Title
:class: tip
````md
```{admonition} My Custom Title
:class: tip
content
```
````
A *tip*-based admonition with a custom title.
:::

However, these blocks cannot be **tagged** and **referenced** by their title.
To address these shortcoming, the `sphinx_prolog.infobox` extension module
implements custom *Information Boxes*.

:::{seealso}
See the Jupyter Book documentation for more details about the available
[admonition boxes].
Other box types -- such as *Caution*, *Attention*, *Danger* and *Error* --
are [also available].
:::

## Setup ##

To enable the `sphinx_prolog.infobox` extension module in your Jupyter Book,
include its name in your `_config.yml` file under the `sphinx.extra_extensions`
key.
```yaml
sphinx:
  extra_extensions:
    # Load sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    - sphinx_prolog.infobox
```

:::{seealso}
See the {ref}`sec:sphinxprolog:usage` section of the {ref}`sec:sphinxprolog`
page for more details.
:::

## Usage ##

An Information Box is inserted with an admonition-like syntax using the
`infobox` keyword and it has **one required parameter** -- `:title:` --
used to provide its title.

:::{infobox} ibox:one
:title: A Custom Information Box
````md
```{infobox}
:title: The Infomration Box Title
The Information Box content.
```
````
:::

### Assign a Title ###

Each Information Box **requires** a *title*, which is provided via the
`:title:` parameter -- see the example above.
By hovering your mouse over the title section of an Information Box
(the blue-coloured bar at the top), a hyper-link marker (¶) will be revealed
to the right of the title text.
By clicking it you will get a link pointing directly to this Information Box.

(sec:sphinxprolog:infobox:ref)=
### Tag and Reference ###

In addition to the external links provided under the hyper-link markers (¶),
the Information Boxes can be easily *tagged* and *referenced* within the book.
To tag a box place your tag string directly after the box opening statement,
e.g., `` ```{infobox} ibox:my-tag ``.
**The Information Box tags must be prefixed with `ibox:`.**

:::{infobox} ibox:two
:title: Another Custom Information Box
````md
```{infobox} ibox:my-tag
:title: The Title of Another Infomration Box
The content of another Information Box.
```
````
:::

You can then reference your tagged Information Boxes anywhere in your book.
This is achieved with the `` {ref}`ibox:my-tag` `` syntax.
In the built book such command will be replaced with a *title* of the
referenced Information Box hyper-linked to its location.
For example, referencing the first Information Box gives {ref}`ibox:one`,
and the second produces {ref}`ibox:two`.
If you prefer to assign a custom text to your hyper-link, there is a syntax for
that as well: `` {ref}`Custom Text <ibox:my-tag>` ``.
For example, the first Information Box can be referenced as
{ref}`Custom Reference to the First Box <ibox:one>`.

:::{seealso}
For more information, see the [referencing overview] available in the
Jupyter Book documentation.
:::

---

:::{seealso}
For more information about the Information Box module see
its [*technical documentation*].
:::

[admonition boxes]: https://jupyterbook.org/content/content-blocks.html#notes-warnings-and-other-admonitions
[referencing overview]: https://jupyterbook.org/content/citations.html#referencing-overview
[also available]: https://jupyterbook.org/reference/cheatsheet.html#admonitions
[*technical documentation*]: https://github.com/simply-logical/sphinx-prolog#information_source-infobox-directive
