-- lualine.lua

local function cwd()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

local function lineinfo()
    local pos = vim.fn.getpos('.')
    local entire = vim.fn.line('$')
    return pos[2] .. '/' .. entire .. ':' .. pos[3]
end

require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'wombat',
        section_separators = { left = '⮀', right = '⮂' },
        component_separators = { left = '⮁', right = '⮃' },
        --always_divide_middle = true,
        --globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'fileformat', 'encoding', 'filetype' },
        lualine_y = { lineinfo },
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'fileformat', 'encoding', 'filetype' },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_a = {},
        lualine_b = { 'tabs' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { cwd },
        lualine_z = {},
    },
    extensions = {
    },
}
