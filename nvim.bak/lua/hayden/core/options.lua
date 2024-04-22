vim.opt.nu = true
vim.opt.guicursor = ""

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.pumheight = 10
vim.opt.showmode = false

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.conceallevel = 1
vim.opt.cursorline = true

vim.cmd [[highlight CursorLine ctermbg=white]]

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- fix enter key not working in quickfix list (https://stackoverflow.com/a/61793352)
vim.cmd [[autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>]]
