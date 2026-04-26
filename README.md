# Multiple Codex Accounts

Run multiple Codex CLI accounts on the same machine by giving each account its own `CODEX_HOME`.

This is useful when you want separate Codex logins such as `acc1`, `acc2`, `acc3`, and you want to run them in different terminal windows at the same time.

## Install

```bash
git clone https://github.com/iamokko/multiple-codex-accounts.git
cd multiple-codex-accounts
./install.sh
source ~/.zshrc
```

By default, the installer creates:

```text
~/.codex-accounts/acc1
~/.codex-accounts/acc2
~/.codex-accounts/acc3
~/.codex-accounts/acc4
~/.codex-accounts/acc5
```

It also adds these shell helpers:

```bash
codex-acc1
codex-acc2
codex-acc3
codex-acc4
codex-acc5
codex-acc
mca-status
```

## Login

Login each slot once:

```bash
codex-acc1 login
codex-acc2 login
codex-acc3 login
codex-acc4 login
codex-acc5 login
```

Check status:

```bash
mca-status
```

## Run Codex

Open multiple terminals and run different slots:

```bash
codex-acc1
```

```bash
codex-acc2
```

You can also use the generic helper:

```bash
codex-acc 1
codex-acc 2 login
codex-acc 3 exec "explain this repo"
```

## Custom Slot Count

Create 10 account slots instead of 5:

```bash
./install.sh --count 10
source ~/.zshrc
```

Use a custom directory:

```bash
./install.sh --dir "$HOME/dev/codex-accounts"
source ~/.zshrc
```

Use a custom shell rc file:

```bash
./install.sh --rc "$HOME/.bashrc"
source ~/.bashrc
```

Only create directories without editing your shell rc:

```bash
./install.sh --no-rc
```

Then run manually:

```bash
CODEX_HOME="$HOME/.codex-accounts/acc1" codex login
CODEX_HOME="$HOME/.codex-accounts/acc1" codex
```

## Copy Shared Config

If you already have shared Codex config in `~/.codex`, you can copy safe shared files into every account slot:

```bash
./install.sh --copy-shared
```

This copies only:

```text
rules
AGENTS.md
config.toml
skills
memories
automations
```

It does not copy login tokens directly.

## Security

Each account slot can contain Codex login credentials after you run `codex login`. Treat `~/.codex-accounts` as private data.

Do not commit account directories to Git. The installer sets directory permissions to `700`, but you should still avoid syncing these folders to public cloud storage.

## Uninstall Shell Helpers

Remove aliases and functions from your shell rc:

```bash
./scripts/uninstall-shell-helpers.sh
source ~/.zshrc
```

This does not delete account directories.

## How It Works

Codex CLI reads `CODEX_HOME`. By setting a different `CODEX_HOME` per command, each account gets its own login state:

```bash
CODEX_HOME="$HOME/.codex-accounts/acc1" codex
CODEX_HOME="$HOME/.codex-accounts/acc2" codex
```

That means accounts can be used at the same time in separate terminals.
