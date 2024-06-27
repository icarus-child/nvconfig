local harpoon = require("harpoon")
local options = {}

harpoon:setup(options)

-- Basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

-- Keymaps
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to harpoon list" })
-- vim.keymap.set("n", "<leader>fn", function() toggle_telescope(harpoon:list()) end, { desc = "Toggle harpoon menu" })
vim.keymap.set("n", "<leader>fn", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon menu" })

vim.keymap.set("n", "<localleader>a", function() harpoon:list():select(1) end, { desc = "Select harpoon slot 1" })
vim.keymap.set("n", "<localleader>s", function() harpoon:list():select(2) end, { desc = "Select harpoon slot 2" })
vim.keymap.set("n", "<localleader>d", function() harpoon:list():select(3) end, { desc = "Select harpoon slot 3" })
vim.keymap.set("n", "<localleader>f", function() harpoon:list():select(4) end, { desc = "Select harpoon slot 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<M-p>", function() harpoon:list():prev() end, { desc = "Next harpoon buffer" })
vim.keymap.set("n", "<M-n>", function() harpoon:list():next() end, { desc = "Previous harpoon buffer" })
