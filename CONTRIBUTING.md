# Contributing

Keep this project small and shell-only unless a feature clearly needs more.

Before opening a pull request:

```bash
bash -n install.sh scripts/*.sh
./install.sh --no-rc --dir ./tmp/test-accounts --count 2
./scripts/status.sh 2
```

Do not add examples that commit real Codex account folders or login state.
