vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

return function(config)
    -- use codicons preset
    config.preset = "codicons"
    -- set some missing symbol types
    config.symbol_map = {
        Array = "",
        Boolean = "",
        Key = "",
        Namespace = "",
        Null = "",
        Number = "",
        Object = "",
        Package = "",
        String = "",
        Copilot = "",
    }
    return config
end