# Button

On this page
[[toc]]

## Button
### Create Button
```lua
local Button = Tab:Button({
    Title = "Button",
    Desc = "Button Desc",
    Callback = function()
        print("Clicked!")
    end,
})
```

### Edit Button
- SetTitle()
```lua
Button:SetTitle("New Title!")
```
- SetDesc()
```lua
Button:SetDesc("New Description!")
```