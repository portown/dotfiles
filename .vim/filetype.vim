" filetype.vim

if exists('did_load_filetypes')
    finish
endif

augroup filetypedetect
    autocmd BufRead,BufNewFile *.toml setf toml
    autocmd BufRead,BufNewFile *.swift setf swift
    autocmd BufRead,BufNewFile *.gradle setf groovy
    autocmd BufRead,BufNewFile SConstruct setf scons
    autocmd BufRead,BufNewFile *.ebnf setf ebnf
    autocmd BufRead,BufNewFile *.ts setf typescript
    autocmd BufRead,BufNewFile *.kt setf kotlin
    autocmd BufRead,BufNewFile *.kts setf kotlin
augroup END
