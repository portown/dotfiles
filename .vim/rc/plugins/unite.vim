" unite.vim

nnoremap <SID>[unite] <Nop>
nmap <Space>u <SID>[unite]

nnoremap <silent> <SID>[unite]b :<C-U>Unite -buffer-name=buffers -start-insert buffer_tab<CR>
nnoremap <silent> <SID>[unite]B :<C-U>Unite -buffer-name=buffers -start-insert buffer<CR>
nnoremap <silent> <SID>[unite]h :<C-U>Unite -buffer-name=help -start-insert -immediately -no-empty help<CR>
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
nnoremap <silent> <SID>[unite-file]m :<C-U>Unite -buffer-name=files -start-insert neomru/file<CR>
nnoremap <silent> <SID>[unite-file]b :<C-U>Unite -buffer-name=files -start-insert -default-action=lcd bookmark<CR>
nnoremap <silent> <SID>[unite-file]j :<C-U>Unite -buffer-name=files -start-insert junkfile/new junkfile<CR>

nnoremap <SID>[unite-gtags] <Nop>
nmap <SID>[unite]t <SID>[unite-gtags]
nnoremap <silent> <SID>[unite-gtags]r :<C-U>Unite -immediately -no-quit -keep-focus -winheight=10 gtags/ref<CR>
nnoremap <silent> <C-]> :<C-U>Unite -immediately -no-quit -keep-focus -winheight=10 gtags/context<CR>

function! PortownBuild(...)
    let clean = a:0 >= 1 ? a:1 : 0

    let base = 'Unite -buffer-name=build -winheight=8 -direction=botright -no-quit -no-focus build'

    let builder = ''
    if exists('b:portown_build_builder')
        let builder = b:portown_build_builder
    endif

    let args = []
    if exists('b:portown_build_args')
        let args = split(b:portown_build_args)
    endif

    if clean
        if exists('b:portown_build_clean_args')
            let args = add(args, split(args.b:portown_build_clean_args))
        else
            let args = add(args, 'clean')
        endif
    endif

    execute join([base, builder, join(args, '\\ ')], ':')
endfunction

" build の b は buffer と被る……
nnoremap <SID>[unite-make] <Nop>
nmap <SID>[unite]m <SID>[unite-make]
nnoremap <silent> <SID>[unite-make]m :<C-U>call PortownBuild()<CR>
nnoremap <silent> <SID>[unite-make]c :<C-U>call PortownBuild(1)<CR>
nnoremap <silent> <SID>[unite-make]q :<C-U>UniteClose build<CR>

nnoremap <SID>[unite-history] <Nop>
nmap <SID>[unite]i <SID>[unite-history]
nnoremap <silent> <SID>[unite-history]c :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/command<CR>
xnoremap <silent> <SID>[unite-history]c :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/command<CR>
nnoremap <silent> <SID>[unite-history]s :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/search<CR>
xnoremap <silent> <SID>[unite-history]s :<C-U>Unite -buffer-name=commands -winheight=8 -direction=botright history/search<CR>
