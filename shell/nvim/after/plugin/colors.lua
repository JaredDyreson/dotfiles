function ColorMyPencils(Color)
    require('rose-pine').setup({
        disable_italics = true,
        dark_variant = 'main',
    })
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

end
ColorMyPencils()
