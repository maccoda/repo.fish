# repo.fish

A fish shell plugin that provides a suite of common tasks when working on a git
repository (namely in the pull request and mainline development model).

This tool is fairly coupled with GitHub as it currently exists but several of
the commands just operate on git independently.

## Install

Install using Fisher:

```console
fisher install maccoda/repo.fish
```

## Commands

### repo cd

Used for a monorepo to easily switch between projects. It assumes these all live
under a `projects` directory

### repo diff

Allows for a quick diff against useful presets like a tag or main branch

### repo feature

Creates a new feature branch to work on, pulling in the latest changes on the
main branch before doing so. It also has the option of creating the branch from
the current branch with `--from-current`

### repo log

Interactive search through the history log of the repository

### repo main

Switch to the main branch and fetch latest changes

### repo merge

Merge a particular branch into the current branch

### repo prune_branches

Prune merged branches

### repo rebase

Rebase the current branch onto a particular branch

### repo setup

Initialisation within a repo

### repo switch

Switch to a local or remote branch

### repo pr-co

Checkout a pull request currently on GitHub

## Dependencies

- `fzf`
- `gh`

## Configuration

`_repo_log_cmd` - set the command that is used when printing a git log. It is the command following `git` allowing you to use a git alias

## Future ideas

- Allow users to register their own hooks for things like repo setup
- Support other hosted git platforms
