" unite.vim

let g:unite_force_overwrite_statusline = 0

" Use neomru.vim as ddu source
" https://github.com/Shougo/neomru.vim
function! NeoMruSource()
  return map(neomru#_gather_file_candidates(), { _, path -> #{
        \   word: path,
        \   kind: 'file',
        \   action: #{
        \      path: path,
        \      isDirectory: isdirectory(path),
        \   },
        \ }})
endfunction

nnoremap <SID>[unite] <Nop>
nmap <Space>u <SID>[unite]

"nnoremap <silent> <SID>[unite]b :<C-U>Denite -buffer-name=buffers unite:buffer_tab<CR>
nnoremap <silent> <SID>[unite]b <Cmd>call ddu#start(#{sources: [#{name: 'buffer'}]})<CR>
nnoremap <silent> <SID>[unite]h <Cmd>call ddu#start(#{sources: [#{name: 'help'}]})<CR>
nnoremap <silent> <SID>[unite]u <Cmd>call ddu#start(#{resume: v:true})<CR>

nnoremap <SID>[unite-file] <Nop>
nmap <SID>[unite]f <SID>[unite-file]
nnoremap <silent> <SID>[unite-file]f :<C-U>Unite -buffer-name=files -start-insert file file/new directory/new<CR>
nnoremap <silent> <SID>[unite-file]d :<C-U>UniteWithBufferDir -buffer-name=files -start-insert file file/new directory/new<CR>
nnoremap <silent> <SID>[unite-file]m <Cmd>call ddu#start(#{sources: [#{name: 'vim', params: #{func: 'NeoMruSource'}}]})<CR>
"nnoremap <silent> <SID>[unite-file]b <Cmd>call ddu#start(#{sources: [#{name: 'dirmark'}]})<CR>
nnoremap <silent> <SID>[unite-file]j :<C-U>Unite -buffer-name=files -start-insert junkfile/new junkfile<CR>
