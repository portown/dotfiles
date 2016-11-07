" unite_on_source.vim

let g:unite_enable_start_insert = 0
let g:unite_kind_file_use_trashbox = 0

let g:unite_source_process_enable_confirm = 0

call unite#custom#source('file_rec,file_rec/async,grep,neomru/file', 'ignore_pattern',
            \   '\%(^\|/\)\.$'
            \   . '\|\~$'
            \   . '\|\.\%(o\|exe\|dll\|bak\|DS_Store\|zwc\|pyc\|sw[po]\|class\|jar\|png\|gif\|jpe\?g\|fugitiveblame\)$'
            \   . '\|\%(^\|/\)\%(\.hg\|\.git\|\.bzr\|\.svn\|tags\%(-.*\)\?\)\%($\|/\)'
            \   . '\|^gita://')
call unite#custom#source('file/async,file_rec,file_rec/async,file_rec/git', 'syntax', 'uniteSource__File')
call unite#custom#source('file_rec,file_rec/async,file_rec/git', 'matchers', 'matcher_file_name')

if executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup -e'
    let g:unite_source_grep_recursive_opt = ''
else
    let g:unite_source_grep_default_opts = '-Hn'
    let g:unite_source_grep_recursive_opt = '-r'
endif

if !exists('g:unite_source_alias_aliases')
    let g:unite_source_alias_aliases = {}
endif
let g:unite_source_alias_aliases.message = {
            \   'source': 'output',
            \   'args': 'message',
            \ }
call unite#custom#source('message', 'sorters', 'sorter_reverse')
