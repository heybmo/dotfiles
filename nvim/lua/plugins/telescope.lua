local telescope = require('telescope')
local actions = require('telescope.actions')
local themes = require('telescope.themes')

telescope.load_extension('live_grep_args')

-- Credit to @awwalker
local width_for_nopreview = function(_, cols, _)
	if cols > 200 then
		return math.floor(cols * 0.5)
	elseif cols > 110 then
		return math.floor(cols * 0.6)
	else
		return math.floor(cols * 0.75)
	end
end

local height_dropdown_nopreview = function(_, _, rows)
	return math.floor(rows * 0.7)
end

telescope.setup({
  prompt_prefix = '🔍 ',
  file_ignore_patterns = {
      '.git/',
      'target/',
      -- 'docs/',
      'vendor/*',
      '%.lock',
      '__pycache__/*',
      '%.sqlite3',
      '%.ipynb',
      'node_modules/*',
      -- '%.jpg',
      -- '%.jpeg',
      -- '%.png',
      '%.svg',
      '%.otf',
      '%.ttf',
      '%.webp',
      '.dart_tool/',
      '.github/',
      '.gradle/',
      '.idea/',
      -- '.settings/',
      -- '.vscode/',
      '__pycache__/',
      -- 'build/',
      -- 'env/',
      'gradle/',
      'node_modules/',
      '%.pdb',
      '%.dll',
      '%.class',
      '%.exe',
      '%.cache',
      '%.ico',
      '%.pdf',
      '%.dylib',
      '%.jar',
      '%.docx',
      '%.met',
      'smalljre_*/*',
      '.vale/',
      '%.burp',
      '%.mp4',
      '%.mkv',
      '%.rar',
      '%.zip',
      '%.7z',
      '%.tar',
      '%.bz2',
      '%.epub',
      '%.flac',
      '%.tar.gz',
    },
  set_env = { ['COLORTERM'] = 'truecolor' },
  mappings = {
    i = {
      ['<C-j>'] = actions.move_selection_next,
      ['<C-k>'] = actions.move_selection_previous,

      ['<C-b>'] = actions.results_scrolling_up,
      ['<C-f>'] = actions.results_scrolling_down,

      ['<C-c>'] = actions.close,

      ['<Down>'] = actions.move_selection_next,
      ['<Up>'] = actions.move_selection_previous,

      ['<CR>'] = actions.select_default,
      ['<C-s>'] = actions.select_horizontal,
      ['<C-v>'] = actions.select_vertical,
      ['<C-t>'] = actions.select_tab,
      ['<C-d>'] = actions.delete_buffer,
    },
    n = {
      ["<esc>"] = actions.close,
      ["<CR>"] = actions.select_default,
      ["j"] = actions.move_selection_next,
      ["k"] = actions.move_selection_previous,
      ["H"] = actions.move_to_top,
      ["M"] = actions.move_to_middle,
      ["L"] = actions.move_to_bottom,
      ["q"] = actions.close,
      ["dd"] = require("telescope.actions").delete_buffer,
      ["s"] = actions.select_horizontal,
      ["v"] = actions.select_vertical,
      ["t"] = actions.select_tab,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["gg"] = actions.move_to_top,
      ["G"] = actions.move_to_bottom,

      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,

      ["?"] = actions.which_key,
    },
  },
  extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "ignore_case", -- or "ignore_case" or "respect_case" or "smart_case"
		},
		live_grep_args = {},
		["ui-select"] = {
			themes.get_cursor({}),
		},
	},
  pickers = {
    buffers = {
			previewer = false,
			sort_lastused = true,
			sort_mru = true,
			show_all_buffers = true,
			layout_config = {
				width = width_for_nopreview,
				height = height_dropdown_nopreview,
			},
			mappings = {
				n = {
					['<c-d>'] = actions.delete_buffer,
				},
			},
		},
		find_files = {
			find_command = { 'fd', '--glob', '--strip-cwd-prefix', '--type=f', '--hidden', '--no-ignore' },
		},
		lsp_code_actions = {
			theme = 'cursor',
			previewer = false,
			layout_config = {
				width = width_for_nopreview,
				height = height_dropdown_nopreview,
			},
		},
  },
})

