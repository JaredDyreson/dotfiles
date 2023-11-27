function ColorMyPencils(Color)
    require('rose-pine').setup({
        disable_italics = true,
        dark_variant = 'moon',
    })
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
    --vim.cmd.colorscheme = "kanagawa"

	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

end
ColorMyPencils()
