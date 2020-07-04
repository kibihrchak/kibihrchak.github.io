---
title:      "Line Length Limit"
tags:       formatting code line-length wrap
---

```
1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...100..105..110..115..120..125..130..135..140
|...|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|....|
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tempus convallis dignissim. Donec rutrum, sem sit amet congue ullamcorper,
erat turpis ultricies metus, nec consequat purus massa at est.
```

## Table of Contents

1.  TOC
{:toc}

## Version History

|Date       |Description
|---        |---
|[TODO]     |Initial version

## Overview

This analysis tries to answer if and when limiting line length for text
files matters, and also in that context, what would be the appropriate
line length limit.

While looking along the Internets, what usually appeared are the
personal opinions heavily related to the implied use case and the
development environment at hand. This analysis tries to stay impartial
(even with my obvious preference toward 72CPL) and build up on the use
cases and corresponding factors that would make certain approach more
suitable.

## General Context on The Issue

|Term           |Meaning
|---            |---
|Text file      |Non-binary file containing readable text
|Code file      |Text file containing source code
|Document file  |Text file containing plaintext or markup text
|CPL limit      |Allowed characters per line
|Text editor    |Tool for viewing/editing text file
|Viewport       |Screen area displaying text file content
|Word wrap      |Text viewer ability to break long line to fit viewport

## Common Use Cases

Here's the list of assumed common use cases where the topic of CPL
appears -

1.  Optimal CPL when writing code in a single-window IDE.
2.  Optimal CPL when writing code and having to reference some other
    location in source tree, in a multi side-by-side viewport setup.
3.  Not being able to wrap long lines when performing code diff in
    VSCode, GitHub, Bitbucket.
4.  Issue with CPL limit - Grep expressions not working across multiple
    lines.
5.  Reading/modifying text files over limited-width terminal (embedded
    system serial port, SSH).
6.  Reading/modifying text in an atypical work environment (eg. on
    mobile phone via [Markor](https://github.com/gsantner/markor)).

## Problem Domain Analysis

### Text File Element Types

What is of interest is that the treatment of text files should not
depend on the text file type per se, but it's on the elements it
consists of. These elements determine the way text is read, the approach
on how it should be laid out, how it is accessed.

Here, the following elements are distinguishable -

|File type  |Element            |Treatment
|---        |---                |---
|Code       |Source code        |Code
|Code       |Comment            |Breakable text
|Document   |Paragraph          |Breakable text
|Document   |Code block         |Code
|Document   |Code block comment |Breakable text
|Document   |Table              |Non-breakable text
|Document   |Hyperlink          |Non-breakable text

### Text Operations

Next what impacts the treatment is the way text is used. In this regard,
the following text operations are identified -

1.  Inserting/modifying
2.  Reading
3.  Diffing
4.  Searching (grep)

### Text Operations Environment

As for the environments, here are the relevant factors:

1.  Display(s) size (and orientation together with this).
2.  Text editor:
    1.  Text navigation/editing (eg. cursor + direct input vs. Vi
        approach).
    2.  Wrapping implementation for different text elements.
    3.  Viewport size limitations (eg. serial port terminal).

Some environment examples are:

1.  Desktop multi-monitor widescreen setup
2.  Laptop single monitor widescreen setup
2.  Non-dev environment:
    1.  Mobile phone
    2.  Web UI (GitHub, Bitbucket, TFS)

Related environmental factors are:

1.  User base size - Single user vs. multiple users (with potentially
    disjunctive development environments).
2.  Tabs vs. spaces and tab indentation value.

## CPL Limit Evaluation

### Contributing Factors

Now, what comes is the list of identified factors which impacts CPL
limit decision, together with intended operations and the environment.

1.  Enforcing code writing style through CPL limit:
    1.  Concise variable names.
    2.  Local aliasing.
    3.  Condition nesting.
    4.  Long expressions rework.
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
        produce unreadable output (eg. for code, or document tables).
    4.  If wrapping is not applied, then user need to perform horizontal
        scrolling to read the text which breaks the flow. This is esp.
        relevant to diffing.
    5.  For wrapped text, if it is modified it may require rewrapping
        which will introduce modifications to the otherwise unmodified
        text. This may make diffing difficult.
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

### Decision Examples

[TODO]

## Resources

*   [reddit_linus-rant] : Discussion on Linus' post on line length
    limit.
*   [baymard_line-length] : Article on optimal length of text line.
*   [njanetakis_80cpl] : Article on 80CPL and side views.

[reddit_linus-rant]: <https://www.reddit.com/r/programming/comments/gt4wgn/linus_torvalds_on_80character_line_limit/>
[baymard_line-length]: <https://baymard.com/blog/line-length-readability>
[njanetakis_80cpl]: <https://nickjanetakis.com/blog/80-characters-per-line-is-a-standard-worth-sticking-to-even-today>
