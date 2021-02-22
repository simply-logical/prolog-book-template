---
substitutions:
  swishq_display_injected: |
    ```{swish-query} swishq:display-in
    ---
    source-id: swish:in-1 swish:in-2
    ---
    ?- exists_extension(jupyter_book,
                        Injected).
    ```
  swishq_display_injected_text: |
    ````text
    ```{swish-query} swishq:display-in
    ---
    source-id: swish:in-1 swish:in-2
    ---
    ?- exists_extension(jupyter_book,
                        Injected).
    ```
    ````
---
<!--NOTE: Since the panel separation syntax (---) is the same as the
          directive syntax used to provide parameters (--- fence), we need to
          use substitutions to insert parameterised directives into panels.
-->

(sec:sphinxprolog:swish)=
# SWISH *Code* and *Query* Blocks #

At the core of our `sphinx-prolog` extension is the `swish` module;
it enables creation of interactive [SWI Prolog] code boxes by abstracting
their setup complexities away from the content creator.
Interactivity is achieved by dynamically embedding [SWISH] windows that bring
an online, collaborative Prolog execution environment.
The `sphinx_prolog.swish` Sphinx extension module implements two types of
*display* boxes -- `swish` and `swish-query` -- and one inline code
listing introduced with `swish-query`.
The `swish` command is responsible for creating interactive SWISH Prolog code
blocks.
Both `swish-query` instructions, on the other hand, embed plain-looking code
listings designated for Prolog queries, which can be exported to or imported
by SWISH code blocks.

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

(sec:sphinxprolog:swish:setup:exfiles)=
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

:::{tip}
In addition to Prolog, the `sphinx-prolog` package can be used to build
documents with interactive [cplint] code blocks.
More information can be found at
<https://cplint-template.simply-logical.space/>.
:::

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

(sec:sphinxprolog:swish:setup:visibility)=
### Hiding SWISH Queries ###

One way to pre-populate Prolog queries into your interactive SWISH boxes
is to include a specially formatted *examples* section in your code, e.g.,
```Prolog
...

/** <examples>
?- my_query(a,X).
?- my_query(b,X).
*/
```
(more on that in the {ref}`sec:sphinxprolog:swish:usage:explicitqueries`
section below).
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
### Loading Long SWISH Scripts ###

Your Prolog code and queries are transferred to the interactive SWISH boxes
within a URL request, e.g.,
[https://swish.swi-prolog.org/?code=exists_extension(sphinx,prolog).&q=exists_extension(sphinx,A).](https://swish.swi-prolog.org/?code=exists_extension(sphinx,prolog).&q=exists_extension(sphinx,A).).
Since URL requests are limited to 2,048 characters, longer box content
cannot be transferred with this approach.
To support large Prolog scripts, a different SWISH URL request format can be
used:
[https://swish.swi-prolog.org/?code=https://book-template.simply-logical.space/_sources/prolog_build_files/long-complex-merged.pl&q=exists_extension(jupyter_book,A).](https://swish.swi-prolog.org/?code=https://book-template.simply-logical.space/_sources/prolog_build_files/long-complex-merged.pl&q=exists_extension(jupyter_book,A).),
where the `code` section specifies the web address of a Prolog code file.
Such code files can be generated automatically by this extension and uploaded
alongside your book to support long Prolog scripts.
The entire procedure is executed under the hood and such code boxes are no
different to standard SWISH boxes, however this functionality **must** be
enabled for each individual code block via its `build-file` parameter --
see the {ref}`sec:sphinxprolog:swish:usage:file` section below for more details.

While such boxes will function as expected when the book is published online,
they **will not be able** to load the underlying Prolog script when the book
is built locally during development.
Since the Prolog file used by such a SWISH block is created by the Jupyter
Book build process, it will not be accessible to the code box until the book
is uploaded online.
To enable this functionality, the `sphinx-prolog` extension **must** know the
base URL under which your book will be published.
This information can be supplied via the `sp_swish_book_url` configuration
setting.
```yaml
sphinx:
  config:
    # Configure sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    sp_swish_book_url: https://book-template.simply-logical.space/
```
It is used to compose links to Prolog code files that need to be accessed by
file-based SWISH boxes.

The Prolog files underlying such SWISH code blocks are temporarily
stored in the `src/code/temp/` directory (relative to the root of your book)
before being copied over to the `_sources/prolog_build_files/` folder
located in the book build directory `_build/html/`.
To avoid unnecessarily storing these files in your git repository,
you may want to add the `src/code/temp/` path to your [`.gitignore`].
Additionally, this temporary storage location should be excluded from the
Jupyter Book build path by adding it to the `exclude_patterns` list
in your [`_config.yml`] configuration file.
```yaml
exclude_patterns:
  - src/code/temp
```
This will help to avoid build issues down the line.

:::{warning}
File-based SWISH code boxes -- enabled by the
[`build-file` parameter](sec:sphinxprolog:swish:usage:file) individually for
each SWISH block -- will not work for local builds of your book since their
underlying Prolog files cannot be accessed by SWISH until you upload them
online alongside your book.
:::

## Usage ##

Display SWISH code and query blocks are included using an admonition-like
syntax, with their content provided explicitly in the definition statement.
To build either of those two boxes use a triple-backtick fence respectively
with `swish` or `swish-query` keyword wrapped in curly braces followed by
a user-defined tag, i.e., `` ```{swish} swish:my-tag `` and
`` ```{swish-query} swishq:my-tag ``.
An inline SWISH query, on the other hand, is introduced using reference-like
syntax, with its tag inserted in angle bracket after the query text, i.e.,
`` {swish-query}`?- query(Q). <swishq:my-tag>` ``.

The Prolog content included with these statements *can be referenced*.
Since Prolog elements are *unnumbered*, they can **only** be hyper-linked
with a pre-defined name using the `` {ref}`my-tag` `` syntax.
In particular:
* referencing a SWISH **code** box -- `` {ref}`swish:my-tag` `` -- produces a
  "*SWISH code box*" hyper-link;
* referencing a SWISH **query** *box* (display) --
  `` {ref}`swishq:my-display-tag` `` -- produces a "*SWISH query box*"
  hyper-link; and
* referencing a SWISH **query** *listing* (inline) --
  `` {ref}`swishq:my-inline-tag` `` -- produces a "*SWISH query listing*"
  hyper-link.

Keep in mind that the text of these hyper-links can be changed manually using
the `` {ref}`Custom Text <my-tag>` `` syntax.

:::{seealso}
See the {ref}`sec:sphinxprolog:solex:referencing` section of the
{ref}`sec:sphinxprolog:solex` page and the {ref}`sec:sphinxprolog:usage`
section of the {ref}`sec:sphinxprolog` page for more details about
*referencing*.
:::

(sec:sphinxprolog:swish:usage:simple)=
### Code Boxes ###

Interactive `swish` code boxes can either list their Prolog script explicitly
or load it from an external programme file.
Each `swish` block **must** be tagged with a label prefixed with `swish:`.

:::{tip}
To improve readability of interactive SWISH code boxes and the markdown syntax
responsible for their creation, we use *tabs* instead of side-by-side
display panels utilised thus far.
To access the source of each SWISH box presented on this page, click the
*Syntax* tab above the code block.
:::

#### Verbatim Code ####

The easiest way to construct an interactive SWISH code box is to include your
Prolog script within the box.

:::{tabbed} Outcome
```{swish} swish:simple-example
exists_extension(sphinx, jupyter_book).
exists_extension(sphinx, prolog).

/** <examples>
?- exists_extension(sphinx, A).
*/
```
:::
:::{tabbed} Syntax
````text
```{swish} swish:simple-example
exists_extension(sphinx, jupyter_book).
exists_extension(sphinx, prolog).

/** <examples>
?- exists_extension(sphinx, A).
*/
```
````
:::

#### Code File ####

If you prefer to store your Prolog scripts in external programme files,
you can load them into `swish` code boxes by placing them in a dedicated
directory and setting up the `sphinx-prolog` extension appropriately.
(See the {ref}`sec:sphinxprolog:swish:setup:exfiles` section above for more
details and setup instructions.)
The Prolog files **must** have `.pl` extension;
they are loaded into `swish` code boxes by **formatting the tags of such boxes
based on the names of these files**.
To this end, prepend the `swish:` prefix to and discard the `.pl` extension
from the selected Prolog file name.
For example, the file named [`prolog_file.pl`] stored in [`src/code/`] can be
loaded into a selected SWISH code box with the `swish:prolog_file` tag.

:::{tabbed} Outcome
```{swish} swish:prolog_file
```
:::
:::{tabbed} Syntax
````text
```{swish} swish:prolog_file
```
````
:::

As with {ref}`exercise and solution blocks <sec:sphinxprolog:solex:use-files>`,
the content of a SWISH box loaded from an external file can be **overwritten**
by inserting a Prolog script directly in the box definition.

:::{tabbed} Outcome
```{swish} swish:prolog_file_copy
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, A).
*/
```
:::
:::{tabbed} Syntax
````text
```{swish} swish:prolog_file
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, A).
*/
```
````
:::

:::{note}
If you look at the markdown source of this document, you will notice
that the syntax of the {ref}`swish:prolog_file_copy` placed directly above
uses a different tag (`swish:prolog_file`) than the actual definition of this
block (`swish:prolog_file_copy`).
Since two SWISH code boxes cannot be built from the same source file
(due to a label conflict), we duplicated the [`prolog_file.pl`] Prolog
source file with the [`prolog_file_copy.pl`] name.
::::

### Query Boxes ###

SWISH code boxes can be populated with Prolog queries in a number of ways.
Queries can be *manually inserted* into SWISH code boxes or
*automatically imported* from selected *SWISH query* elements.
The latter approach requires the user to embed and tag this type of content
in the markdown source of a page.
There are two types of such boxes: *inline* and *display*, each one with a
dedicated syntax based on the `swish-query` keyword.
Each SWISH query element **must** be tagged with a label prefixed with
`swishq:`.
Both inline and display query elements can contain multiple Prolog queries,
each one starting with `?-` and finished with `.`.
**Inline query elements containing a single Prolog query may omit the opening
`?-` and closing `.` symbols.**

#### Inline ####

Inline SWISH queries appear as *code snippets* displayed in typewriter font
without syntax highlighting.

```{panels}
Outcome
^^^
A possible SWISH query embedded inline is
{swish-query}`?- exists_extension(jupyter_book, Inline). <swishq:inline>`.

---

Syntax
^^^
A possible SWISH query embedded inline is
`` {swish-query}`?- exists_extension(jupyter_book, Inline). <swishq:inline>` ``.
```

#### Display ####

Display SWISH queries appear as block *code listings* formatted with the
Prolog syntax highlighting.

:::{panels}
Outcome
^^^
A SWISH query can also be displayed as a block:
```{swish-query} swishq:display
?- exists_extension(jupyter_book,
                    Display).
```

---

Syntax
^^^
A SWISH query can also be displayed as a block:
````text
```{swish-query} swishq:display
?- exists_extension(jupyter_book,
                    Display).
```
````
:::

---

*Importing* tagged Prolog queries into SWISH code boxes is mostly initiated
by each code block individually.
However, in some cases it may be more convenient to reverse this process and
*export* a SWISH query into selected code blocks.
The optional `source-id` parameter is used to this end -- it takes a
space-separated list of tags of the target code boxes.
This functionality is **only** available for *display* `swish-query` blocks.
Multiple query boxes can be exported to a single SWISH code block.

:::{panels}
Outcome
^^^
A display SWISH query can be exported into selected code blocks.

{{ swishq_display_injected }}

---

Syntax
^^^
A display SWISH query can be exported into selected code blocks.

{{ swishq_display_injected_text }}
:::

This query is exported to the two SWISH code boxes displayed below.
Note that the export procedure **overrides** the queries listed in SWISH
code boxes explicitly via the `/** <examples> ... */` syntax.
Therefore, the second code box will disregard the verbatim
`exists_extension(sphinx, Q).` query and only present the user with the
exported `exists_extension(jupyter_book, Injected)` query.
Queries can only be exported to SWISH code boxes placed on **the same page**,
i.e., in the same markdown document.

:::{tabbed} Outcome
```{swish} swish:in-1
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).
```

```{swish} swish:in-2
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, Q).
*/
```
:::
:::{tabbed} Syntax
````text
```{swish} swish:in-1
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).
```

```{swish} swish:in-2
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, Q).
*/
```
````
:::

### Implicit Queries ###

The more natural approach to including Prolog queries in your interactive SWISH
code blocks is to either *assign* them directly to a box or *import* them
from query blocks.

#### Hard-coding Queries ####

Prolog queries can be included in a SWISH code box using the `query-text`
parameter.
It simply lists the queries that are to be available in a code block without
revealing them to the user prior to running the box.
```yaml
query-text: |
  ?- exists_extension(jupyter_book, HQ_1).
  ?- exists_extension(jupyter_book, HQ_2).
```
Each query **must** be prefixed with `?-` and finished with `.`, with multiple
queries separated by a white space.
The `|` notation is a syntactic sugar that allows to split a parameter string
into multiple lines.

:::{tabbed} Outcome
```{swish} swish:hq
---
query-text: |
  ?- exists_extension(jupyter_book, HQ_1).
  ?- exists_extension(jupyter_book, HQ_2).
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).
```
:::
:::{tabbed} Syntax
````text
```{swish} swish:hq
---
query-text: |
  ?- exists_extension(jupyter_book, HQ_1).
  ?- exists_extension(jupyter_book, HQ_2).
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).
```
````
:::

Including Prolog queries via the `query-text` SWISH box parameter is
**compatible** with the query import facilitated via the `query-id` parameter
described below and the `source-id` *export* parameter of SWISH query boxes.
However, this procedure **overrides** the queries provided explicitly
in SWISH code boxes with the `/** <examples> ... */` syntax.

#### Importing Queries ####

Another approach to populating interactive SWISH code blocks with Prolog
queries is importing them from SWISH query boxes.
It is achieved via the `query-id` parameter, which lists the tags of query
boxes that ought to be imported.
```yaml
query-id: swishq:inline swishq:display swishq:display-in
```
Queries can only be imported from SWISH query boxes placed on the same page,
i.e., in the same markdown document.

:::{tabbed} Outcome
```{swish} swish:iq
---
query-id: swishq:inline swishq:display swishq:display-in
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).
```
:::
:::{tabbed} Syntax
````text
```{swish} swish:iq
---
query-id: swishq:inline swishq:display swishq:display-in
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).
```
````
:::

Importing Prolog queries via the `query-id` SWISH box parameter is
**compatible** with the queries defined via the `query-text` parameter
described above and the `source-id` *export* parameter of SWISH query boxes.
However, this procedure **overrides** the queries provided explicitly
in SWISH code boxes with the `/** <examples> ... */` syntax.

(sec:sphinxprolog:swish:usage:explicitqueries)=
### Explicit Queries ###

All of the Prolog query input methods described so far operate at the level
of defining SWISH code boxes in your markdown source.
Moreover, such queries are invisible to the user until the code block is
launched.
This may be sub-optimal when you want to display the queries directly in the
embedded SWISH code boxes or if you want to distribute them alongside your
Prolog script -- either verbatim in the code block (markdown source) or
within a standalone Prolog file that is being imported.
In these cases, you can insert your queries explicitly in the Prolog script
within a specially formatted comment block: `/** <examples> ... */`
(see the [official SWISH help page] for more details).
```Prolog
...

/** <examples>
?- exists_extension(jupyter_book, HQ_1).
?- exists_extension(jupyter_book, HQ_2).
*/
```
Queries distributed in this way can be easily overridden with the SWISH code
blocks' `query-text` and `query-id` parameters and the `source-id` parameter
of SWISH query boxes.

:::{tip}
A SWISH code block can be supplied with Prolog queries either explicitly by
including the dedicated `/** <examples> ... */` comment bloc or implicitly
via the box parameters.
The latter method includes importing queries from SWISH query blocks using the
`query-id` parameter or inputting them directly via the `query-text` parameter.
Alternatively, SWISH queries can be exported from *display* query boxes to
selected SWISH code blocks via the `source-id` parameter of query boxes.
The three implicit methods -- `query-id`, `query-text` and `source-id` --
are cross-compatible, and the presence of any single one of them overrides
the queries provided explicitly via the `/** <examples> ... */` comment bloc.
Note that queries can only be *imported* to SWISH code blocks and *exported*
from SWISH query boxes if these elements are placed on **the same page**,
i.e., within a single markdown document.
:::

(sec:sphinxprolog:swish:usage:visibility)=
### Hiding Queries ###

You may want to have the benefits of storing your queries in Prolog files or
verbatim scripts, e.g., for completeness, but prefer to hide them from the
user.
To this end, you can toggle visibility of the `/** <examples> ... */` comment
blocks either *globally* for the entire book or *locally* for individual code
boxes.
The former is explained in the {ref}`sec:sphinxprolog:swish:setup:visibility`
section above.
The global behaviour can be overridden locally using the `hide-examples`
parameter of SWISH code boxes.
```yaml
hide-examples: true
```
This switch works for verbatim and file-based code blocks.

:::{tabbed} Outcome
You will only see the `/** <examples> ... */` portion of this code box
in the programme section of the SWISH window after launching it.
```{swish} swish:hide
---
hide-examples: true
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, HiddenQuery).
*/
```
:::
:::{tabbed} Syntax
You will only see the `/** <examples> ... */` portion of this code box
in the programme section of the SWISH window after launching it.
````text
```{swish} swish:hide
---
hide-examples: true
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, HiddenQuery).
*/
```
````
:::

(sec:sphinxprolog:swish:usage:advanced)=
### Advanced Code Boxes ###

In certain cases, a SWISH code box may depend on a Prolog programme that has
been split into multiple code blocks scattered throughout a page.
To avoid manually repeating these pieces of code in multiple boxes, we allow
each SWISH code block to *inherit* content from multiple other boxes.
Additionally, we facilitate *injecting* external Prolog code into a SWISH
code block such that it is only visible upon launching this box.
Both these operations can be applied to a single code block simultaneously.
When a piece of code is inherited or injected, it is **stripped** of all its
`/** <examples> ... */` blocks to avoid accumulating unwanted queries.

:::{warning}
When **inheriting** code from SWISH code blocks, all of the boxes involved
in this procedure must reside on **the same** page, i.e., be placed in a
single markdown file.
**Code injection** is not affected by this limitation since it is based on
external Prolog files.
:::

#### Code Inheritance ####

The inheritance is implicit and the inherited code gets injected only when
a box is launched, therefore not affecting its appearance.
Multiple code blocks can be inherited using the `inherit-id` parameter,
which takes a space-separated list of code box tags.
```yaml
inherit-id: swish:iq swish:hide
```

:::{tabbed} Outcome
```{swish} swish:inherit
---
inherit-id: swish:iq swish:hide
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, InheritingCodeBox).
*/
```
:::
:::{tabbed} Syntax
````text
```{swish} swish:inherit
---
inherit-id: swish:iq swish:hide
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, InheritingCodeBox).
*/
```
````
:::

#### Code Injection ####

In addition to inheriting code from existing SWISH code block, code from
external Prolog files can be *prepended* or *appended* to a code box.
These Prolog programme files **must** be placed in the designated code
directory -- see the {ref}`sec:sphinxprolog:swish:setup:exfiles` section
above for more details.
The code injection is achieved with the `source-text-start` and
`source-text-end` parameters of SWISH code boxes.
Each one takes a **single** Prolog code file name without the `.pl` extension,
for example
```yaml
source-text-start: prepend_code
source-text-end: append_code
```
uses the two files -- [`prepend_code.pl`] and [`append_code.pl`] -- located
in the [`src/code/`] directory.
Note that in this way you can include a Prolog code file that is already being
used as the main source of an existing SWISH code block without any conflicts.
For example, you can prepend or append the [`prolog_file.pl`] file despite it
being used as the source of {ref}`this SWISH code box <swish:prolog_file>`.
Similar to inheritance, code injection is *implicit*, hence the prepended and
appended code is only visible after launching a code box.

:::{tabbed} Outcome
Note that the `/** <examples> ... */` block is purged from the
[`append_code.pl`] code file when it is being injected.
```{swish} swish:inject
---
source-text-start: prepend_code
source-text-end: append_code
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, ExplicitQuery).
*/
```
:::
:::{tabbed} Syntax
Note that the `/** <examples> ... */` block is purged from the
[`append_code.pl`] code file when it is being injected.
````text
```{swish} swish:inject
---
source-text-start: prepend_code
source-text-end: append_code
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, ExplicitQuery).
*/
```
````
:::

(sec:sphinxprolog:swish:usage:file)=
### Long Boxes ###

The default technology used to construct SWISH code boxes limits their
size -- see the {ref}`sec:sphinxprolog:swish:config:longfiles` section for
more details about this issue and the `sphinx-prolog` configuration setup
necessary to overcome it.
Note that the main, imported and injected code as well as the implicit,
inherited and exported queries all count towards the code box size.
The SWISH code block embedded below is loaded from the [`long_programme.pl`]
code file whose length exceeds the size limit, therefore the box fails to
materialise when attempting to launch it.

:::{tabbed} Outcome
```{swish} swish:long_programme_copy
```
:::
:::{tabbed} Syntax
````text
```{swish} swish:long_programme
```
````
:::

:::{note}
If you look at the markdown source of this document, you will notice
that the actual *tags* of SWISH code boxes placed in this section are
different from those listed in the *Syntax* tabs.
Again, this is because multiple boxes cannot be built from a single Prolog
source file (due to a label conflict), requiring us to duplicate the
`long_programme.pl` code file.
:::

Such boxes can be made functional by loading them from external Prolog
files behind the scenes (instead of sending their contend via URL requests).
This file can be composed automatically during the book building process by
enabling long file functionality with the `build-file` parameter of the
SWISH code boxes.
```yaml
build-file: true
```
Such SWISH boxes will not work when browsing the local build of your book
since the underlying code files must be hosted on a server accessible by SWISH.
As noted in the {ref}`sec:sphinxprolog:swish:config:longfiles` section above,
these special code files are uploaded alongside your book, thus enabling the
`build-file` SWISH code boxes to function correctly after publishing your
book online.
(You can preview the Prolog file loaded by the SWISH code box placed below
[here][long_programme].)

:::{tabbed} Outcome
```{swish} swish:long_programme
---
build-file: true
---
```
:::
:::{tabbed} Syntax
````text
```{swish} swish:long_programme
---
build-file: true
---
```
````
:::

::::{note}
All of the SWISH code and query block functionality is compatible with each
other, unless explicitly stated in this document.
The {ref}`following example <swish:long-complex>`:
* *prepends* a code file,
* *appends* a code file,
* *inherits* two code blocks,
* *imports* three queries, and
* explicitly *states* additional two queries.

Moreover, {ref}`a query <swishq:long-complex>` is *exported* into
{ref}`this SWISH code block <swish:long-complex>`.
We also request to build an external Prolog file in case the entire
content is too long to be loaded directly (you can preview the built file
[here][long-complex]).
Finally, we hide the explicit `/** <examples> ... */` query block since it will
be overridden by all the other queries anyway.

:::{tabbed} Outcome
The following query
```{swish-query} swishq:long-complex
---
source-id: swish:long-complex
---
?- exists_extension(jupyter_book, Exported).
```
is exported into the SWISH code block displayed below.
```{swish} swish:long-complex
---
inherit-id: swish:iq swish:hide
source-text-start: prepend_code
source-text-end: append_code
query-id: swishq:inline swishq:display swishq:display-in
query-text: |
  ?- exists_extension(jupyter_book, HQ_1).
  ?- exists_extension(jupyter_book, HQ_2).
hide-examples: true
build-file: true
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, ExplicitQuery).
*/
```
:::
:::{tabbed} Syntax
The following query
````text
```{swish-query} swishq:long-complex
---
source-id: swish:long-complex
---
?- exists_extension(jupyter_book, Exported).
```
````
is exported into the SWISH code block displayed below.
````text
```{swish} swish:long-complex
---
inherit-id: swish:iq swish:hide
source-text-start: prepend_code
source-text-end: append_code
query-id: swishq:inline swishq:display swishq:display-in
query-text: |
  ?- exists_extension(jupyter_book, HQ_1).
  ?- exists_extension(jupyter_book, HQ_2).
hide-examples: true
build-file: true
---
exists_extension(jupyter_book, prolog).
exists_extension(jupyter_book, markdown).

/** <examples>
?- exists_extension(jupyter_book, ExplicitQuery).
*/
```
````
:::
::::

---

:::{seealso}
For more information about the *SWISH* module see its
[*technical documentation*].
:::

[SWI Prolog]: https://www.swi-prolog.org/
[SWISH]: https://swish.swi-prolog.org/
[SWI Prolog team]: https://www.swi-prolog.org/Contributors.html
[`src/code/`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/code
[`prolog_file.pl`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/code/prolog_file.pl
[`prolog_file_copy.pl`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/code/prolog_file_copy.pl
[*technical documentation*]: https://github.com/simply-logical/sphinx-prolog#floppy_disk-swish-directive
[official SWISH help page]: https://swish.swi-prolog.org/help/help.html#help-examples
[cplint]: https://friguzzi.github.io/cplint/_build/html/
[`prepend_code.pl`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/code/prepend_code.pl
[`append_code.pl`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/code/append_code.pl
[`long_programme.pl`]: https://github.com/simply-logical/prolog-book-template/tree/master/src/code/long_programme.pl
[`.gitignore`]: https://github.com/simply-logical/prolog-book-template/tree/master/.gitignore
[`_config.yml`]: https://github.com/simply-logical/prolog-book-template/tree/master/_config.yml
[long_programme]: https://book-template.simply-logical.space/_sources/prolog_build_files/long_programme-merged.pl
[long-complex]: https://book-template.simply-logical.space/_sources/prolog_build_files/long-complex-merged.pl
