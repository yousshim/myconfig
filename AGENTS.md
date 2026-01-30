This repository hosts all my configurations. It uses gnu stow. Each package is for a different application that I use.

# Structure

.
├── AGENTS.md
├── bash
│   └── .bashrc
├── git
│   └── .config
│       └── git
│           └── config
├── mise
│   └── .config
│       └── mise
│           └── config.toml
├── neovim
│   └── .config
│       └── nvim
│           ├── init.lua
│           ├── lazy-lock.json
│           ├── lsp
│           │   ├── tsserver.lua
│           │   └── zls.lua
│           ├── parser
│           │   ├── tsx.so
│           │   ├── typescript.so
│           │   └── zig.so
│           └── queries
│               ├── ecma
│               │   ├── folds.scm
│               │   ├── highlights.scm
│               │   ├── indents.scm
│               │   ├── injections.scm
│               │   └── locals.scm
│               ├── typescript
│               │   ├── folds.scm
│               │   ├── highlights.scm
│               │   ├── indents.scm
│               │   ├── injections.scm
│               │   └── locals.scm
│               └── zig
│                   ├── folds.scm
│                   ├── highlights.scm
│                   ├── indents.scm
│                   ├── injections.scm
│                   └── locals.scm
├── opencode
│   └── .config
│       └── opencode
│           ├── opencode.jsonc
└── ssh
    └── .ssh
        └── config

# Instructions
* NEVER ADD COMMENTS UNLESS ASKED TO OR ABSOLUTELY NECESSARY
* If you add or remove files make sure to update the structure in the root AGENTS.md
