This is a configurable version of the vimscript http://www.vim.org/scripts/script.php?script_id=446 that originally used just jad.

## Original Description:
When you edit a .class file using vim, this plugin will decompile the class file for you and display it in the current buffer.

Admittedly, the buffer management is not very robust, but it's a very handy plugin nonetheless.  How much cooler is it to view decompiled code using your favorite editor than to download a new UI to view Java code in?!

## Installation

Use your plugin manager of choice.

- [Pathogen](https://github.com/tpope/vim-pathogen)
  - `git clone https://github.com/DanManN/vim-razer ~/.vim/bundle/vim-razer`
- [Vundle](https://github.com/gmarik/vundle)
  - Add `Bundle 'https://github.com/DanManN/vim-razer'` to .vimrc
  - Run `:BundleInstall`
- [NeoBundle](https://github.com/Shougo/neobundle.vim)
  - Add `NeoBundle 'https://github.com/DanManN/vim-razer'` to .vimrc
  - Run `:NeoBundleInstall`
- [vim-plug](https://github.com/junegunn/vim-plug)
  - Add `Plug 'https://github.com/DanManN/vim-razer'` to .vimrc
  - Run `:PlugInstall`

Then set `g:javad_cmd` to a command that decompiles a .class file as input. e.g.
```
let g:javad_cmd = 'java -jar <path-to>/cfr.jar' # using cfr
```
or
```
let g:javad_cmd = 'jad -p' # using jad
```
