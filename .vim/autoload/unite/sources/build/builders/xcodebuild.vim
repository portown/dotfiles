" xcodebuild.vim

" Variables  "{{{
call unite#util#set_default('g:unite_builder_xcodebuild_command', 'xcodebuild')
"}}}

function! unite#sources#build#builders#xcodebuild#define() "{{{
  return executable(g:unite_builder_xcodebuild_command) ?
        \ s:builder : []
endfunction "}}}

let s:builder = {
      \ 'name': 'xcodebuild',
      \ 'description': 'xcodebuild builder',
      \ }

function! s:builder.detect(args, context) "{{{
  let proj = glob('*.xcodeproj', 0, 1)
  return len(proj) == 1 && isdirectory(proj[0])
endfunction"}}}

function! s:builder.initialize(args, context) "{{{
  return g:unite_builder_xcodebuild_command . ' ' . join(a:args)
endfunction"}}}

function! s:builder.parse(string, context) "{{{
  if a:string =~ ': \%(error\|warning\|note\):'
    " Error or warning.
    return s:analyze_error(a:string)
  endif

  if a:string =~ '\*\* BUILD '
    return { 'type' : 'message', 'text' : a:string }
  endif

  return {}
endfunction "}}}

function! s:analyze_error(string) "{{{
  let string = a:string

  let [word, list] = [string, split(string[2:], ':')]
  let candidate = {}

  if empty(list)
    " Message.
    return { 'type' : 'message', 'text' : string }
  endif

  if len(word) == 1 && unite#util#is_windows()
    let candidate.word = word . list[0]
    let list = list[1:]
  endif

  let filename = unite#util#substitute_path_separator(word[:1].list[0])
  let candidate.filename = filename

  let list = list[1:]

  if !filereadable(filename) && '\<\f\+:'
    " Message.
    return { 'type' : 'message', 'text' : string }
  endif

  if len(list) > 0 && list[0] =~ '^\d\+$'
    let candidate.line = list[0]
    if len(list) > 1 && list[1] =~ '^\d\+$'
      let candidate.col = list[1]
      let list = list[1:]
    endif

    let list = list[1:]
  endif

  if len(list) > 1 && list[0] =~ '\s*\a\+'
    let candidate.type = tolower(matchstr(list[0], '\s*\zs\a\+'))
    if candidate.type != 'error' && candidate.type != 'warning'
      let candidate.type = 'message'
    endif
    let list = list[1:]
  else
    let candidate.type = 'message'
  endif

  let candidate.text = fnamemodify(filename, ':t') . ' : ' . join(list, ':')

  return candidate
endfunction"}}}

" vim: foldmethod=marker
