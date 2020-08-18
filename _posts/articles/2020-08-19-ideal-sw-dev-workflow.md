---
title:      "On Ideal Software Development Workflow"
tags:       development process workflow unicorns
---

Is it possible to harness unicorns? But ideally.

## "The Best Part Is No Part"

What got me thinking on this topic was the remark think repeated by Elon
Musk on several occasions, but most notably during [Starship
presentation last
year](https://twitter.com/Erdayastronaut/status/1203840982497792005)
that goes like -

>   The best part is no part. The best process is no process. It weighs
>   nothing. Costs nothing. Can’t go wrong.

Basically, the way I see it is that everything that is shown as
unnecessary will encumber either the development process or the product,
and the product in the subsequent use.

What is of interest here is the hidden cost in the development process
itself. As an end user, you can point at the product and state that this
or that may not be needed, but there's that background effort invested
in realizing the product, which may have had its own "extra" unused
parts, removal of which could lead to faster development, better devised
product or just less burn out.

## Ideal Software Development Workflow 🦄

The question that comes here is, how to reach this ideal development
process? The common approach is minimization of most notable waste, eg.
what [Minifesto](http://minifesto.org/) proclaims. Other approach would
be to go from the idealistic development workflow, however unlike may it
seemed, then identify possible violations of it in the context of
current project and then select strategies or the workflow enhancements
to mitigate these violations.

How would that look like? Ideal workflow eg. would be to:

1.  Collect requirements in full, without any ambiguities, conflicts or
    omissions.
2.  Based on these requirements and preexisting knowledge, a complete
    design of a system is devised, and pre-existing
    tools/libraries/frameworks are selected so that they enhance
    development and remove work duplication to the full.
3.  In line with the product design, a support infrastructure for
    development is identified, and a development infrastructure is set
    up so that there is no need for further enhancements or changes.
4.  Based on the given design, necessary missing software components are
    created.
5.  Newly created code is seamlessly and without conflicts integrated
    with pre-existing software components.
6.  Resulting software product is then integrated in the operation
    environment without conflicts and issues.
7.  Work done. Profit.

What may seem is that the given outline looks too naive. And, for the
majority of the projects it is. But, the core assumption holds, that *if
there are no violations to it, it would work*. This is also relevant for
the steps perceived as omitted, like maintenance. If the product is
ideal, it would not require maintenance.

## Dealing with Complexity

Onto the violations. What happens here is that due to the unaccounted
factors it is possible that the given ideal workflow will not satisfy
the project development needs. It may be due to the changing or
incomplete requirements, understanding of the system, lack of
preexisting knowledge in domain, or regarding the suitable
tools/frameworks/libraries. It may be due to the distributed nature of
development, where the synchronization issues between team members
appear.

Whatever the reason, the idea is to see these factors as something that
the ideal development workflow is not prepared to address, and
mitigation strategies should be added to it in order to do so. Eg. in
case of a possibility of having incomplete requirements, mitigation
mechanisms could be creating the problem domain model and testing the
requirements on it, or creating a mock-up product for asserting the
requirements. In case of possible integration issues, interface
specification and incremental development may be the solution.

The main idea behind this is to make *all ideal development workflow
violations visible*, and to state mitigation strategies explicitly. This
way ideal workflow in combination with mitigation strategies becomes *a
verifiable minimal development workflow* based on the current
understanding of the project.

As a side benefit, purpose of development workflow tools/processes
becomes apparent with this, and they will not be seen as an externally
imposed hurdle. Also, this allows for building a certain "repository",
or toolkit of useful tools to be applied in particular development
scenarios.

## What About Real-World Application?

The final question is the applicability of this thought out approach?
Even Musk may say "The best process is no process", but the feasibility
of keeping true to that word is what matters. Guess that the best way to
achieve it is:

1.  To have an extensive knowledge of tools at disposal (toolkit).
2.  Do not over-anticipate the issues, but develop the mitigation on
    fly.

Further than that, useful real-world experience examples would be
beneficial.
