" fileutil.vim

let save_cpo = &cpo
set cpo&vim


function! fileutil#get_vital()
  if !exists('s:V')
    let s:V = vital#of('MyVimrc')
  endif
  return s:V
endfunction


function! fileutil#get_xcode_project_dir(path)
  let S = fileutil#get_vital().import('System.Filepath')
  let dirs = glob(S.join(a:path, '*.xcodeproj'), 0, 1)
  if empty(dirs)
    return ''
  endif
  return dirs[0]
endfunction

function! s:_f_iterate_while() dict
  if !eval(substitute(self.pred, 'v:val', self.memo, 'g'))
    return [[], {}]
  endif
  let next_thunk = {
        \   'memo': eval(substitute(self.f, 'v:val', self.memo, 'g')),
        \   'f': self.f, 'pred': self.pred,
        \   'run': self.run,
        \ }
  return [[self.memo], next_thunk]
endfunction

function! s:iterate_while(init, f, pred)
  if !eval(substitute(a:pred, 'v:val', a:init, 'g'))
    return [[], {}]
  endif
  let thunk = {
        \   'memo': a:init, 'f': a:f, 'pred': a:pred,
        \   'run': function('s:_f_iterate_while'),
        \ }
  return [[], thunk]
endfunction

function! fileutil#get_parent(path)
  let parent = fnamemodify(a:path, ':h')
  return parent == a:path ? '' : parent
endfunction

function! fileutil#get_xcode_proj_name(path)
  let V = fileutil#get_vital()
  let path = V.import('System.Filepath').remove_last_separator(fnamemodify(a:path, ':p'))

  let S = V.import('Data.LazyList')
  let xs = s:iterate_while(path, 'fileutil#get_parent("v:val")', '!empty("v:val")')
  let xs = S.map(xs, 'fileutil#get_xcode_project_dir(v:val)')
  let xs = S.filter(xs, 'isdirectory(v:val)')

  return fnamemodify(S.first(xs, ''), ':t:r')
endfunction


let &cpo = save_cpo
unlet save_cpo
