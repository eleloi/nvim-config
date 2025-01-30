local gemini_prompt = [[
You are the backend of an AI-powered code completion engine. Your task is to
provide code suggestions based on the user's input. The user's code will be
enclosed in markers:

- `<contextAfterCursor>`: Code context after the cursor
- `<cursorPosition>`: Current cursor location
- `<contextBeforeCursor>`: Code context before the cursor
]]

local gemini_few_shots = {}

gemini_few_shots[1] = {
	role = "user",
	content = [[
# language: python
<contextBeforeCursor>
def fibonacci(n):
    <cursorPosition>
<contextAfterCursor>

fib(5)]],
}

local gemini_chat_input_template =
	"{{{language}}}\n{{{tab}}}\n<contextBeforeCursor>\n{{{context_before_cursor}}}<cursorPosition>\n<contextAfterCursor>\n{{{context_after_cursor}}}"

return {
	{
		"milanglacier/minuet-ai.nvim",
		event = "VeryLazy",
		config = function()
			gemini_few_shots[2] = require("minuet.config").default_few_shots[2]

			require("minuet").setup({
				cmp = { enable_auto_complete = false },
				blink = { enable_auto_complete = false },
				debounce = 100,
				n_completions = 5,
				-- If completion item has multiple lines, create another completion item
				-- only containing its first line. This option only has impact for cmp and
				-- blink. For virtualtext, no single line entry will be added.
				add_single_line_entry = false,
				virtualtext = {
					auto_trigger_ft = {},
					keymap = {
						-- accept whole completion
						accept = "<A-L>",
						-- accept one line
						accept_line = "<A-l>",
						-- accept n lines (prompts for number)
						accept_n_lines = nil,
						-- Cycle to prev completion item, or manually invoke completion
						prev = "<A-k>",
						-- Cycle to next completion item, or manually invoke completion
						next = "<A-j>",
						dismiss = "<A-e>",
					},
				},
				provider = "gemini",
				provider_options = {
					gemini = {
						model = "gemini-2.0-flash-exp",
						system = { prompt = gemini_prompt },
						few_shots = gemini_few_shots,
						chat_input = { template = gemini_chat_input_template },
						optional = {
							generationConfig = {
								maxOutputTokens = 256,
								topP = 0.9,
							},
							safetySettings = {
								{
									category = "HARM_CATEGORY_DANGEROUS_CONTENT",
									threshold = "BLOCK_NONE",
								},
								{
									category = "HARM_CATEGORY_HATE_SPEECH",
									threshold = "BLOCK_NONE",
								},
								{
									category = "HARM_CATEGORY_HARASSMENT",
									threshold = "BLOCK_NONE",
								},
								{
									category = "HARM_CATEGORY_SEXUALLY_EXPLICIT",
									threshold = "BLOCK_NONE",
								},
							},
						},
					},
				},
			})
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
		opts = {
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			provider = "claude",
			mappings = {
				--- @class AvanteConflictMappings
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]x",
					prev = "[x",
				},
				suggestion = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
				jump = {
					next = "]]",
					prev = "[[",
				},
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				sidebar = {
					apply_all = "A",
					apply_cursor = "a",
					switch_windows = "<Tab>",
					reverse_switch_windows = "<S-Tab>",
				},
			},
		},
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
		},
	},
}
