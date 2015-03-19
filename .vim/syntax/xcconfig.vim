" xcconfig.vim

if exists("b:current_syntax")
  finish
endif

syntax region xcconfigComment start='//' skip='\\$' end='$' keepend

syntax keyword xcconfigConstant YES NO YES_ERROR YES_AGGRESSIVE deep shallow iphoneos iphonesimulator

syntax match xcconfigNumbers display transparent '\<\d\|\.\d' contains=xcconfigNumber,xcconfigFloat
syntax match xcconfigNumber display contained '\d\+\(\u\=l\{0,2}\|ll\=u\)\>'
syntax match xcconfigFloat display contained '\d\+\.\d*'
syntax match xcconfigFloat display contained '\.\d\+\>'

syntax match xcconfigVariable display '\${[^}]\+}'

syntax region xcconfigIncluded display contained start='"' skip='\\\\\|\\"' end='"'
syntax match xcconfigInclude display '^\s*#\s*include\>\s*"' contains=xcconfigIncluded


highlight link xcconfigComment Comment
highlight link xcconfigConstant Constant
highlight link xcconfigNumber Number
highlight link xcconfigFloat Float
highlight link xcconfigVariable Identifier
highlight link xcconfigIncluded String
highlight link xcconfigInclude Include
