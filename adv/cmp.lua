local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

return {
    -- set cmp source priorities
    source_priority = {
        copilot = 1100,
        nvim_lsp = 1000,
        luasnip = 750,
        emoji = 700,
        buffer = 500,
        path = 250,
    },
    setup = function()
        -- load cmp to access it's internal functions
        local cmp = require "cmp"
        local user_source = astronvim.get_user_cmp_source

        -- store a local variable with a source list to share between filetypes
        local prose_sources = {
            user_source "luasnip",
            user_source "buffer",
            user_source "emoji",
        }

        -- configure mappings for cmdline
        local fallback_func = function(func)
            return function(fallback)
                if cmp.visible() then
                    cmp[func]()
                else
                    fallback()
                end
            end
        end
        local mappings = cmp.mapping.preset.cmdline {
            ["<C-j>"] = { c = fallback_func "select_next_item" },
            ["<C-k>"] = { c = fallback_func "select_prev_item" },
            ["<CR>"] = cmp.mapping.confirm({
                -- this is the important line
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
            ["<Tab>"] = vim.schedule_wrap(function(fallback)
                if cmp.visible() and has_words_before() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end),
        }
        local config = {
            -- configure cmp.setup.filetype(filetype, options)
            filetype = {
                -- first key is the filetype that you are setting up
                lua = { -- for lua only load lsp sources and buffer sources as a fallback
                    sources = cmp.config.sources({
                        user_source "nvim_lsp",
                    }, {
                        user_source "buffer",
                    }),
                },
                -- markdown and latex share the same sources
                markdown = { sources = prose_sources },
                latex = { sources = prose_sources },
            },
            -- configure cmp.setup.cmdline(source, options)
            cmdline = {
                -- first key is the source that you are setting up
                [":"] = {
                    -- set up custom mappings
                    mapping = mappings,
                    -- configure sources normally without getting priority from cmp.source_priority
                    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } })
                },
                ["/"] = { mapping = mappings, sources = { { name = "buffer" } } },
                ["?"] = { mapping = mappings, sources = { { name = "buffer" } } },
            },
        }

        -- return config
        return config
    end,
}