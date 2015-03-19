" strings.vim

if exists('b:current_syntax')
    finish
endif

syntax region stringsValue display start='"' skip='\\"' end='"'
syntax match stringsLineLeft display transparent /.*\ze=.*;/ contains=stringsKey
syntax region stringsKey display contained start='"' skip='\\"' end='"'


highlight link stringsKey Identifier
highlight link stringsValue String
