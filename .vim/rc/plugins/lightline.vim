" lightline.vim

let g:lightline = {
            \   'colorscheme': 'wombat',
            \   'active': {
            \     'left': [['mode'], ['branch', 'filename']],
            \     'right': [['lineinfo'], ['fileformat', 'fileencoding', 'filetype']],
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
            \     'branch': 'MyBranch',
            \     'filename': 'MyFilename',
            \     'fileformat': 'MyFileformat',
            \     'filetype': 'MyFiletype',
            \     'fileencoding': 'MyFileencoding',
            \     'mode': 'MyMode',
            \     'cwd': 'MyCwd',
            \   },
            \   'separator': { 'left': "\u2b80", 'right': "\u2b82" },
            \   'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
            \ }

function! MyBranch()
    if &filetype !~? 'unite\|denite\|vimfiler' && dein#tap('gina.vim')
        if !dein#is_sourced('gina.vim')
            call dein#source('gina.vim')
        endif
        let _ = gina#component#repo#branch()
        return strlen(_) ? "\u2b60 " . _ : ''
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
                \  &ft ==# 'denite' ? denite#get_status_sources() :
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
    if &ft ==# 'denite'
        let mode_str = substitute(denite#get_status_mode(), '-\| ', '', 'g')
        call lightline#link(tolower(mode_str[0]))
        return mode_str
    else
        return winwidth(0) > 60 ? lightline#mode() : ''
    endif
endfunction

function! MyCwd()
    return fnamemodify(getcwd(), ':~')
endfunction
