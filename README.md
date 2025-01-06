# ChatGptNvim

ChatGptNvim is a Neovim plugin that integrates ChatGPT to enhance your coding experience with AI-powered suggestions, completions, and refactoring.

## Functions

- **ChatGptCodeCompletion**: Generate code completions based on selected context.
- **ChatGptCustomInstruction**: Provide custom instructions to ChatGPT for a selected block.
- **ChatGptRefactor**: Refactor the selected block of code using ChatGPT.

## Key Mappings

- `<leader>ci`: Trigger **ChatGptCustomInstruction** for the selected block.
- `<leader>cc`: Trigger **ChatGptCodeCompletion** for the selected context.
- `<leader>cr`: Trigger **ChatGptRefactor** for the selected block.

For all commands:
- A popup window will display the **original context** (left) and **updated block** (right).
- Press `Ctrl + Y` in the popup to accept and apply changes.

## Configuration Options

- `model`: Specify the ChatGPT model (default: `"gpt-4o-mini"`).
- `screenPercentage`: Set popup size as a percentage of the screen (default: `80%`).
- `defaultPrompt`: Provide a custom default prompt. The plugin uses its own default if not set.

To configure, use the `setup` function:
```lua
require('chatgptnvim').setup({
    model = "gpt-4",
    screenPercentage = 90,
    defaultPrompt = "Improve the code with best practices:",
})
```

## Installation

### Neovim (with Plugin Managers)

#### Using Packer
Add the following to your `init.lua` or `plugins.lua`:
```lua
use {
    'yuyudhan/ChatGptNvim',
    config = function()
        require('chatgptnvim').setup({
            model = "gpt-4",
            screenPercentage = 90,
            defaultPrompt = "Improve the code with best practices:",
        })
    end
}
```

#### Using Vim-Plug
Add this to your `.vimrc` or `init.vim`:
```vim
Plug 'yuyudhan/ChatGptNvim'
lua << EOF
require('chatgptnvim').setup({
    model = "gpt-4",
    screenPercentage = 90,
    defaultPrompt = "Improve the code with best practices:",
})
EOF
```

#### Using Lazy.nvim
Add this to your lazy plugins list:
```lua
{
    'yuyudhan/ChatGptNvim',
    config = function()
        require('chatgptnvim').setup({
            model = "gpt-4",
            screenPercentage = 90,
            defaultPrompt = "Improve the code with best practices:",
        })
    end
}
```

### Vim (Manual Installation)

1. Clone the repository:
   ```bash
   git clone https://github.com/yuyudhan/ChatGptNvim ~/.vim/pack/plugins/start/ChatGptNvim
   ```

2. Add the following Lua code to your `.vimrc`:
   ```vim
   lua << EOF
   require('chatgptnvim').setup({
       model = "gpt-4",
       screenPercentage = 90,
       defaultPrompt = "Improve the code with best practices:",
   })
   EOF
   ```

With this, ChatGptNvim is ready to enhance your Neovim or Vim setup with AI-powered capabilities.
```

