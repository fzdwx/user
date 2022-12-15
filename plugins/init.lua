return {
    -- You can disable default plugins as follows:
    -- ["goolord/alpha-nvim"] = { disable = true },

    -- You can also add new plugins here as well:
    -- Add plugins, the packer syntax without the "use"
    -- { "andweeb/presence.nvim" },
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("lsp_signature").setup()
    --   end,
    -- },

    -- We also support a key value style plugin definition similar to NvChad:
    -- ["ray-x/lsp_signature.nvim"] = {
    --   event = "BufRead",
    --   config = function()
    --     require("lsp_signature").setup()
    --   end,
    -- },

    ["hrsh7th/nvim-cmp"] = { keys = { ":", "/", "?" } },
    -- add more custom sources
    ["hrsh7th/cmp-cmdline"] = { after = "nvim-cmp" },
    {
        "hrsh7th/cmp-emoji",
        after = "nvim-cmp",
        config = function()
            astronvim.add_user_cmp_source "emoji"
        end,
    },

    {
        "zbirenbaum/copilot.lua",
        config = function()
            vim.defer_fn(function()
                require("copilot").setup()
            end, 100)
            astronvim.add_user_cmp_source "copilot"
        end,
    },

    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup({
                method = "getCompletionsCycling",
            })
        end
    }
}