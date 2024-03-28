return {
	"rebelot/heirline.nvim",
	event = "BufReadPre",
	config = function()
		-- require("hayden.conf.heirline")
		local heirline = require("heirline")
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local u = require("heirline.utils")
		local kanagawa = require("kanagawa.colors").setup({ theme = "wave" })
		local colors = kanagawa.palette
		heirline.load_colors(colors)
		local fn, api, bo = vim.fn, vim.api, vim.bo

		local status_inactive = {
			buftype = {
				"dashboard",
				"quickfix",
				"locationlist",
				"quickfix",
				"scratch",
				"prompt",
				"nofile",
			},
			filetype = {
				"dashboard",
				"harpoon",
				"startuptime",
				"mason.nvim",
				"terminal",
				"gypsy",
				"no-neck-pain",
			},
		}
		local winbar_inactive = {
			buftype = { "nofile", "prompt", "quickfix", "terminal" },
			filetype = { "toggleterm", "qf", "terminal", "gypsy", "oil", "harpoon", "no-neck-pain" },
		}
		local cmdtype_inactive = {
			":",
			"/",
			"?",
		}

		local recording_background_color = colors.autumnYellow
		local active_background_color = colors.sumiInk3
		local active_foreground_color = colors.sumiInk5
		local inactive_background_color = colors.sumiInk1

		local scrollbar_foreground_color = colors.springBlue
		local scrollbar_background_color = active_background_color

		local scrollbar_enabled = function()
			return api.nvim_buf_line_count(0) > 99 and conditions.is_active()
		end

		local Align = { provider = "%=" }
		local Space = { provider = " " }
		local LeftSep = { provider = "" }
		local RightSep = { provider = "" }

		local ActiveWindow = {
			hl = function()
				if conditions.is_active() then
					return { bg = active_background_color }
				else
					return { bg = inactive_background_color }
				end
			end,
		}

		local ActiveBlock = {
			hl = function()
				if conditions.is_active() then
					return { bg = active_foreground_color }
				else
					return { bg = active_foreground_color }
				end
			end,
		}

		local ActiveSep = {
			hl = function()
				if conditions.is_active() then
					return { fg = active_background_color }
				else
					return { fg = inactive_background_color }
				end
			end,
		}

		local FileIcon = {
			init = function(self)
				local filename = self.filename
				local extension = fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			provider = function(self)
				if self.filename == "" then
					return ""
				else
					return self.icon and (self.icon .. " ")
				end
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		local FileName = {
			provider = function(self)
				local filename = fn.fnamemodify(self.filename, ":t")
				if filename == "" then
					return ""
				end
				if not conditions.width_percent_below(#filename, 0.1) then
					filename = fn.pathshorten(filename)
				end
				return filename
			end,
			hl = { fg = colors.oldWhite, bold = true },
		}

		local FileFlags = {
			{
				provider = function()
					if bo.modified then
						return "[+] "
					end
				end,
				hl = { fg = colors.oldWhite, bold = true, italic = true },
			},
			{
				provider = function()
					if not bo.modifiable or bo.readonly then
						return " "
					end
				end,
				hl = { fg = colors.roninYellow, bold = true, italic = true },
			},
		}

		local FileNameModifer = {
			hl = function()
				if bo.modified then
					return { italic = true, force = true }
				end
			end,
		}

		local diagnostics_spacer = " "
		local Diagnostics = {
			condition = conditions.has_diagnostics,
			static = {
				error_icon = fn.sign_getdefined("DiagnosticSignError")[1].text,
				warn_icon = fn.sign_getdefined("DiagnosticSignWarn")[1].text,
				info_icon = fn.sign_getdefined("DiagnosticSignInfo")[1].text,
				hint_icon = fn.sign_getdefined("DiagnosticSignHint")[1].text,
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = { "DiagnosticChanged", "BufEnter", "WinEnter" },
			{
				RightSep,
				hl = function()
					if conditions.is_active() then
						return {
							fg = active_foreground_color,
							bg = active_background_color,
						}
					else
						return {
							fg = active_foreground_color,
							bg = inactive_background_color,
						}
					end
				end,
			},
			Space,
			{
				provider = function(self)
					return self.errors > 0 and (self.error_icon .. self.errors .. diagnostics_spacer) or ""
				end,
				hl = { fg = colors.samuraiRed },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. self.warnings .. diagnostics_spacer)
				end,
				hl = { fg = colors.roninYellow },
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. self.info .. diagnostics_spacer)
				end,
				hl = { fg = colors.waveAqua1 },
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. self.hints .. diagnostics_spacer)
				end,
				hl = { fg = colors.dragonBlue },
			},
			{
				condition = function()
					return not scrollbar_enabled()
				end,
				{
					Space,
				},
			},
			hl = { bg = active_foreground_color },
		}

		local Git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,
			{
				-- condition = function(self)
				--   return self.has_changes
				-- end,
				{
					provider = function(self)
						return "  " .. self.status_dict.head .. " "
					end,
					hl = { fg = colors.springViolet1, bold = true, italic = true },
				},
				{
					provider = function(self)
						local count = self.status_dict.added or 0
						return count > 0 and ("+" .. count .. " ")
					end,
					hl = { fg = colors.autumnGreen, bold = true },
				},
				{
					provider = function(self)
						local count = self.status_dict.removed or 0
						return count > 0 and ("-" .. count .. " ")
					end,
					hl = { fg = colors.autumnRed, bold = true },
				},
				{
					provider = function(self)
						local count = self.status_dict.changed or 0
						return count > 0 and ("~" .. count .. " ")
					end,
					hl = { fg = colors.autumnYellow, bold = true },
				},
				{
					LeftSep,
					hl = function()
						if conditions.is_active() then
							return {
								bg = active_background_color,
								fg = active_foreground_color,
							}
						else
							return {
								fg = active_foreground_color,
								bg = inactive_background_color,
							}
						end
					end,
				},
				hl = { bg = active_foreground_color },
			},
		}

		local MacroRecording = {
			condition = conditions.is_active,
			init = function(self)
				self.reg_recording = fn.reg_recording()
				self.status_dict = vim.b.gitsigns_status_dict or { added = 0, removed = 0, changed = 0 }
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,
			{
				condition = function(self)
					return self.reg_recording ~= ""
				end,
				{
					condition = function(self)
						return self.has_changes
					end,
					LeftSep,
				},
				{
					provider = "   ",
					hl = { fg = colors.autumnRed },
				},
				{
					provider = function(self)
						return "@" .. self.reg_recording
					end,
					hl = { italic = false, bold = true },
				},
				{
					Space,
				},
				{
					LeftSep,
					hl = { bg = active_background_color, fg = recording_background_color },
				},
				hl = { bg = recording_background_color, fg = active_background_color },
			},
			update = { "RecordingEnter", "RecordingLeave" },
		}

		local FileType = {
			condition = function()
				return conditions.buffer_matches({ filetype = { "coderunner" } })
			end,
			provider = function()
				return bo.filetype
			end,
			hl = { fg = colors.oldWhite, bold = true },
		}

		local ScrollBar = {
			condition = function()
				return scrollbar_enabled()
			end,
			static = {
				-- sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
				sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
			},
			{
				{
					provider = function(self)
						local curr_line = api.nvim_win_get_cursor(0)[1]
						local lines = api.nvim_buf_line_count(0)
						local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
						return string.rep(self.sbar[i], 2)
					end,
					hl = function()
						return { fg = colors.roninYellow, bg = colors.waveBlue2 }
					end,
				},
			},
		}

		--- Blend two rgb colors using alpha
		---@param color1 string | number first color
		---@param color2 string | number second color
		---@param alpha number (0, 1) float determining the weighted average
		---@return string color hex string of the blended color
		local function blend(color1, color2, alpha)
			color1 = type(color1) == "number" and string.format("#%06x", color1) or color1
			color2 = type(color2) == "number" and string.format("#%06x", color2) or color2
			local r1, g1, b1 = color1:match("#(%x%x)(%x%x)(%x%x)")
			local r2, g2, b2 = color2:match("#(%x%x)(%x%x)(%x%x)")
			local r = tonumber(r1, 16) * alpha + tonumber(r2, 16) * (1 - alpha)
			local g = tonumber(g1, 16) * alpha + tonumber(g2, 16) * (1 - alpha)
			local b = tonumber(b1, 16) * alpha + tonumber(b2, 16) * (1 - alpha)
			return "#"
				.. string.format("%02x", math.min(255, math.max(r, 0)))
				.. string.format("%02x", math.min(255, math.max(g, 0)))
				.. string.format("%02x", math.min(255, math.max(b, 0)))
		end

		function dim(color, n)
			return blend(color, "#000000", n)
		end

		local Navic = {
			condition = function()
				return require("nvim-navic").is_available()
			end,
			static = {
				type_hl = {
					File = dim(utils.get_highlight("Directory").fg, 0.75),
					Module = dim(utils.get_highlight("@include").fg, 0.75),
					Namespace = dim(utils.get_highlight("@namespace").fg, 0.75),
					Package = dim(utils.get_highlight("@include").fg, 0.75),
					Class = dim(utils.get_highlight("@type").fg, 0.75),
					Method = dim(utils.get_highlight("@function.method").fg, 0.75),
					Property = dim(utils.get_highlight("@property").fg, 0.75),
					Field = dim(utils.get_highlight("@variable.member").fg, 0.75),
					Constructor = dim(utils.get_highlight("@constructor").fg, 0.75),
					Enum = dim(utils.get_highlight("@type").fg, 0.75),
					Interface = dim(utils.get_highlight("@type").fg, 0.75),
					Function = dim(utils.get_highlight("@function").fg, 0.75),
					Variable = dim(utils.get_highlight("@variable").fg, 0.75),
					Constant = dim(utils.get_highlight("@constant").fg, 0.75),
					String = dim(utils.get_highlight("@string").fg, 0.75),
					Number = dim(utils.get_highlight("@number").fg, 0.75),
					Boolean = dim(utils.get_highlight("@boolean").fg, 0.75),
					Array = dim(utils.get_highlight("@variable.member").fg, 0.75),
					Object = dim(utils.get_highlight("@type").fg, 0.75),
					Key = dim(utils.get_highlight("@keyword").fg, 0.75),
					Null = dim(utils.get_highlight("@comment").fg, 0.75),
					EnumMember = dim(utils.get_highlight("@constant").fg, 0.75),
					Struct = dim(utils.get_highlight("@type").fg, 0.75),
					Event = dim(utils.get_highlight("@type").fg, 0.75),
					Operator = dim(utils.get_highlight("@operator").fg, 0.75),
					TypeParameter = dim(utils.get_highlight("@type").fg, 0.75),
				},
				-- line: 16 bit (65536); col: 10 bit (1024); winnr: 6 bit (64)
				-- local encdec = function(a,b,c) return dec(enc(a,b,c)) end; vim.pretty_print(encdec(2^16 - 1, 2^10 - 1, 2^6 - 1))
				enc = function(line, col, winnr)
					return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
				end,
				dec = function(c)
					local line = bit.rshift(c, 16)
					local col = bit.band(bit.rshift(c, 6), 1023)
					local winnr = bit.band(c, 63)
					return line, col, winnr
				end,
			},
			init = function(self)
				local data = require("nvim-navic").get_data() or {}
				local children = {}
				for i, d in ipairs(data) do
					local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
					local child = {
						{
							provider = d.icon,
							hl = { fg = self.type_hl[d.type] },
						},
						{
							provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
							hl = { fg = self.type_hl[d.type] },
							-- hl = self.type_hl[d.type],
							on_click = {
								callback = function(_, minwid)
									local line, col, winnr = self.dec(minwid)
									vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
								end,
								minwid = pos,
								name = "heirline_navic",
							},
						},
					}
					if i < #data then
						table.insert(child, {
							provider = " → ",
							hl = { fg = utils.get_highlight("Folded").fg },
						})
					end
					table.insert(children, child)
				end
				self[1] = self:new(children, 1)
			end,
			update = "CursorMoved",
			hl = { fg = "gray" },
		}

		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			static = {
				mode_names = {
					n = "N",
					no = "N?",
					nov = "N?",
					noV = "N?",
					["no\22"] = "N?",
					niI = "Ni",
					niR = "Nr",
					niV = "Nv",
					nt = "Nt",
					v = "V",
					vs = "Vs",
					V = "V_",
					Vs = "Vs",
					["\22"] = "^V",
					["\22s"] = "^V",
					s = "S",
					S = "S_",
					["\19"] = "^S",
					i = "I",
					ic = "Ic",
					ix = "Ix",
					R = "R",
					Rc = "Rc",
					Rx = "Rx",
					Rv = "Rv",
					Rvc = "Rv",
					Rvx = "Rv",
					c = "C",
					cv = "Ex",
					r = "...",
					rm = "M",
					["r?"] = "?",
					["!"] = "!",
					t = "T",
				},
			},
			provider = function(self)
				return "  " .. "%2(" .. self.mode_names[self.mode] .. "%)"
			end,
			--    
			hl = function(self)
				local color = self:mode_color()
				return { fg = color, bold = true }
			end,
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}

		local FileNameBlock = {
			init = function(self)
				self.filename = api.nvim_buf_get_name(0)
			end,
		}
		local DiagnosticsBlock, GitBlock, MacroRecordingBlock, ScrollBarBlock = {}, {}, {}, {}

		FileNameBlock = u.insert(
			FileNameBlock,
			FileType,
			u.insert(ActiveSep, LeftSep),
			Space,
			unpack(FileFlags),
			u.insert(FileNameModifer, FileName, Space, FileIcon),
			{ provider = "%<" }
		)
		DiagnosticsBlock = u.insert(DiagnosticsBlock, Diagnostics)
		GitBlock = u.insert(GitBlock, Git)
		MacroRecordingBlock = u.insert(MacroRecordingBlock, MacroRecording)
		ScrollBarBlock = u.insert(ScrollBarBlock, ScrollBar)

		InactiveStatusline = {
			condition = function()
				conditions.buffer_matches(status_inactive)
			end,
			provider = function()
				return "%="
			end,
			hl = function()
				if conditions.is_active() then
					return { bg = active_background_color }
				else
					return { bg = inactive_background_color }
				end
			end,
		}

		local ShowCmd = {
			condition = function()
				return vim.o.cmdheight == 0
			end,
			provider = "%1.5(%S%)",
			hl = function(self)
				return { bold = true, fg = self:mode_color() }
			end,
		}

		ViMode = utils.surround({ "", "" }, utils.get_highlight("Folded").bg, { MacroRecording, ViMode, ShowCmd })

		local LSPActive = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach", "WinEnter" },
			provider = function()
				local names = {}
				for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " [" .. table.concat(names, " ") .. "]"
			end,
			hl = { fg = colors.springGreen, bold = true },
			on_click = {
				name = "heirline_LSP",
				callback = function()
					vim.schedule(function()
						vim.cmd("LspInfo")
					end)
				end,
			},
		}

		ActiveStatusline = {
			condition = function()
				return not conditions.buffer_matches(status_inactive)
			end,
			ViMode,
			GitBlock,
			Align,
			LSPActive,
			Space,
			DiagnosticsBlock,
			ScrollBarBlock,
			hl = function()
				if conditions.is_active() then
					return { bg = active_background_color }
				else
					return { bg = inactive_background_color }
				end
			end,
		}

		local StatusLines = {
			static = {
				mode_colors = {
					n = colors.samuraiRed,
					i = colors.autumnGreen,
					v = colors.springBlue,
					V = colors.springBlue,
					["\22"] = colors.dragonBlue,
					c = colors.surimiOrage,
					s = colors.oniViolet,
					S = colors.oniViolet,
					["\19"] = colors.oniViolet,
					R = colors.surimiOrage,
					r = colors.surimiOrage,
					["!"] = colors.samuraiRed,
					t = colors.springGreen,
				},
				mode_color = function(self)
					local mode = conditions.is_active() and vim.fn.mode() or "n"
					return self.mode_colors[mode]
				end,
			},
			condition = function()
				for _, c in ipairs(cmdtype_inactive) do
					if vim.fn.getcmdtype() == c then
						return false
					end
				end
				return true
			end,
			InactiveStatusline,
			ActiveStatusline,
		}

		ActiveWinbar = {
			condition = function()
				local empty_buffer = function()
					return bo.ft == "" and bo.buftype == ""
				end
				return not empty_buffer()
			end,
			Align,
			u.insert(ActiveBlock, FileNameBlock),
		}

		local WinBars = {
			{
				condition = function()
					return not conditions.buffer_matches(winbar_inactive, 0)
				end,
				u.insert(Navic),
			},
			u.insert(ActiveWindow, ActiveWinbar),
		}

		heirline.setup({
			statusline = StatusLines,
			winbar = WinBars,
			opts = {
				disable_winbar_cb = function(args)
					return conditions.buffer_matches(winbar_inactive, args.buf)
				end,
			},
		})
	end,
}
