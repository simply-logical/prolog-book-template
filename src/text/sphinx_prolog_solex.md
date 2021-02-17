(sec:sphinxprolog:solex)=
# *Exercise* and *Solution* Blocks #

Sometimes you may want to set some (programming) *exercises* for your readers,
and help them to learn by also publishing corresponding *solutions*.
While Jupyter Book supports enumerated environments for figures, tables,
equations and (part/chapter/section) headers, it lacks support for
(enumerable, referenceable and interlinked) exercise and solution boxes.
Our `sphinx_prolog.solex` Sphinx extension module addresses this shortcoming
by implementing two coupled boxes -- `exercise` and `solution` -- based on
Jupyter Book admonitions.

:::{seealso}
See the {ref}`sec:sphinxprolog:infobox` section for more information about
[Jupyter Book admonitions].
:::

## Setup ##

To enable the `sphinx_prolog.solex` extension module in your Jupyter Book,
include its name in your `_config.yml` file under the `sphinx.extra_extensions`
key
```yaml
sphinx:
  extra_extensions:
    # Load sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    - sphinx_prolog.solex
```

:::{seealso}
See the {ref}`sec:sphinxprolog:usage` section of the {ref}`sec:sphinxprolog`
page for more details.
:::

## Configuration ##

You can configure and personalise the `sphinx_prolog.solex` extension
in a number of ways.
For example, the content of *exercise* and *solution* boxes can be sourced
from different locations depending on the user's preferences.
It can either be provided explicitly within a document or loaded from an
external markdown file -- an option that allows to streamline repeating the
exercise text in its corresponding solution box.

By default, each *exercise* is assigned a sequential number and it is named
according to the "*Exercise #*" pattern.
Similarly, a *solution* linked to a particular exercise reuses its sequential
number with the "*Solution #*" template.
Both of these naming patterns can be adapted to one's liking, e.g., to
"*Task #*" and "*Answer #*".

(sec:sphinxprolog:solex:setup-files)=
### Setting up External Files ###

The content of exercise and solution boxes can either be:
* provided manually within each box, or
* loaded from an external markdown file.

The latter possibility has been implemented to streamline inclusion of
solution boxes.
Since you may decide to collect all the solutions on a single page,
say in the appendix, it may be useful to repeat the exercise text for clarity.
In this case you only need to edit the exercise source file to update the
text displayed in the *exercise* and *solution* blocks pair.
See the {ref}`sec:sphinxprolog:solex:use-files` section of this page for more
details.

:::{note}
An exercise block and its corresponding solution box may be placed on
two **different pages** in your book.
:::

To load *exercise* and *solution* blocks from external markdown files,
they must be placed in a dedicated directory.
The `sphinx_prolog.solex` extension is then informed of this location via
the `sp_exercise_directory` configuration parameter, which is placed under
the `sphinx.config` key in the `_config.yml` file.
```yaml
sphinx:
  config:
    # Configure sphinx-prolog <https://github.com/simply-logical/sphinx-prolog>
    sp_exercise_directory: src/ex/
```
This path must be relative to the root directory of your book, i.e., the place
where you hold your `_config.yml` file.
It must also be added to the `exclude_patterns` configuration parameter
to exclude it from the book build sources.
```yaml
exclude_patterns:
  - src/ex
```
This is to avoid build errors since Jupyter Book expects all of the markdown
files placed below its root directory to be included in the table of content.

:::{seealso}
See the {ref}`sec:jupyterbook:config` section of the {ref}`sec:jupyterbook`
page for more details about configuring your book.
:::

(sec:sphinxprolog:solex:naming)=
### Custom Naming ###

By default, exercise blocks are assigned a sequential number with a title
based on the "*Exercise #*" template.
Similarly, solutions reuse the sequential numbers of their corresponding
exercises and are given a title based on the "*Solution #*" pattern.
These templates can be changed in the Jupyter Book configuration file
(`config.yml`) under the `sphinx.config.numfig_format` key.
```yaml
sphinx:
  config:
    numfig_format:
      exercise: "Task %s"
      solution: "Answer %s"
```
Custom formatters are strings with a special `%s` component that gets
automatically replaced with the sequential number of a given exercise or
solution.

:::{seealso}
See the {ref}`sec:sphinxprolog:solex:tagging` and
{ref}`sec:sphinxprolog:solex:referencing` sections of this page for more
details.
Alternatively, refer to the [referencing overview] section of the
Jupyter Book documentation.
:::

## Usage ##

Exercise blocks are included with an admonition-like syntax, with their content
explicitly stated in the definition statement.
To build an exercise block use a triple-backtick fence with the `exercise`
keyword wrapped in curly braces followed by a user-defined
tag, i.e., `` ```{exercise} ex:my-tag ``

`````{panels}
Outcome
^^^
:::{exercise} ex:one
This is an exercise example.
:::

---

Syntax
^^^
````text
```{exercise} ex:my-tag
This is an exercise example.
```
````
`````

Solution boxes follow a similar syntax with the `exercise` keyword replaced
by `solution`

`````{panels}
Outcome
^^^
```{solution} ex:one
This is a solution example.
```

---

Syntax
^^^
````text
```{solution} ex:my-tag
This is a solution example.
```
````
`````

By hovering your mouse over the title section of an exercise or a solution box
(respectively, the green- and yellow-coloured bar at the top), a hyper-link
marker (¶) will be revealed to the right of the title text
("*Exercise #*" and "*Solution #*" correspondingly).
By clicking the marker you will get a link pointing directly to this particular
exercise or solution box.

(sec:sphinxprolog:solex:tagging)=
### Tagging ###

Definitions of both *exercise* and *solution* boxes **require** one parameter.
For exercise blocks, it assigns a **unique** tag to this box and it
**must be prefixed** with `ex:`.
While not every exercise block requires a corresponding solution box,
**solution blocks can only be built by linking them to existing exercise
boxes.**
This linking is achieved by reusing exercise tags when defining solution
blocks.
For example, to associate a solution to an existing exercise tagged
with `ex:my-tag`, it needs to be defined as `` ```{solution} ex:my-tag ``
-- see {numref}`ex:one` and {numref}`sol:one` above.
Linking guarantees that both blocks will have **the same sequential number**.
It also embeds a hyper-link from an exercise to its solution -- marked with
the {fa}`check-double` glyph on the right-hand side of the title bar
-- and vice versa (the {fa}`tasks` glyph).
Naturally, exercises without corresponding solutions will lack the
{fa}`check-double` solution hyper-link -- see {numref}`ex:two` below.

:::{exercise} ex:two
This is an example of an exercise without a solution.
:::

:::{tip}
Every solution must be linked to an existing exercise, but not all exercises
require a solution.
:::

(sec:sphinxprolog:solex:referencing)=
### Referencing ###

Similar to {ref}`Information Boxes <sec:sphinxprolog:infobox:ref>`,
solution and exercise blocks can be referenced with their tags.
Exercises can be referenced with the `` {ref}`ex:my-tag` `` syntax, which
produces a hyper-link displayed as "*exercise*", e.g., {ref}`ex:one` points to
{numref}`ex:one`.
The default "*exercise*" text can be manually substituted with a custom label
using the `` {ref}`custom exercise label <ex:my-tag>` `` syntax, e.g.,
{ref}`see this exercise <ex:one>` also points to {numref}`ex:one`.

You can also reference exercises with their automatically assigned sequence
number.
This is achieved with the ``{numref}`ex:my-tag` `` syntax -- it was used to
generate the numbered exercise references above.
The hyper-link text displayed by this referencing strategy is controlled by
the *exercise naming scheme* defined in the configuration file --
see the {ref}`sec:sphinxprolog:solex:naming` section of this page for more
information.
If you wish to change the numbered hyper-link text for individual references,
this can be achieved with the
`` {numref}`Custom Sequential Name %s <ex:my-tag>` `` syntax.
For example, {numref}`Challenge %s <ex:two>` is a custom numbered reference
to {numref}`ex:two`.

Hyper-linking *solution* boxes follows the same logic with one minor caveat.
**Because solutions reuse tags of their respective exercises,
to reference a solution with an `ex:my-tag` label
substitute the `ex:` prefix with `sol:`.**
For example, referencing {numref}`sol:one` using its number is achieved with
`` {numref}`sol:my-tag` ``.

:::{tip}
To reference a solution to an exercise tagged with `ex:my-tag`,
substitute the `ex:` prefix with `sol:`, i.e., use `` {ref}`sol:my-tag` ``.
:::

(sec:sphinxprolog:solex:use-files)=
### Loading External Files ###

Thus far, each exercise and solution block embedded on this page had
its content explicitly inserted when defining the box.
Alternatively, this content can be loaded from an external markdown file --
see the {ref}`setup instructions <sec:sphinxprolog:solex:setup-files>`
described above.
Assuming that you have an exercise file in the designated directory --
in our case, [`exercise_file.md`] placed in [`src/ex/`] -- you can load it
into a selected exercise box and its corresponding solution block.
**This is achieved by using a label derived from the name of this file.**
To this end, prepend the `ex:` prefix to and discard the `.md` extension from
the exercise file name;
for example, our `exercise_file.md` file can be loaded with
`ex:exercise_file` tag.

`````{panels}
Outcome
^^^
:::{exercise} ex:exercise_file
:::

---

Syntax
^^^
````text
```{exercise} ex:exercise_file
```
````
`````

Building a solution box from the source file underlying its corresponding
exercise follows the same pattern.

`````{panels}
Outcome
^^^
:::{solution} ex:exercise_file
:::

---

Syntax
^^^
````text
```{solution} ex:exercise_file
```
````
`````

:::{tip}
To load the content of an exercise box and its corresponding solution block
from a file, compose their label by prepending the `ex:` prefix to and
discarding the `.md` extension from this file's name.
For example, a file named `exercise_file.md` can be loaded with the
`ex:exercise_file` tag.
:::

In some cases, you may wish to overwrite the content of an exercise or a
solution box loaded from a file.
To this end, provide the content of such a box explicitly when defining it --
verbatim content takes precedence over the tag-matching file if one exists.
This functionality may be helpful when you want the solution box to use a
phrasing that is different to the content of the corresponding exercise.
For example, when the exercise refers to a figure placed outside of its box
on the same page, and you want include it in the solution box.

`````{panels}
Outcome
^^^
:::{exercise} ex:exercise_file_copy
:::

---

Syntax
^^^
````text
```{exercise} ex:exercise_file
```
````
`````

`````{panels}
Outcome
^^^
:::{solution} ex:exercise_file_copy
Custom phrasing of the solution.
:::

---

Syntax
^^^
````text
```{solution} ex:exercise_file
Custom phrasing of the solution.
```
````
`````

:::{note}
If you look at the markdown source of this document, you will notice
that the syntax of {numref}`ex:exercise_file_copy` and
{numref}`sol:exercise_file_copy` presented above uses a different tag
(`ex:exercise_file`) than the actual definition of these blocks
(`ex:exercise_file_copy`).
Since two exercise boxes cannot be built from the same source file
(due to a label conflict), we duplicated the [`exercise_file.md`] exercise
source file with the [`exercise_file_copy.md`] name.
:::

:::{tip}
To overwrite the content of an exercise or a solution box loaded from a file,
simply provide its new content explicitly when defining it.
:::

---

:::{seealso}
For more information about the *Exercise and Solution* module see
its [*technical documentation*].
:::

[Jupyter Book admonitions]: https://jupyterbook.org/reference/cheatsheet.html#admonitions
[*technical documentation*]: https://github.com/simply-logical/sphinx-prolog#trophy-exercise-and-solution-directives
[referencing overview]: https://jupyterbook.org/content/citations.html#referencing-overview
[`exercise_file.md`]: https://github.com/simply-logical/prolog-book-template/blob/master/src/ex/exercise_file.md
[`exercise_file_copy.md`]: https://github.com/simply-logical/prolog-book-template/blob/master/src/ex/exercise_file_copy.md
[`src/ex/`]: https://github.com/simply-logical/prolog-book-template/blob/master/src/ex/
