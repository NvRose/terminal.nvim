<h3 align=center> NvRose - terminal </h3>

### Installation

```lua
use {
	"NvRose/terminal.nvim",
 	config = function()
		require("terminal").setup()
	end
}
```

### Configuration

```lua
require('terminal').setup {
	shell = vim.o.shell,
	resize = 15,
   	orientation = "horizontal",
    	keybinds = {
		-- Inside terminal
		inside = {
			["<c-\\>"] = term.close,
		},
		-- In normal mode
		outside = {
			["<c-\\>"] = term.new
		}
    	},
    	behavior = {
		close_on_exit = true,
	   	auto_insert = true
    	}
}
```

### 📜 License
NvRose is released under own license, which grants the following permissions:
- Commercial use
- Distribution
- Modification
- Private use
For more details see [license](https://github.com/NvRose/terminal/license).
