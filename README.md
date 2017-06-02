# Auriel

_A simple CLI for managing AUR packages._

Auriel manages your AUR packages using a git repo, in `~/.auriel/repo`.
If you want to synchronize your Auriel repo, you can add a remote to the git
repo and push/pull it. TODO: add commands for managing this

## Commands

### `$ auriel add <name/URL...>`

Adds the given AUR package(s) to your system _without_ installing it.

### `$ auriel install <name/URL..>`

Adds and installs the given AUR package(s) to your system.
If the package has already been added to your system, it will be updated before
installing.
If the package has already been installed, it will be overwritten.

### `$ auriel update [name/URL...]`

Updates the given AUR package(s), but does not install the updated package(s).

### `$ auriel upgrade [name/URL...]`

Updates the given AUR package(s), and installs them to your system.

### `$ auriel remove <name/URL...>`

Removes the given AUR package(s), both from your system (if installed), and the
auriel repository.

### `$ auriel remote (add|remove) <name> <remote>`

Configures a git remote on the auriel repository. Everything after 
`auriel remote` is passed directly to `git remote`, so all `git remote` options
are valid.

### `$ auriel push [--force] [remote]`

Pushes the auriel repository to the named remote, or "origin", if none is
explicitly given.

### `$ auriel pull [remote]`

Pulls the auriel repository from the named remove, or "origin", if none is
explicitly given.

