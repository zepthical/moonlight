# Input

On this page
[[toc]]

## Input
### Create Input
```lua
local Input = Tab:Input({
    Title = "Input",
    Desc = "Input",
    Value = "Text Hello",
    PlaceholderText = "Enter your message...",
    ClearTextOnFocus = false,
    Callback = function(Text)
        print(Text)
    end
})
```

### Edit Input
- SetTitle()
```lua
Input:SetTitle("New Title!")
```
- SetDesc()
```lua
Input:SetDesc("New Description!")
```