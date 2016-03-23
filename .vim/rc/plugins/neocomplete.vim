" neocomplete.vim

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#auto_completion_start_length = 3
let g:neocomplete#manual_completion_start_length = 0
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_refresh_always = 0

let g:neocomplete#sources#dictionary#dictionaries = {
            \   'default': '',
            \   'vimshell': $HOME.'/.vimshell/command-history',
            \ }

let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#enable_auto_close_preview = 1

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

let g:neocomplete#force_overwrite_completefunc = 1
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let s:omni_c = '[^.[:digit:] *\t]\%(\.\|->\)'
let s:omni_cpp = s:omni_c.'\|\h\w*::'
let s:omni_objc_specific = '\[\|\[[^.[:digit:] *\t]* \|\] '
let g:neocomplete#force_omni_input_patterns.objc = s:omni_c . '\|' . s:omni_objc_specific
let g:neocomplete#force_omni_input_patterns.objcpp = s:omni_cpp . '\|' . s:omni_objc_specific
unlet s:omni_c s:omni_cpp s:omni_objc_specific

if !exists('g:neocomplete#sources#file_include#exts')
    let g:neocomplete#sources#file_include#exts = {}
endif
let g:neocomplete#sources#file_include#exts.objc = ['h']

if !exists('g:neocomplete#sources#include#patterns')
    let g:neocomplete#sources#include#patterns = {}
endif
let g:neocomplete#sources#include#patterns.objc = '^\s*#\s*import'
let g:neocomplete#sources#include#patterns.objcpp = '^\s*#\s*import'

let g:neocomplete#sources#vim#complete_functions = {
            \   'Ref': 'ref#complete',
            \   'Unite': 'unite#complete_source',
            \   'VimShellExecute': 'vimshell#vimshell_execute_complete',
            \   'VimShellInteractive': 'vimshell#vimshell_execute_complete',
            \   'VimShellTerminal': 'vimshell#vimshell_execute_complete',
            \   'VimShell': 'vimshell#complete',
            \   'VimFiler': 'vimfiler#complete',
            \ }

inoremap <expr><C-F> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-B> pumvisible() ? "\<PageUp>" : "\<Left>"
inoremap <expr><C-Y> pumvisible() ? neocomplete#close_popup() : "\<C-R>\""
inoremap <expr><C-E> pumvisible() ? neocomplete#cancel_popup() : "\<End>"
imap <expr><C-H> neocomplete#smart_close_popup() . "\<Plug>(smartinput_C-H)"
inoremap <expr><C-N> pumvisible() ? "\<C-N>" : "\<C-X>\<C-U>\<C-P>\<Down>"
inoremap <expr><C-P> pumvisible() ? "\<C-P>" : "\<C-P>\<C-N>"

inoremap <expr><C-G> neocomplete#undo_completion()
inoremap <expr><C-L> neocomplete#complete_common_string()

imap <expr><CR> neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"
