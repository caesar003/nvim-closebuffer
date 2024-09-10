# Nvim CloseBuffer

```
    _   __      _                      __                __          ________         
   / | / /   __(_)___ ___        _____/ /___  ________  / /_  __  __/ __/ __/__  _____
  /  |/ / | / / / __ `__ \______/ ___/ / __ \/ ___/ _ \/ __ \/ / / / /_/ /_/ _ \/ ___/
 / /|  /| |/ / / / / / / /_____/ /__/ / /_/ (__  )  __/ /_/ / /_/ / __/ __/  __/ /    
/_/ |_/ |___/_/_/ /_/ /_/      \___/_/\____/____/\___/_.___/\__,_/_/ /_/  \___/_/     
                                                                                      
```

## Overview

Have you ever been frustrated by Vim's behavior when closing buffers, where your carefully arranged split window layout gets ruined? You’re not alone. **Vim CloseBuffer** is a plugin designed to help you close buffers without disrupting your window layout, making your Vim experience smoother and more efficient.

## Why Use Vim CloseBuffer?

When you close a buffer in Vim using the default commands, Vim can sometimes close the window as well, collapsing your split layout and leaving you with a disorganized workspace. This plugin prevents that by allowing you to close buffers without affecting the current window arrangement.

## Installation

To install the Nvim CloseBuffer plugin, you can use any popular Neovim plugin manager. Here’s how to install it with [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
return {
  -- other plugins
  { 'caesar003/nvim-closebuffer' },
}
```

Alternatively, if you’re using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use { 'caesar003/nvim-closebuffer' }
```

Once you’ve added it to your configuration, run your plugin manager’s install command, such as `:PackerInstall` or `:Lazy sync`.

## Usage

After installing the plugin, you can use the following command to safely close your buffers:

```lua
:CloseBuffer
```

This command provides an interactive prompt if there are unsaved changes, allowing you to save, discard, or cancel the close operation. It ensures that your split layout remains intact, no matter how you choose to handle the buffer.

## Custom Mappings

You can define convenient mappings to make using the plugin even easier. For example, add the following to your Neovim configuration to map `CloseBuffer` to `<leader>c`:

With `lazy.nvim`:

```lua
return {
  -- other plugins
  {
    "caesar003/nvim-closebuffer",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>c", ":CloseBuffer<CR>", { noremap = true, silent = true, desc = "Close Buffer" })
    end,
  },
}
```

Or with `packer.nvim`:

```lua
use {
  'caesar003/nvim-closebuffer',
  config = function()
    vim.api.nvim_set_keymap("n", "<leader>c", ":CloseBuffer<CR>", { noremap = true, silent = true, desc = "Close Buffer" })
  end
}
```

Feel free to customize the mapping to suit your preferred keybindings.

## Contributing

If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request on GitHub. Contributions are always welcome!

## License

This plugin is open-source and licensed under the [MIT License](LICENSE).

