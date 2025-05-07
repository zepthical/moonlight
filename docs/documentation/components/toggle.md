# Toggle

On this page
[[toc]]

## Toggle
### Create Toggle
```lua
local Toggle = Tab:Toggle({
    Title = "Toggle",
    Desc = "Toggle Desc",
    Value = true,
    Callback = function(state)
        print(state)
    end,
})
```

### Edit Toggle
- SetTitle()
```lua
Toggle:SetTitle("New Title!")
```
- SetDesc()
```lua
Toggle:SetDesc("New Description!")
```

- SetValue()
```lua
Toggle:SetValue(true)
```