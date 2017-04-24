" denite_on_source.vim

call denite#custom#option('_', {
            \       'statusline': v:false,
            \       'cursor_wrap': v:true
            \   })
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', '.*'])

call denite#custom#map('insert', '<C-f>', '<denite:scroll_page_forwards>', 'noremap')
call denite#custom#map('insert', '<C-b>', '<denite:scroll_page_backwards>', 'noremap')
