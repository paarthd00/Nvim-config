require("paarth.remap")
require("paarth.set")
-- Add this to ~/.config/nvim/lua/paarth/init.lua

-- Visual-multi settings
vim.g.VM_default_mappings = 0
vim.g.VM_mouse_mappings = 1
vim.g.VM_theme = 'ocean'

-- VSCode-like mappings
vim.g.VM_maps = {
    ['Find Under'] = '<C-d>',                -- select word under cursor like VSCode
    ['Find Subword Under'] = '<C-d>',        -- same as above
    ['Select All'] = '<C-S-l>',              -- select all occurrences
    ['Select h'] = '<C-Left>',               -- extend selection left
    ['Select l'] = '<C-Right>',              -- extend selection right
    
    -- Basic operations
    ['Add Cursor Up'] = '<C-S-Up>',          -- create cursor up
    ['Add Cursor Down'] = '<C-S-Down>',      -- create cursor down
    ['Find Next'] = 'n',                     -- find next occurrence
    ['Find Prev'] = 'N',                     -- find previous occurrence
    ['Goto Next'] = ']',                     -- go to next selected region
    ['Goto Prev'] = '[',                     -- go to previous selected region
    ['Skip Region'] = 'q',                   -- skip current and find next
    ['Remove Region'] = 'Q',                 -- remove current region
    ['Remove Last Region'] = '',
    ['Remove Every n Regions'] = '',
    ['Visual Regex'] = '\\/',                -- regex search
    ['Visual All'] = '\\A',                  -- select all matches
    ['Visual Add'] = '\\a',                  -- add current match
    ['Start Regex Search'] = '\\/',
    
    -- Cursor and selection movements
    ['Mouse Cursor'] = '<M-LeftMouse>',
    ['Mouse Word'] = '<M-RightMouse>',
    ['Undo'] = 'u',
    ['Redo'] = '<C-r>'
}

-- Additional visual-multi settings
vim.g.VM_show_warnings = 0                   -- disable warnings
vim.g.VM_highlight_matches = 'underline'     -- highlight matching words
vim.g.VM_silent_exit = 1                     -- silent exit from visual-multi mode

-- Add any other paarth/ configurations below