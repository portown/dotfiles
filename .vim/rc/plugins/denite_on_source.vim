" denite_on_source.vim

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q denite#do_map('quit')
    nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> <C-i> denite#do_map('choose_action')
endfunction

call denite#custom#option('_', {
            \       'statusline': v:false,
            \       'cursor_wrap': v:true
            \   })
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', '.*'])

call denite#custom#map('insert', '<C-f>', '<denite:scroll_page_forwards>', 'noremap')
call denite#custom#map('insert', '<C-b>', '<denite:scroll_page_backwards>', 'noremap')
