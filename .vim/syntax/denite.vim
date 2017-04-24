" denite.vim

if exists('b:current_syntax')
    finish
endif

let s:candidate_icon = get(get(unite#get_current_unite(), 'context', {}), 'candidate_icon', ' ')

" files
syntax region deniteFile start='.' end='[^\s]\%(\s\s\s\)\@=' contained containedin=deniteCandidateAbbr,deniteSource_vimfiler_drive,deniteSource_file,deniteSource_file_mru,deniteSource_file_rec,deniteSource_file_new,deniteSource_directory_new contains=deniteCandidateInputKeyword
execute 'syntax match deniteGrepFile ''\%(^' . s:candidate_icon '  *\)\@<=[^:]*'' contained containedin=deniteSource_grep_line,deniteSource_grep'
syntax match denitePath '.*/' contained containedin=deniteFile contains=deniteCandidateInputKeyword
syntax region denitePdfHtml start='.' end='\.\(pdf\|html\)\>\(\s\s\)\@=' oneline contained containedin=deniteFile contains=deniteCandidateInputKeyword,denitePath
syntax region deniteArchive start='.' end='\.\(lha\|lzh\|zip\|gz\|bz2\|cab\|rar\|7z\|tgz\|tar\)\>\(\s\s\)\@=' oneline contained containedin=deniteFile contains=deniteCandidateInputKeyword,denitePath
syntax region deniteImage start='.' end='\.\(eps\|bmp\|BMP\|png\|PNG\|gif\|GIF\|JPE\?G\|jpe\?g\|jp2\|tif\|ico\|wdp\|cur\|ani\)\>\(\s\s\)\@=' oneline contained containedin=deniteFile contains=deniteCandidateInputKeyword,denitePath
syntax region deniteTypeMultimedia start='.' end='\.\(
      \.avi\|asf\|wmv\|flv\|swf\|divx\|mov\|m1a\|
      \.m2[ap]\|mpe\?g\|m[12]v\|mp2v\|mp[34a]\|qt\|ra\|rm\|ram\|
      \.rmvb\|rpm\|smi\|mkv\|mid\|wav\|ogg\|wma\|au\|flac\)\>\(\s\s\)\@=' oneline contained containedin=deniteFile contains=deniteCandidateInputKeyword,denitePath
syntax region deniteTypeSystem start='.' end='\.\(o\|hi\|inf\|sys\|reg\|dat\|spi\|a\|so\|lib\|dll\|log\)\>\(\s\s\)\@=' oneline contained containedin=deniteFile contains=deniteCandidateInputKeyword,denitePath
syntax match deniteTypeSystem '\(#\S\+#\|configure[\s$]\|aclocal\.m4\|[Mm]akefile\(\.in\)\?\|stamp-h1\|config\.\(h\(\.in\~\?\)\?\|status\)\|output\.[0-9]\S\?\|requests\|traces\.[0-9]\S\?\)\s\@=' contained containedin=deniteFile contains=deniteCandidateInputKeyword,denitePath
syntax match deniteTypeSystem '\(y\.tab\.c\|y\.output\|lex\.yy\.c\|y\.tab\.h\)\s\@=' contained containedin=deniteFile contains=deniteCandidateInputKeyword,denitePath
syntax match deniteNewFile '\[new \(file\|directory\)\]' contained containedin=deniteFile,deniteSource_file_new,deniteSource_directory_new,denitePath contains=deniteCandidateInputKeyword
highlight default link denitePath Path
highlight default link deniteGrepFile Path
highlight default link denitePdfHtml PdfHtml
highlight default link deniteArchive Archive
highlight default link deniteImage Image
highlight default link deniteTypeMultimedia Multimedia
highlight default link deniteTypeSystem System
highlight default link deniteSource_buffer_no_file Conditional
highlight default link deniteNewFile deniteSource_buffer_no_file
highlight link deniteSource_grep_file Path

syntax region deniteMarkedLine start=/^\*/ end='$' keepend
execute 'syntax match deniteCandidateSourceName /\(^' . s:candidate_icon . ' \+\)\@<=[[:alnum:]_\/-]\+/ contained'
execute 'syntax match deniteCandidateMarker /^' . s:candidate_icon . '\? \+/ contained containedin=deniteVimShellHistory contains=deniteCandidateMarkerWhite'
syntax match deniteCandidateMarkerWhite / \zs \+/ contained containedin=deniteCandidateMarker conceal
syntax match deniteQuickMatchTrigger /^.|/ contained
syntax match deniteNumber '\<\d\+\>' contained containedin=deniteStatusLine,deniteSource_neoBundleInstall_Progress
execute 'syntax match deniteLineNumber ''\(^' . s:candidate_icon . '\? \++\? *\%(\f\+:\)\?\)\@<=\<\d\+\>'' contained containedin=deniteSource_line,deniteSource_line_fast,deniteSource_grep'
highlight default link deniteNumber Number
highlight default link deniteLineNumber LineNr
highlight default link deniteMarkedLine Marked
highlight default link deniteQuickMatchTrigger Special
highlight default link deniteCandidateSourceName deniteSourceNames
highlight default link deniteCandidateMarker Icon
highlight default link deniteCandidateIcon Icon
highlight default link deniteMarkedIcon Marked
highlight default link deniteCandidateInputKeyword Comment

let b:current_syntax = 'denite'
