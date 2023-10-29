local nmap = function(keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

return {
    --- Uncomment these if you want to manage LSP servers from neovim
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "github/copilot.vim",
            "rafamadriz/friendly-snippets",
            { "lukas-reineke/lsp-format.nvim", config = true },
        },
        config = function()
            vim.g.copilot_assume_mapped = true

            local lsp = require("lsp-zero")
            -- mason
            -- import mason
            local mason = require("mason")

            -- import mason-lspconfig
            local mason_lspconfig = require("mason-lspconfig")

            local mason_tool_installer = require("mason-tool-installer")

            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            mason_lspconfig.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    "tsserver",
                    "html",
                    "cssls",
                    "tailwindcss",
                    "svelte",
                    "lua_ls",
                    "emmet_ls",
                    "pyright",
                },
                -- auto-install configured servers (with lspconfig)
                automatic_installation = true, -- not the same as ensure_installed
                handlers = {
                    lsp.default_setup,
                }
            })

            mason_tool_installer.setup({
                ensure_installed = {
                    "prettier", -- prettier formatter
                    "stylua",   -- lua formatter
                    "isort",    -- python formatter
                    "black",    -- python formatter
                    "pylint",   -- python linter
                    "eslint_d", -- js linter
                },
            })

            -- lsp-zero
            lsp.on_attach(function(client, bufnr)
                require("lsp-format").on_attach(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)
            lsp.setup()
            vim.diagnostic.config { virtual_text = true }

            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()
            local luasnip = require('luasnip')

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    -- Ctrl+Space to trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        local copilot_keys = vim.fn['copilot#Accept']()
                        if copilot_keys ~= '' and type(copilot_keys) == 'string' then
                            vim.api.nvim_feedkeys(copilot_keys, 'n', true)
                        elseif cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    -- <S-Tab> ignores copilot
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    -- <C-j> and <C-k> to navigate between cmp items
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),

                    -- Navigate between snippet placeholder
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                    -- Scroll up and down in the completion documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                })
            })
            -- Remaps
            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- See `:help K` for why this keymap
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Lesser used LSP functionality
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            -- Create a command `:Format` local to the LSP buffer
            nmap('<leader>fm', function()
                vim.lsp.buf.format()
            end, '[F]or[M]at')
        end,
    },
}
