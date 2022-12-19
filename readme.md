go-cmd.vim is a minimalist vim script wrapper for
[the `go` command](https://pkg.go.dev/cmd/go).
It provides one command `:Go` with command-line completions, and the
command results are collected in the quickfix list.


## Installation

The minimum recommended version is Neovim 0.2.0 or Vim 7.4.2044.
The plugin will fallback to synchronous blocking mode on older versions.

Use your preferred package manager to install this script and its only
dependency, [asyncrun.vim](https://github.com/skywind3000/asyncrun.vim).

### vim-plug

Below is a sample using [vim-plug](https://github.com/junegunn/vim-plug):

    Plug 'skywind3000/asyncrun.vim'
    Plug 'arnie97/go-cmd.vim'

    let g:asyncrun_open = 2  " open quickfix automatically (optional)
    set wildmenu             " show the completion menu (optional)

Or leverage the built-in package loader:

### Neovim

    $ git clone https://github.com/skywind3000/asyncrun.vim \
        ~/.local/share/nvim/site/pack/plugins/start/asyncrun.vim

    $ git clone https://github.com/arnie97/go-cmd.vim \
        ~/.local/share/nvim/site/pack/plugins/start/go-cmd.vim

### Vim 8+

    $ git clone https://github.com/skywind3000/asyncrun.vim \
        ~/.vim/pack/plugins/start/asyncrun.vim

    $ git clone https://github.com/arnie97/go-cmd.vim \
        ~/.vim/pack/plugins/start/go-cmd.vim


## FAQ

### Why not vim-go?

I've been a long time [vim-go](https://github.com/fatih/vim-go) user.
It's an all-in-one solution which steps overs the boundaries defined by
the language server protocol and provides a lot of otherwise language-
agnostic components, e.g. LSP client, linter, and code completion.
Therefore it often conflicts with native Neovim features (LSP, DAP,
tree-sitter) or third-party plugins (ALE, COC), which generally works
better and provides a more consistent experience across file types.

After disabling the most functionalities in vim-go, I felt that the
`:Go*` commands were the only part that still in use, so I wrote this
plugin to provide better completions for them.


### Why not `:make` or `:!go`?

Unfortunately these approaches lack support for asynchronous execution
and sub-command completion.  I would definitely go back to `&makeprg`
again if these pain points are resolved natively in the future.


## Credits

The plugin design was inspired by the `:Git` or `:G` command provided by
[vim-fugitive](https://github.com/tpope/vim-fugitive).


## License

This software is released into the public domain.
