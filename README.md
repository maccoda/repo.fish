# repo.fish

A fish shell plugin that provides a suite of common tasks when working on a git
repository (namely in the pull request and mainline development model).

This tool is fairly coupled with GitHub as it currently exists but several of
the commands just operate on git independently.

## Installation

Install using Fisher:

```console
fisher install maccoda/repo.fish
```

## Commands

### Change project directory

Used for a monorepo to easily switch between projects. It assumes these all live
under a `projects` directory.

The options will be presented in `fzf` with an added option of `..` which will
return you to the root of the repository.

```console
> repo cd
client
server
..
```

### Compare changes to tags or main branch

Allows for a quick diff against useful presets like a **tag** or **main** branch

```console
> repo diff main
```

### Create a new feature branch

Creates a new feature branch to work on, pulling in the latest changes on the
main branch before doing so. It also has the option of creating the branch from
the current branch with `--from-current`

```console
> repo feature <branch name>
```

### Search log

Interactive search through the history log of the repository

```console
> repo log
```

### Switch to the main branch

Switch to the main branch and fetch latest changes. It will manage local changes
via a stash if present.

```console
> repo main
```

### Merge branch in

Merge a particular branch into the current branch, it will generate
completions based on local branches

```console
> repo merge <branch>
```

### Clean up local branches

Prune branches that have already been merged and deleted in the upstream origin.
These can be forced with `--force`

```console
> repo prune-branches
```

### Rebase onto a branch

Rebase the current branch onto a particular branch

```console
> repo rebase <branch>
```

### Initialise a repository

Initialisation within a repository with a custom hook. Define a hook as a
function called `_repo_init_hook` which if found will be executed.

```console
> repo init
```

### Switch branches

Switch to a local or remote branch

```console
> repo switch
```

### Check out pull request

Checkout a pull request currently on GitHub

```console
> repo co-pr
```

## Dependencies

- `fzf`
- `gh`

## Configuration

`_repo_log_cmd` - set the command that is used when printing a git log. It is the command following `git` allowing you to use a git alias

## Future ideas

- Support other hosted git platforms
