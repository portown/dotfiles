" neosnippet.vim

imap <C-K> <Plug>(neosnippet_expand)
smap <C-K> <Plug>(neosnippet_expand)
xmap <C-K> <Plug>(neosnippet_expand_target)

imap <expr><Tab> neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_jump)"
            \: pumvisible() ? "\<C-N>" : "\<Tab>"
smap <expr><Tab> neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_jump)"
            \: "\<Tab>"

if has('conceal')
    set conceallevel=2
    set concealcursor=i
endif

if !exists('g:neosnippet#snippets_directory')
    let g:neosnippet#snippets_directory = ''
endif
let g:neosnippet#snippets_directory = join([
            \   '~/.vim/snippets',
            \ ], ',')

if !exists('g:neosnippet#disable_runtime_snippets')
    let g:neosnippet#disable_runtime_snippets = {}
endif
let g:neosnippet#disable_runtime_snippets._ = 1
