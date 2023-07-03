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
nnoremap <silent> <SID>[unite]b <Cmd>call ddu#start(#{name: 'buffers', sources: [#{name: 'buffer'}]})<CR>
nnoremap <silent> <SID>[unite]h <Cmd>call ddu#start(#{name: 'help', sources: [#{name: 'help'}]})<CR>
nnoremap <silent> <SID>[unite]u <Cmd>call ddu#start(#{resume: v:true})<CR>

nnoremap <SID>[unite-file] <Nop>
nmap <SID>[unite]f <SID>[unite-file]
nnoremap <silent> <SID>[unite-file]f <Cmd>call ddu#start(#{name: 'files', sources: [#{name: 'file'}, #{name: 'file', params: #{new: v:true}, options: #{volatile: v:true}}]})<CR>
nnoremap <silent> <SID>[unite-file]d <Cmd>call ddu#start(#{name: 'files', sources: [#{name: 'file', options: #{path: expand('%:p:h')}}, #{name: 'file', params: #{new: v:true}, options: #{volatile: v:true, path: expand('%:p:h')}}]})<CR>
nnoremap <silent> <SID>[unite-file]m <Cmd>call ddu#start(#{name: 'files', sources: [#{name: 'vim', params: #{func: 'NeoMruSource'}}]})<CR>
"nnoremap <silent> <SID>[unite-file]b <Cmd>call ddu#start(#{sources: [#{name: 'dirmark'}]})<CR>
nnoremap <silent> <SID>[unite-file]j <Cmd>call ddu#start(#{name: 'files', sources: [#{name: 'junkfile', options: #{volatile: v:true}}]})<CR>
