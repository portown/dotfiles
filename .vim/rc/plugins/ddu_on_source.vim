" ddu_on_source.vim

call ddu#custom#patch_global(#{
    \   ui: 'ff',
    \   sourceOptions: #{
    \       _: #{
    \           matchers: [
    \               'matcher_substring',
    \           ],
    \       },
    \       file: #{
    \           sorters: [
    \               'sorter_file',
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
    \       help: #{
    \           defaultAction: 'open',
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
    \           startFilter: v:false,
    \           statusline: v:false,
    \       },
    \   },
    \})

call ddu#custom#patch_local('help', #{
    \   uiParams: #{
    \       ff: #{
    \           startFilter: v:true,
    \       },
    \   },
    \})

call ddu#custom#patch_local('file', #{
    \   uiParams: #{
    \       ff: #{
    \           startFilter: v:true,
    \       },
    \   },
    \})

autocmd Portown FileType ddu-ff call s:ddu_ff_my_settings()
function! s:ddu_ff_my_settings() abort
    nnoremap <buffer><silent> <CR> <Cmd>call ddu#ui#do_action('itemAction')<CR>
    nnoremap <buffer><silent> <Space> <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
    nnoremap <buffer><silent> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
    nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer><silent> <C-i> <Cmd>call ddu#ui#multi_actions([['chooseAction'], ['openFilterWindow']])<CR>
    nnoremap <buffer><silent> D <Cmd>call ddu#ui#do_action('itemAction', #{name: 'delete'})<CR>
    nnoremap <buffer><silent> N <Cmd>call ddu#ui#do_action('itemAction', #{name: 'newFile'})<CR>
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
