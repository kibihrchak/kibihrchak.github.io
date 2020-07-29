---
title:      "Line Length Limit"
tags:       formatting code line-length wrap indentation
---

```
1   5    10   15   20   25   30   35   40   45   50   55   60   65   70   75
80   85   90   95   100  105  110  115  120
|...|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|
```

## Table of Contents

1.  TOC
{:toc}

## Version History

|Date       |Description
|---        |---
|2020-07-29 |Initial version

## Overview

Some time ago while looking through the Internets, [a Reddit post on
Linus' rant about 80CPL limit][reddit_linus-rant] caught my attention.
The gist was that 80CPL is a thing of a past, and "more reasonable"
limit should become a norm, like 120CPL or so.

This got me thinking on, what actually constitutes a justification for
"more reasonable" limit, or, should limit be imposed at all?

This analysis tries to answer -

1.  If and when limiting line length for text files matters
2.  Also in that context - What would be the appropriate line length
    limit?

First part of this post is dedicated to the perceived origins of the
problem, and to describing the underlying problem domain. It is followed
next by a summary of relevant factors when choosing if and what CPL
limit to impose.

Also, at the end there is some other useful information, like glossary
used for terms here (like CPL), some CPL limit examples, and a resource
list.

## A Look at The Problem

Trigger for delving into the topic are the statements in discussion
groups/blog posts like -

*   Pro banishing 80CPL:
    *   120CPL is the magic number.
    *   Why stick with 80CPL when we're not using 80CPL screens? 4K/dual
        monitor setup is a norm today.
    *   80CPL makes code unnecessary long.
    *   80CPL encourages naming abbreviation which reduces readability.
    *   Line breaks limit use of line-based tools.
*   Pro sticking to 80CPL:
    *   Diff viewers use is easier with lower limit.
    *   80CPL supports easy side-by-side editing (if you don't want to
        accept word wrap).
    *   80CPL supports easy font enlargement for presentation/video
        recording.

One important thing mentioning here is that the bulk of these examples
relate to code files, seeming to stem from code file lines becoming too
long, but CPL rules apply to document files, too. Still, these examples
may be used as a starting point to developing the view on the problem
domain. Based on them, following generalized use cases are derived -

1.  Optimal CPL when writing code in a single-window IDE.
2.  Optimal CPL when writing code and having to reference some other
    location in source tree, in a multi side-by-side viewport setup.
3.  Not being able to wrap long lines when performing code diff in
    VSCode, GitHub, Bitbucket.
4.  Issue with CPL limit - Grep expressions not working across multiple
    lines.
5.  Reading/modifying text files over limited-width terminal (embedded
    system serial port, SSH).
6.  Reading/modifying text in an atypical work environment (eg. on a
    mobile phone via [Markor](https://github.com/gsantner/markor)).
7.  Reading preformatted text in a browser (eg. source files or
    discussion group posts).

### Text File Element Types

What is of interest is that the treatment of text files should not
depend on the text file type per se, but it's on the elements it
consists of. These elements determine the way text is read, the approach
on how it should be laid out, how it is accessed.

Here, the identified text file elements are listed -

|File type  |Element            |Treatment
|---        |---                |---
|Code       |Source code        |Code
|Code       |Comment            |Breakable text
|Document   |Paragraph          |Breakable text
|Document   |Code block         |Code
|Document   |Code block comment |Breakable text
|Document   |Table              |Non-breakable text
|Document   |Hyperlink          |Non-breakable text

Thing worth recapping here is that for a single text file, there may be
different rules, depending on the text file element, eg. document table
may have CPL limit but a document paragraph may have no CPL limit.

### Text Operations

Next what impacts the treatment is the way text is used. In this regard,
the following text operations are identified, as well as the tools that
may be used -

|Operation              |Example tools
|---                    |---
|Navigation             |Vim, Notepad
|Inserting/modifying    |Notepad, VSCode, Vim through terminal
|Reading                |Terminal `less`, browser render, VSCode
|Comparison (diffing)   |VSCode, GitHub/Bitbucket, terminal `diff`
|Searching              |Terminal `grep`

Most appropriate text file element CPL limit depends on the operation,
but also on the tool employed, as well as the environment in which the
tool is used. Eg. diffing with `diff` produces valid result regardless
of CPL limit, where other tools do not have support for diff wrap and
require horizontal scrolling, *except* if they do not use a sufficiently
wide viewport.

This lead further to having a development environment determining, in
combination with CPL limits, feasibility of the given operations.
Development environment would consist out of -

1.  Display(s) size (and orientation together with this).
2.  Viewport size
3.  Text editor:
    1.  Inherent operation model.
    2.  Configuration.
    3.  Reserved viewport space (eg. sidebar, scrollbars, minimap, line
        numbers, diff prefix).

### Contributing Factors

In addition to the operation and text operation environment, there are
some further side factors that may impact the usefulness of imposed CPL
limit rules.

1.  User base size - Single user vs. multiple users (with potentially
    disjunctive development environments).
2.  Tabs vs. spaces and tab indentation value.

## Making a CPL Limit Decision

### Factors

Here's a piled up list of observed factors that may contribute to a
certain CPL limit decision.

1.  Enforcing code writing style through CPL limit:
    1.  More concise variable names.
    2.  Local aliasing.
    3.  Condition nesting.
    4.  Long expressions rework (no sausage expressions).
2.  Cost of adhering to a CPL limit when creating/modifying text:
    1.  Having to break long statements when writing code.
    2.  Having to make document tables fit.
    3.  Switching to an atypical work environment which is not
        configured/tailored to the imposed CPL limit (eg. editing files
        on a mobile phone or Web UI).
3.  Readability:
    1.  Certain document line length range is optimal for reading
        convenience.
    2.  Same holds to a certain degree for code.
    3.  Wrapping of long lines depend on the text editor, and may
        produce unreadable output, eg. document tables or code.
    4.  If wrapping is not applied, then user need to perform horizontal
        scrolling to read the text which breaks the flow. This is esp.
        relevant to diffing. There:
        1.  VSCode, Gitk, GitHub, Bitbucket, TFS do not wrap diff.
        2.  `git diff` wraps diff.
    5.  For CPL limited text, if it is modified it may require
        rewrapping which will introduce modifications to the otherwise
        unmodified text. This may make diffing difficult.
        1.  On the other hand, this is also a case with a long
            non-wrapped line.
    6.  This depends on the indentation style and amount.
4.  Flexibility:
    1.  CPL limit makes text rigid, and not able to adapt to the
        environment at hand (eg. smaller mobile viewport), or
        developer's preferences.
5.  Output reproducibility:
    1.  Specific line length, use of spaces instead of tabs, and no wrap
        results in reproducible output. This ensures that everyone has
        the same representation on the text file.
    2.  Long line wrapping depends on the viewport configuration, and
        may change as the viewport is resized leading to different text
        representation even for the same user.
6.  Ambiguity:
    1.  There's a certain expectation that each text line fits into one
        displayed line. When this is broken due to line wrapping,
        there's a risk that user will interpret wrapped lines as new
        text lines. This may result in the confusion when reading code
        statements, or the interpretation how the markup document file
        will be rendered.
7.  Stimulating certain work environment:
    1.  Lower CPL limit stimulates use of narrower viewport, which
        leaves horizontal space for other windows, or stimulates
        multiple side-by-side viewport use.
8.  Usability:
    1.  If document file paragraphs are not broken, this makes grep
        search for more than a single word queries possible.
    2.  Large CPL limit may prove diffing difficult as the tools usually
        don't wrap text, so horizontal scrolling is needed.
    3.  Text wrapping may impede with normal workflow for some tools
        (eg. Vim jk navigation).
9.  Development environment setup:
    1.  No CPL limit enforcement eases up setup.
    2.  Some environments even cannot be configured for the given CPL
        limit (eg. mobile edit environment).

### Decision Examples

[TODO]

## Glossary

|Term           |Meaning
|---            |---
|Text file      |Non-binary file containing readable text
|Code file      |Text file containing source code
|Document file  |Text file containing plaintext or markup text
|CPL rule       |Requirements on text file line length
|CPL limit      |Allowed number of characters per line
|Text editor    |Tool for editing *or viewing* a text file
|Viewport       |Screen area displaying text file content
|Word wrap      |Text editor ability to break long line to fit viewport

## CPL Limit Examples

|CPL|Note
|---|---
|70 |Oracle's Java Coding Convention - Documentation code examples
|72 |Python PEP 8 - Doctrings or comments
|79 |Python PEP 8 - Maximum
|80 |Punch cards and teletypes
|120|Widely accepted better-than-80CPL limit

## Resources

*   [reddit_linus] : Discussion on Linus' post on line length limit.
*   [baymard_line-length] : Article on optimal length of text line.
*   [nick_80cpl] : Benefits of 80CPL with large monitors.
*   [stack_optimal-width] : (Lack of) info on studies on optimal code
    width.
*   [python_pep8] : Python Coding style guide - line length.
*   [stack_80cpl] : Origin of 80CPL limit.
*   [oracle_java-code-conv] : Oracle's Java Coding Conventions - Check 4.1.

[reddit_linus]: <https://www.reddit.com/r/programming/comments/gt4wgn/linus_torvalds_on_80character_line_limit/>
[baymard_line-length]: <https://baymard.com/blog/line-length-readability>
[nick_80cpl]: <https://nickjanetakis.com/blog/80-characters-per-line-is-a-standard-worth-sticking-to-even-today>
[stack_optimal-width]: <https://stackoverflow.com/questions/578059/studies-on-optimal-code-width>
[python_pep8]: <https://www.python.org/dev/peps/pep-0008/#maximum-line-length>
[stack_80cpl]: <https://softwareengineering.stackexchange.com/questions/148677/why-is-80-characters-the-standard-limit-for-code-width>
[oracle_java-code-conv]: <https://www.oracle.com/technetwork/java/codeconventions-150003.pdf>
