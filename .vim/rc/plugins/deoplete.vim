" deoplete.vim

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 3

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'

set completeopt+=noinsert

inoremap <expr><C-F> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-B> pumvisible() ? "\<PageUp>" : "\<Left>"
inoremap <expr><C-Y> pumvisible() ? deoplete#close_popup() : "\<C-R>\""
inoremap <expr><C-E> pumvisible() ? deoplete#cancel_popup() : "\<End>"
inoremap <expr><C-N> pumvisible() ? "\<C-N>" : deoplete#manual_complete()
inoremap <expr><C-P> pumvisible() ? "\<C-P>" : deoplete#manual_complete()

inoremap <expr><C-G> deoplete#undo_completion()

imap <expr><CR> deoplete#smart_close_popup() . lexima#expand('<CR>', 'i')
