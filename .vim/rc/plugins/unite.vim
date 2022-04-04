" unite.vim

let g:unite_force_overwrite_statusline = 0

nnoremap <SID>[unite] <Nop>
nmap <Space>u <SID>[unite]

"nnoremap <silent> <SID>[unite]b :<C-U>Denite -buffer-name=buffers unite:buffer_tab<CR>
nnoremap <silent> <SID>[unite]b :<C-U>Denite -buffer-name=buffers buffer<CR>
nnoremap <silent> <SID>[unite]h :<C-U>Denite -buffer-name=help help<CR>
nnoremap <silent> <SID>[unite]o :<C-U>Unite -buffer-name=outline -start-insert outline<CR>
if executable('grep') || executable('pt')
    nnoremap <silent> <SID>[unite]g :<C-U>Unite -buffer-name=grep -no-quit grep:.<CR>
else
    nnoremap <silent> <SID>[unite]g :<C-U>Unite -buffer-name=grep -no-quit vimgrep:**<CR>
endif
nnoremap <silent> <SID>[unite]u :<C-U>UniteResume<CR>
nnoremap <SID>[unite]<Space> :<C-U>Unite 

nnoremap <SID>[unite-file] <Nop>
nmap <SID>[unite]f <SID>[unite-file]
nnoremap <silent> <SID>[unite-file]f :<C-U>Unite -buffer-name=files -start-insert file file/new directory/new<CR>
nnoremap <silent> <SID>[unite-file]d :<C-U>UniteWithBufferDir -buffer-name=files -start-insert file file/new directory/new<CR>
nnoremap <silent> <SID>[unite-file]r :<C-U>Unite -buffer-name=files -start-insert file_rec/git<CR>
nnoremap <silent> <SID>[unite-file]m :<C-U>Denite -buffer-name=files file_mru<CR>
nnoremap <silent> <SID>[unite-file]b :<C-U>Unite -buffer-name=files -start-insert -default-action=lcd bookmark<CR>
nnoremap <silent> <SID>[unite-file]j :<C-U>Unite -buffer-name=files -start-insert junkfile/new junkfile<CR>
