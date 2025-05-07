# Code

On this page
[[toc]]

## Code
### Create Code
```lua
local Code = Tab:Code({
    Title = "main.lua",
    Locked = false,
    Code = [[-- This is a simple Lua script
print("hello world")
]],
})
```

### Edit Code
```lua
Code:SetCode("print('Welcome')")
```