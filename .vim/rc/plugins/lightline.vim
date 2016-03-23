" lightline.vim

let g:lightline = {
            \   'colorscheme': 'wombat',
            \   'active': {
            \     'left': [['mode'], ['fugitive', 'filename']],
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
            \     'fugitive': 'MyFugitive',
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
