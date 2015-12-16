" filetype.vim

if exists('did_load_filetypes')
    finish
endif

augroup filetypedetect
    autocmd BufRead,BufNewFile *.toml setf toml
    autocmd BufRead,BufNewFile *.swift setf swift
augroup END
