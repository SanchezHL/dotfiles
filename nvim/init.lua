vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 50

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.tabstop = 4      -- Width of a tab character in spaces
vim.opt.shiftwidth = 4    -- Width for autoindents
-- vim.opt.expandtab = true   -- Convert tabs to spaces

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- Configuracion especifica de windows
if vim.fn.has("win32") == 1 then
    vim.opt.shell = "powershell.exe"
    vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

vim.opt.hlsearch = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Enter Explorer
vim.keymap.set("n", "<leader>a", '<cmd>:Ex<CR>')
-- Enter Terminal
vim.keymap.set("n", "<leader>t", '<cmd>:term<CR>')
--Previus buffer
vim.keymap.set("n", "<leader>p", '<cmd>:bp<CR>')


-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Set Neovim Theme
vim.cmd.colorscheme("slate")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Al dividir ventanas, seleccionar automáticamente la nueva ventana
vim.api.nvim_create_autocmd({"VimEnter", "WinNew"}, {
    callback = function()
        -- Cambiar el enfoque a la última ventana creada
        vim.cmd("wincmd w")
    end
})


-- [[ Plugin Management: Lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require("lazy").setup({
  -- 1. Configuracion de LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP Installer: Instala los servidores de lenguaje
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Autocompletado (opcional, pero muy recomendado)
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
  },
  {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({
      -- Lista de lenguajes que quieres instalados siempre
      ensure_installed = { "python", "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript" },
      -- Instalación sincrónica (falso para que no bloquee el inicio)
      sync_install = true,
      -- Auto-instalación de lenguajes cuando abres un archivo nuevo
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true -- También activa la indentación inteligente
      },
    })
  end
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
        require('tiny-inline-diagnostic').setup({
            -- Esta es la opción que buscas:
            options = {
                show_all_diagonstics = true, -- Muestra todos los errores del archivo siempre
                show_source = true, -- Muestra si el error es de clangd, lua_ls, etc.
                multiple_diag_under_cursor = true,
                multilines = true, -- Permite que mensajes largos se dividan en varias líneas
            }
        })
        -- Desactivamos el virtual_text nativo para que no se dupliquen los mensajes
        vim.diagnostic.config({ virtual_text = false })
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- solo se carga en archivos lua
    opts = {
      library = {
        -- Carga los tipos de la API de Neovim
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
})

-- [[ LSP Setup ]]
-- Función de configuración que se ejecuta cuando el LSP se adjunta a un buffer.
-- Es un buen lugar para configurar mapeos de teclas específicos del LSP.
local on_attach = function(client, bufnr)
    -- Puedes añadir mapeos de teclas aquí, por ejemplo:
    -- Mapeo para ir a la definición:
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Go to Definition" })
    -- Mapeo para ver la documentación (hover):
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover Documentation" })
end

-- 1. Mason: Gestiona la instalación de servidores LSP
require("mason").setup()

-- 2. Mason-LSPConfig: Conecta Mason con Nvim-LSPConfig
local lspconfig = require("lspconfig")

require("mason-lspconfig").setup({
    -- Asegura que estos servidores esten instalados. Mason se encargara de esto.
    ensure_installed = {
		"lua_ls",
        "pyright",
        "clangd",
        "html",
        "cssls",
        "ts_ls",
    },
    -- Esta sección maneja la configuración de cada LSP
    handlers = {
        -- Handler por defecto (para servidores sin configuración especial)
        function (server_name)
            lspconfig[server_name].setup({
                on_attach = on_attach,
                -- Otras opciones por defecto, si las hay
            })
        end,
    }
})

-- [[ Autocompletado: nvim-cmp ]]
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({

	enabled = function()
      -- Desactivar autocompletado si el cursor está en un comentario
      local context = require('cmp.config.context')

      -- Mantener autocompletado en el modo comando (search, etc.)
      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
		  -- Detectar si estamos en un comentario
        local is_comment = context.in_treesitter_capture("comment")
            or context.in_syntax_group("Comment")

        -- Detectar si estamos en un String (probamos varias etiquetas comunes)
        local is_string = context.in_treesitter_capture("string")
            or context.in_syntax_group("String")
            or context.in_syntax_group("Constant") -- A veces los strings caen aquí en sintaxis simple

        -- Solo habilitar si NO es comentario y NO es string
        return not is_comment and not is_string
      end
    end,

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For luasnip users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jumpable()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For snippets
    }, {
        { name = 'buffer' },
    })
})

-- [[ Configuración de Diagnósticos ]]
vim.diagnostic.config({
    virtual_text = {
        prefix = '●', -- Carácter que aparece antes del error
        spacing = 4,
    },
    update_in_insert = false, -- No mostrar errores mientras escribes (evita distracciones)
    underline = true,         -- Mantener el subrayado rojo
    severity_sort = true,     -- Ordenar por gravedad (Error > Warning)
    float = {
        focused = false,
        style = "minimal",
        border = "rounded",
        source = "always",    -- Muestra si el error viene de Pyright, Clangd, etc.
        header = "",
        prefix = "",
    },
})

-- Mostrar el error completo en una ventana flotante (útil si el mensaje es largo)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Mostrar mensaje de error" })
-- Saltar entre errores TODO:CAMBIAR KEYMAPS y filtrar entre mensajes de diagnosico
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Ir al error anterior" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Ir al siguiente error" })

