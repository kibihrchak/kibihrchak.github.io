# Kibihrchak's Best Webpage

Hello! This is a repo for my blog. You can check it out on
<https://kibihrchak.github.io/>.

# Writing Articles Setup

The repo is set up to be used with [VS Code Remote -
Containers](https://code.visualstudio.com/docs/remote/containers) setup.
For that reason there's a [`.devcontainer`](.devcontainer) directory
containing the VS Code Remote - Containers setup.

In order to use it,

1.  Have the following installed:
    1.  [Docker](https://www.docker.com/)
    2.  [VS Code](https://code.visualstudio.com/)
    3.  [VS Code Remote - Containers
        extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2.  Rebuild the container.
3.  Open repo in the container.
4.  Profit.

# Blog Organization

Check for categories in [Jekyll config file](_config.yml). Currently,
they are defined as single-level subdirs of `_posts` and they are:

*   Analysis - Why something is the way it is.
*   Articles - General rant.
*   Guides - How to make something work.
