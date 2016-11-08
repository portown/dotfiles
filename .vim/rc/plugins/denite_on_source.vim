" denite_on_source.vim

call denite#custom#option('default', 'statusline', 'false')

call denite#custom#map('insert', '<C-j>', 'move_to_next_line')
call denite#custom#map('insert', '<C-k>', 'move_to_prev_line')
