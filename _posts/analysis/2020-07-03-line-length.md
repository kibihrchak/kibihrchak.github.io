---
title:      "Line Length"
tags:       formatting code line-length wrap
---

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tempus convallis dignissim. Donec rutrum, sem sit amet congue ullamcorper, erat turpis ultricies metus, nec consequat purus massa at est.

## Table of Contents

1.  TOC
{:toc}

## Version History

|Date       |Description
|---        |---
|[TODO]     |Initial version

## Overview

This analysis tries to answer if and when limiting line length for text
files matters, and also what would be the appropriate line length limit.

[TODO]

## Outline

### Types of Text Files

1.  Markdown documents
2.  Source code files

### Use Cases

1.  Text input
2.  Text review
3.  Diffing
4.  Search (grep)

### Platforms

1.  Development environment
2.  Non-dev environment (mobile phone)
3.  Web UI (GitHub, Bitbucket)

### Factors

1.  Wrappability
2.  Breakability
3.  Enforcing writing style through line length
    1.  Concise variable names
    2.  Local aliasing
    3.  Condition nesting
    4.  Long expressions
4.  Output reproducibility - Specific line length and no wrap results in reproducible output (together with spaces instead of tabs)
5.  Readability - Certain line length range optimal for reader
    convenience.
6.  Distinguishing lines - Expectation that each text line fits into one displayed line.
7.  Enforcing certain use style - Fixed line width stimulates multiple
    side views.
8.  Maintenance cost - Breaking statement into multiple lines.

## Resources

*   [reddit_linus-rant] : Discussion on Linus' post on line length
    limit.
*   [baymard_line-length] : Article on optimal length of text line.
*   [njanetakis_80cpl] : Article on 80CPL and side views.

[reddit_linus-rant]: <https://www.reddit.com/r/programming/comments/gt4wgn/linus_torvalds_on_80character_line_limit/>
[baymard_line-length]: <https://baymard.com/blog/line-length-readability>
[njanetakis_80cpl]: <https://nickjanetakis.com/blog/80-characters-per-line-is-a-standard-worth-sticking-to-even-today>
