" deoplete.vim

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
            \       'smart_case': v:true,
            \       'keyword_patterns': {
            \           '_': '[a-zA-Z_]\k*\(?',
            \       },
            \   })
call deoplete#custom#source('_', 'min_pattern_length', 3)

set completeopt+=noinsert

inoremap <expr><C-F> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-B> pumvisible() ? "\<PageUp>" : "\<Left>"
inoremap <expr><C-Y> pumvisible() ? deoplete#close_popup() : "\<C-R>\""
inoremap <expr><C-E> pumvisible() ? deoplete#cancel_popup() : "\<End>"
inoremap <expr><C-N> pumvisible() ? "\<C-N>" : deoplete#manual_complete()
inoremap <expr><C-P> pumvisible() ? "\<C-P>" : deoplete#manual_complete()

inoremap <expr><C-G> deoplete#undo_completion()

if has('vimscript-3')
    imap <expr><CR> deoplete#smart_close_popup() .. lexima#expand('<CR>', 'i')
else
    imap <expr><CR> deoplete#smart_close_popup() . lexima#expand('<CR>', 'i')
endif
