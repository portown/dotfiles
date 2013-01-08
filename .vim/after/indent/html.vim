function! HtmlIndentPush( tag )
  if exists( 'g:html_indent_tags' )
    let g:html_indent_tags = g:html_indent_tags.'\|'.a:tag
  else
    let g:html_indent_tags = a:tag
  endif
endfunction

call HtmlIndentPush('article')
call HtmlIndentPush('aside')
call HtmlIndentPush('audio')
call HtmlIndentPush('canvas')
call HtmlIndentPush('details')
call HtmlIndentPush('figcaption')
call HtmlIndentPush('figure')
call HtmlIndentPush('footer')
call HtmlIndentPush('header')
call HtmlIndentPush('hgroup')
call HtmlIndentPush('mark')
call HtmlIndentPush('menu')
call HtmlIndentPush('meter')
call HtmlIndentPush('nav')
call HtmlIndentPush('output')
call HtmlIndentPush('progress')
call HtmlIndentPush('section')
call HtmlIndentPush('summary')
call HtmlIndentPush('time')
call HtmlIndentPush('video')

delfunction HtmlIndentPush
