---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by like.
--- DateTime: 12/15/22 5:53 PM
---

local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        text = txt,
        shortcut = sc,
        cursor = 5,
        width = 36,
        align_shortcut = "right",
        hl = "AlphaButtons",
    }

    if keybind then
        opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
    end

    return {
        type = "button",
        val = txt,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
            vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = opts,
    }
end

-- dynamic header padding
local fn = vim.fn
local marginTopPercent = 0.1
local headerPadding = fn.max { 3, fn.floor(fn.winheight(0) * marginTopPercent) }

local options = {
    header = {
        type = "text",
        val = {
            [[    ____          __             ]],
            [[   / __/___  ____/ /      ___  __]],
            [[  / /_/_  / / __  / | /| / / |/_/]],
            [[ / __/ / /_/ /_/ /| |/ |/ />  <  ]],
            [[/_/   /___/\__,_/ |__/|__/_/|_|  ]],
        },
        opts = {
            position = "center",
            hl = "AlphaHeader",
        },
    },

    buttons = {
        type = "group",
        val = {
            button("f", " " .. " Find File  ", ":Telescope find_files<CR>"),
            button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
            button("r", " " .. " Recent File  ", ":Telescope oldfiles<CR>"),
            button("t", " " .. " Find Word  ", ":Telescope live_grep<CR>"),
            button("m", " " .. " Bookmarks  ", ":Telescope marks<CR>"),
            --button("h", " " .. " Themes  ", ":Telescope themes<CR>"),
            button("c", " " .. " Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
            button("q", " " .. " Quit", ":qa<CR>"),
        },
        opts = {
            spacing = 1,
        },
    },
    headerPaddingTop = { type = "padding", val = headerPadding },
    headerPaddingBottom = { type = "padding", val = 2 },
}

local M = {}

M.config = {
    layout = {
        options.headerPaddingTop,
        options.header,
        { type = "padding", val = 3 },
        options.headerPaddingBottom,
        options.buttons,
    },
    opts = { noautocmd = true },
}

return M