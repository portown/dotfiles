" ddu_on_source.vim

call ddu#custom#patch_global(#{
    \   ui: 'ff',
    \   sourceOptions: #{
    \       _: #{
    \           matchers: [
    \               'matcher_substring',
    \           ],
    \       },
    \   },
    \   kindOptions: #{
    \       file: #{
    \           defaultAction: 'open',
    \       },
    \       action: #{
    \           defaultAction: 'do',
    \       },
    \   },
    \   filterParams: #{
    \   },
    \   uiParams: #{
    \       ff: #{
    \           filterSplitDirection: 'botright',
    \           prompt: '> ',
    \           split: 'horizontal',
    \           splitDirection: 'botright',
    \           startFilter: v:true,
    \           statusline: v:false,
    \       },
    \   },
    \})

autocmd Portown FileType ddu-ff call s:ddu_ff_my_settings()
function! s:ddu_ff_my_settings() abort
    nnoremap <buffer><silent> <CR> <Cmd>call ddu#ui#do_action('itemAction')<CR>
    nnoremap <buffer><silent> <Space> <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
    nnoremap <buffer><silent> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
    nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer><silent> <C-i> <Cmd>call ddu#ui#do_action('chooseAction')<CR>
    setlocal cursorline
endfunction

autocmd Portown FileType ddu-ff-filter call s:ddu_ff_filter_my_settings()
function! s:ddu_ff_filter_my_settings() abort
    "nnoremap <buffer><silent> <CR> <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
    inoremap <buffer><silent> <CR> <Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
    "nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
    inoremap <buffer><silent> <Esc> <C-u><Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>
    "inoremap <buffer><silent> <C-p> <Cmd>call ddu#ui#do_action('cursorPrevious')<CR>
    "inoremap <buffer><silent> <C-n> <Cmd>call ddu#ui#do_action('cursorNext')<CR>
endfunction
