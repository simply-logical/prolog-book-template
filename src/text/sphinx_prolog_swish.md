(sec:sphinxprolog:swish)=
# SWISH *Code* and *Query* Blocks #

At the core of our `sphinx-prolog` extension is the `swish` module;
it enables creation of interactive [SWI Prolog] code boxes by abstracting
their setup complexities away from the content creator.
Interactivity is achieved by dynamically embedding windows with [SWISH] --
an online, collaborative Prolog execution environment.
The `sphinx_prolog.swish` Sphinx extension module implements two types of
*display* code boxes -- `swish` and `swish-query` -- and one inline code
formatting introduced with `swish-query`.
The `swish` command is responsible for creation of interactive Prolog code
blocks.
Both `swish-query` instructions, on the other hand, embed plain-looking code
listings designated for Prolog queries, which can be imported into SWISH blocks
by referencing them.

## Setup ##

To enable the `sphinx_prolog.swish` extension module in your Jupyter Book,
include its name in your `_config.yml` file under the `sphinx.extra_extensions`
key.
```yaml
sphinx:
  extra_extensions:
    # Load sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    - sphinx_prolog.swish
```

:::{seealso}
See the {ref}`sec:sphinxprolog:usage` section of the {ref}`sec:sphinxprolog`
page for more details.
:::

## Configuration ##

The `sphinx_prolog.swish` extension can *optionally* be configured to better
accommodate a number of use cases.
Similar to {ref}`sec:sphinxprolog:solex`, the content of SWISH boxes can be
loaded from external (Prolog code) files.
The SWISH server -- <https://swish.swi-prolog.org/> by default -- used to
execute the interactive code boxes may also be specified by the user.
If the Prolog queries for some SWISH code boxes are provided verbatim (more
on that in the {ref}`sec:sphinxprolog:swish:usage:explicitqueries` section),
they can be hidden from the reader to improve readability.
Lastly, the default procedure for creating interactive SWISH blocks limits their
size to 2,048 characters -- the maximum length of a URL -- overcoming which
requires manual configuration.

### Setting up External Files ###

To enable populating interactive SWISH code boxes from external Prolog code
files, their location (path to a directory) must be specified in the
`sphinx-prolog` extension settings via the `sp_code_directory` configuration
parameter.
```yaml
sphinx:
  config:
    # Configure sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    sp_code_directory: src/code/
```
It is **required** when loading the content of SWISH boxes from files,
or when implicitly prepending or appending Prolog code to SWISH boxes using
the `source-text-start` and `source-text-end` parameters (see the
{ref}`sec:sphinxprolog:swish:usage:advanced` section below for more details).
Additionally, the Prolog files **must** have the `.pl` extension.

:::{seealso}
Loading Prolog files into interactive SWISH code boxes is explained in the
{ref}`sec:sphinxprolog:swish:usage:simple` section below.
:::

### Specifying SWISH Server ###

The default SWISH execution server is <https://swish.swi-prolog.org/>.
It can be changed by specifying the `sp_swish_url` configuration parameter.
```yaml
sphinx:
  config:
    # Configure sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    sp_swish_url: https://swish.simply-logical.space/
```
You may consider hosting your own SWISH server if you would like to install
custom SWI Prolog libraries and other code dependencies needed for your use
case.

:::{note}
Historically, hosting your page under a domain different than the one of the
specified SWISH server prevented the code blocks from loading due to
*cross-origin requests* being blocked by default.
One way to resolve the problem with SWISH code boxes not working was to
*enable third-party cookies* in your web browser.
**This is not the case any more, so you should be fine connecting to
<https://swish.swi-prolog.org/>.**
For this reason, we have <https://swish.simply-logical.space/> linked to
<https://swish.swi-prolog.org/> -- both URL access the same server, which is
kindly hosted by the awesome [SWI Prolog team].
:::

### Hiding SWISH Queries ###

One way to pre-populate Prolog queries into your interactive SWISH boxes
is to include a specially formatted *examples* section into your code, e.g.,
```Prolog
...

/** <examples>
?- my_query(a,X).
?- my_query(b,X).
*/
```
(more on that in section {ref}`sec:sphinxprolog:swish:usage:explicitqueries`
below).
Displaying these *examples* blocks in SWISH code boxes may be distracting, and
you may wish to hide them by default.
This can be achieved by setting the *optional* `sp_swish_hide_examples`
configuration parameter to `true` (it defaults to `false`).
```yaml
sphinx:
  config:
    # Configure sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    sp_swish_hide_examples: true
```
While this `sphinx-prolog` extension setting toggles global visibility of the
*examples* blocks, you can override this behaviour for individual SWISH boxes
with their `hide-examples` parameter -- see the
{ref}`sec:sphinxprolog:swish:usage:visibility` section below for more details.

(sec:sphinxprolog:swish:config:longfiles)=
### Handling Long SWISH Scripts ###

Your Prolog code and queries are transferred to the interactive SWISH boxes
within a URL request, e.g.,
<https://swish.swi-prolog.org/?code=exists_extension(sphinx, prolog).&q=exists_extension(sphinx, A).>.
Since URL requests are limited to 2,048 characters, box content longer than this
cannot be transferred with this approach.
To support large Prolog scripts, a different SWISH URL request format can be
used:
<https://swish.swi-prolog.org/?code=https://book-template.simply-logical.space/_sources/prolog_build_files/code_file-merged.pl&q=exists_extension(sphinx, A).>,
where the `code` section specifies the web address of a Prolog code file.
Such code files can be generated automatically by this extension and uploaded
alongside your book to support long Prolog scripts.
The entire procedure is handled under the hood and such code boxes are no
different to standard SWISH boxes, however this functionality **must** be
enabled for each individual code block via its `build-file` parameter --
see the {ref}`sec:sphinxprolog:swish:usage:file` for more details.

While such boxes will function as expected when the book is published online,
they **will not be able** to load the underlying Prolog script when the book
is built locally during the development.
Since the Prolog file used by such a SWISH block is created by the Jupyter
Book build process, it will not be accessible to the code box until the book
is uploaded online.
To enable this functionality, the `sphinx-prolog` extension **must** know the
the base URL under which your book will be deployed.
This information can be provided via the `sp_swish_book_url` configuration
setting.
```yaml
sphinx:
  config:
    # Configure sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    sp_swish_book_url: https://book-template.simply-logical.space/
```
It is used to compose links to Prolog code files that are later accessed by
file-based SWISH boxes.

:::{warning}
File-based SWISH code boxes (enabled by the
[`build-file` parameter](sec:sphinxprolog:swish:usage:file)) will not work
for local builds of your book since their underlying Prolog files connot be
accessed by SWISH until you upload them online alongside your book.
:::

## Usage ##

(sec:sphinxprolog:swish:usage:simple)=
### Simple Boxes ###

(sec:sphinxprolog:swish:usage:visibility)=
### Display Preferences ###

(sec:sphinxprolog:swish:usage:explicitqueries)=
### Explicit Queries ###

### Implicit Queries ###

#### Display ####

#### Inline ####

(sec:sphinxprolog:swish:usage:advanced)=
### Advanced Boxes ###

(sec:sphinxprolog:swish:usage:file)=
### Long Boxes ###

:::{seealso}
For more information about the *SWISH* module see its
[*technical documentation*].
:::

[SWI Prolog]: https://www.swi-prolog.org/
[SWISH]: https://swish.swi-prolog.org/
[SWI Prolog team]: https://www.swi-prolog.org/Contributors.html
[*technical documentation*]: https://github.com/simply-logical/sphinx-prolog#floppy_disk-swish-directive
