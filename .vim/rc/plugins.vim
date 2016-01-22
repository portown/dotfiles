" plugins.vim

if neobundle#tap('lightline.vim') "{{{
    let g:lightline = {
                \   'colorscheme': 'wombat',
                \   'active': {
                \     'left': [['mode'], ['fugitive', 'filename']],
                \     'right': [['syntastic', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype']],
                \   },
                \   'inactive': {
                \     'left': [['filename']],
                \     'right': [['fileformat', 'fileencoding', 'filetype']],
                \   },
                \   'tabline': {
                \     'left': [['tabs']],
                \     'right': [['cwd']],
                \   },
                \   'component': {
                \     'lineinfo': '%3l/%{line("$")}:%-2v',
                \   },
                \   'component_function': {
                \     'fugitive': 'MyFugitive',
                \     'filename': 'MyFilename',
                \     'fileformat': 'MyFileformat',
                \     'filetype': 'MyFiletype',
                \     'fileencoding': 'MyFileencoding',
                \     'mode': 'MyMode',
                \     'cwd': 'MyCwd',
                \   },
                \   'component_expand': {
                \     'syntastic': 'SyntasticStatuslineFlag',
                \   },
                \   'component_type': {
                \     'syntastic': 'error',
                \   },
                \   'separator': { 'left': "\u2b80", 'right': "\u2b82" },
                \   'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
                \ }

    function! MyFugitive()
        if &filetype !~? 'unite\|vimfiler' && exists("*fugitive#head")
            let _ = fugitive#head()
            return strlen(_) ? "\u2b60 "._ : ''
        endif
        return ''
    endfunction

    function! MyModified()
        if &modifiable && &modified
            return '+'
        else
            return ''
        endif
    endfunction

    function! MyReadonly()
        if &modifiable && &readonly
            return "\u2b64"
        else
            return ''
        endif
    endfunction

    function! MyModifiable()
        return &modifiable ? '' : "\u2718"
    endfunction

    function! MyFilename()
        return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                    \ (&ft ==# 'vimfiler' ? vimfiler#get_status_string() :
                    \  &ft ==# 'unite' ? unite#get_status_string() :
                    \  &ft ==# 'vimshell' ? vimshell#get_status_string() :
                    \  '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                    \ ('' != MyModified() ? ' ' . MyModified() : '') .
                    \ ('' != MyModifiable() ? ' ' . MyModifiable() : '')
    endfunction

    function! MyFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! MyFiletype()
        return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction

    function! MyFileencoding()
        return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! MyMode()
        return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction

    function! MyCwd()
        return fnamemodify(getcwd(), ':~')
    endfunction

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-smartinput') "{{{
    function! neobundle#hooks.on_source(bundle)
        call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)', '<CR>', '<CR>')
        call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-H)', '<BS>', '<C-H>')

        " for m4
        call smartinput#define_rule({
                    \   'at': '\%#',
                    \   'char': '`',
                    \   'input': "`'<Left>",
                    \   'filetype': ['m4'],
                    \ })
        call smartinput#define_rule({
                    \   'at': "`\%#'",
                    \   'char': "'",
                    \   'input': '<Right>',
                    \   'filetype': ['m4'],
                    \ })
        call smartinput#define_rule({
                    \   'at': "`\%#'",
                    \   'char': '<BS>',
                    \   'input': '<Del><BS>',
                    \   'filetype': ['m4'],
                    \ })
    endfunction

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim2hs') "{{{
    let g:haskell_conceal = 0

    call neobundle#untap()
endif "}}}

if has('lua') && neobundle#tap('neocomplete') "{{{
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

    call neobundle#untap()
endif "}}}

if has('nvim') && neobundle#tap('deoplete.nvim') "{{{
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#auto_completion_start_length = 3

    if !exists('g:deoplete#keyword_patterns')
        let g:deoplete#keyword_patterns = {}
    endif
    let g:deoplete#keyword_patterns._ = '\h\w*'

    inoremap <expr><C-F> pumvisible() ? "\<PageDown>" : "\<Right>"
    inoremap <expr><C-B> pumvisible() ? "\<PageUp>" : "\<Left>"
    inoremap <expr><C-Y> pumvisible() ? deoplete#mappings#close_popup() : "\<C-R>\""
    inoremap <expr><C-E> pumvisible() ? deoplete#mappings#cancel_popup() : "\<End>"
    imap <expr><C-H> deoplete#mappings#smart_close_popup() . "\<Plug>(smartinput_C-H)"
    inoremap <expr><C-N> pumvisible() ? "\<C-N>" : "\<C-X>\<C-U>\<C-P>\<Down>"
    inoremap <expr><C-P> pumvisible() ? "\<C-P>" : "\<C-P>\<C-N>"

    inoremap <expr><C-G> deoplete#mappings#undo_completion()

    imap <expr><CR> deoplete#mappings#smart_close_popup() . "\<Plug>(smartinput_CR)"

    call neobundle#untap()
endif "}}}

if neobundle#tap('clang_complete') "{{{
    let g:clang_complete_auto = 0
    let g:clang_auto_select = 0

    call neobundle#untap()
endif "}}}

if neobundle#tap('neosnippet') "{{{
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

    call neobundle#untap()
endif "}}}

if neobundle#tap('vimshell') "{{{
    function! neobundle#hooks.on_source(bundle)
        if IsWindows()
            let g:vimshell_prompt = $USERNAME.'@'.hostname().'$ '
        else
            let g:vimshell_prompt = $USER.'$ '
        endif
    endfunction

    command! PortownVimShellSplit :topleft 10split

    nnoremap <SID>[vimshell] <Nop>
    nmap <Space>s <SID>[vimshell]
    nnoremap <silent> <SID>[vimshell]s :<C-U>VimShellCurrentDir -buffer-name=shell -toggle -split -split-command=PortownVimShellSplit<CR>
    nnoremap <silent> <SID>[vimshell]f :<C-U>VimShellCurrentDir -buffer-name=shell<CR>

    autocmd Portown FileType vimshell execute 'nunmap <buffer> <C-N>' | nunmap <buffer> <C-P>

    call neobundle#untap()
endif "}}}

if neobundle#tap('vimfiler') "{{{
    function! neobundle#hooks.on_source(bundle)
        let g:vimfiler_force_overwrite_statusline = 0
    endfunction

    nnoremap <SID>[vimfiler] <Nop>
    nmap <Space>f <SID>[vimfiler]
    nnoremap <silent> <SID>[vimfiler]e :<C-U>VimFilerBufferDir -buffer-name=explorer -direction=topleft -toggle -split -simple -winwidth=35 -no-quit<CR>
    nnoremap <silent> <SID>[vimfiler]f :<C-U>VimFilerBufferDir -buffer-name=explorer<CR>
    nnoremap <silent> <SID>[vimfiler]d :<C-U>VimFilerBufferDir -double<CR>

    call neobundle#untap()
endif "}}}

if neobundle#tap('unite.vim') "{{{
    function! neobundle#hooks.on_source(bundle)
        let g:unite_enable_start_insert = 0
        let g:unite_kind_file_use_trashbox = 0

        let g:unite_force_overwrite_statusline = 0

        let g:unite_source_process_enable_confirm = 0

        call unite#custom#source('file_rec,file_rec/async,grep,neomru/file', 'ignore_pattern',
                    \   '\%(^\|/\)\.$'
                    \   . '\|\~$'
                    \   . '\|\.\%(o\|exe\|dll\|bak\|DS_Store\|zwc\|pyc\|sw[po]\|class\|jar\|png\|gif\|jpe\?g\|fugitiveblame\)$'
                    \   . '\|\%(^\|/\)\%(\.hg\|\.git\|\.bzr\|\.svn\|tags\%(-.*\)\?\)\%($\|/\)')
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
    endfunction

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

    nnoremap <SID>[unite-neobundle] <Nop>
    nmap <SID>[unite]n <SID>[unite-neobundle]
    nnoremap <silent> <SID>[unite-neobundle]u :<C-U>Unite -buffer-name=neobundle -no-cursor-line -log neobundle/update<CR>
    nnoremap <silent> <SID>[unite-neobundle]i :<C-U>Unite -buffer-name=neobundle -no-cursor-line -log neobundle/install<CR>
    nnoremap <silent> <SID>[unite-neobundle]c :<C-U>UniteClose neobundle<CR>

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

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-ref') "{{{
    function! neobundle#hooks.on_source(bundle)
        let g:ref_source_webdict_sites = {
                    \   'wikipedia:ja': {
                    \     'url': 'http://ja.wikipedia.org/wiki/%s',
                    \     'keyword_encoding': 'utf-8',
                    \     'cache': 1,
                    \   },
                    \   'wiktionary': {
                    \     'url': 'http://ja.wiktionary.org/wiki/%s',
                    \     'keyword_encoding': 'utf-8',
                    \     'cache': 1,
                    \   },
                    \ }
        function! g:ref_source_webdict_sites.wiktionary.filter(output)
            return join(split(a:output, "\n")[18 :], "\n")
        endfunction

        let g:ref_source_webdict_sites.default = 'wiktionary'
    endfunction

    autocmd Portown FileType ref-webdict nnoremap <buffer> q <C-W>c

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-fugitive') "{{{
    nnoremap <SID>[git] <Nop>
    nmap <Space>g <SID>[git]
    nnoremap <SID>[git]d :<C-U>Gvdiff<CR>
    nnoremap <SID>[git]s :<C-U>Gstatus<CR>
    nnoremap <SID>[git]cc :<C-U>Gcommit -v<CR>
    nnoremap <SID>[git]ca :<C-U>Gcommit -av<CR>
    nnoremap <SID>[git]b :<C-U>Gblame<CR>

    call neobundle#untap()
endif "}}}

if neobundle#tap('agit.vim') "{{{
    let g:agit_enable_auto_show_commit = 0
    let g:agit_enable_auto_refresh = 0
    let g:agit_max_log_lines = 60

    nnoremap <SID>[agit] <Nop>
    nmap <SID>[git]v <SID>[agit]
    nnoremap <silent> <SID>[agit]v :<C-U>Agit<CR>
    nnoremap <silent> <SID>[agit]f :<C-U>AgitFile<CR>

    autocmd Portown filetype agit nnoremap <buffer> git :<C-U>AgitGit 

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-gitgutter') "{{{
    let g:gitgutter_realtime = 0
    let g:gitgutter_eager = 0

    call neobundle#untap()
endif "}}}

if neobundle#tap('syntastic') "{{{
    let g:syntastic_mode_map = { 'mode': 'passive' }

    function! MyVimrcSyntastic()
        SyntasticCheck
        call lightline#update()
    endfunction

    let g:syntastic_enable_signs = 1
    let g:syntastic_error_symbol = 'x'
    let g:syntastic_warning_symbol = 'w'

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-entire') "{{{
    " for lazy loading
    let g:textobj_entire_no_default_key_mappings = 1

    omap ae <Plug>(textobj-entire-a)
    omap ie <Plug>(textobj-entire-i)
    xmap ae <Plug>(textobj-entire-a)
    xmap ie <Plug>(textobj-entire-i)

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-line') "{{{
    " for lazy loading
    let g:textobj_line_no_default_key_mappings = 1

    omap al <Plug>(textobj-line-a)
    omap il <Plug>(textobj-line-i)
    xmap al <Plug>(textobj-line-a)
    xmap il <Plug>(textobj-line-i)

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-between') "{{{
    " for lazy loading
    let g:textobj_between_no_default_key_mappings = 1

    omap af <Plug>(textobj-between-a)
    omap if <Plug>(textobj-between-i)
    xmap af <Plug>(textobj-between-a)
    xmap if <Plug>(textobj-between-i)

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-multiblock') "{{{
    let g:textobj#multiblock#default_blocks = []
    let g:textobj_multiblock_blocks = [
                \   ['"', '"', 1],
                \   ["'", "'", 1],
                \   ['`', '`', 1],
                \   ['(', ')'],
                \   ['{', '}'],
                \   ['[', ']'],
                \   ['<', '>'],
                \ ]

    let g:textobj#multiblock#enable_block_in_cursor = 1

    omap ab <Plug>(textobj-multiblock-a)
    omap ib <Plug>(textobj-multiblock-i)
    xmap ab <Plug>(textobj-multiblock-a)
    xmap ib <Plug>(textobj-multiblock-i)

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-ruby') "{{{
    " for lazy loading
    let g:textobj_ruby_no_default_key_mappings = 1

    omap ar <Plug>(textobj-ruby-a)
    omap ir <Plug>(textobj-ruby-i)
    xmap ar <Plug>(textobj-ruby-a)
    xmap ir <Plug>(textobj-ruby-i)

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-operator-surround') "{{{
    nmap <silent>ys <Plug>(operator-surround-append)
    nmap <silent>csb <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)
    nmap <silent>csc <Plug>(operator-surround-replace)<Plug>(textobj-between-a)
    nmap <silent>dsb <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
    nmap <silent>dsc <Plug>(operator-surround-delete)<Plug>(textobj-between-a)

    xmap <silent>s <Plug>(operator-surround-append)

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-operator-replace') "{{{
    nmap <silent>_ <Plug>(operator-replace)

    call neobundle#untap()
endif "}}}

if neobundle#tap('vim-quickrun') "{{{
    let g:quickrun_config = {}

    let g:quickrun_config._ = {
                \       'runner': 'vimproc',
                \       'runner/vimproc/updatetime': 60,
                \       'outputter': 'error',
                \       'outputter/error/success': 'buffer',
                \       'outputter/error/error': 'quickfix',
                \   }

    let g:quickrun_config.haskell = {
                \       'command': 'runghc',
                \   }
    if IsWindows()
        let g:quickrun_config.haskell['hook/output_encode/encoding'] = 'cp932'
    endif

    let g:quickrun_config.ruby = {
                \       'command': 'ruby',
                \   }

    call neobundle#untap()
endif "}}}

if neobundle#tap('qfixhowm') "{{{
    let howm_dir = '~/howm'
    let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'
    let QFixHowm_RootDir = howm_dir
    let QFixHowm_FileType = 'markdown'
    let QFixHowm_Title = '#'
    let QFixMRU_Title = {}
    let QFixMRU_Title['md'] = '^#[^#]'
    let QFixHowm_HolidayFile = $HOME . '/.vim/bundle/qfixhowm/misc/holiday/Sche-Hd-0000-00-00-000000.utf8'

    let QFixHowm_ScheduleSearchDir = howm_dir . '/schedule'
    let QFixHowm_ScheduleSearchFile = ''

    call neobundle#untap()
endif "}}}
