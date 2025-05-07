# Dropdown

On this page
[[toc]]

## Dropdown
### Create Dropdown
```lua
local Dropdown = Tab:Dropdown({
    Title = "Dropdown",
    Desc = "Dropdown Desc",
    Value = "Tab 1",
    Multi = false,
    AllowNone = true,
    Values = {
        "Tab 1", "Tab 2", "Tab 3", "Tab 4", "Tab 5", "Tab 6", "Tab 7", "Tab 8", "Tab 9", "Tab 10",
        "Tab 11", "Tab 12", "Tab 13", "Tab 14", "Tab 15", "Tab 16", "Tab 17", "Tab 18", "Tab 19", "Tab 20"
    },
    Callback = function(Tab)
        print(tab)
    end
})
```

### Edit Dropdown
- SetTitle()
    ```lua
    Dropdown:SetTitle("New Title!")
    ```
- SetDesc()
    ```lua
    Dropdown:SetDesc("New Description!")
    ```

- Refresh()
    ```lua
    Dropdown:Refresh({
        "Tab 1", "Tab 2"
    })
    ```

- Select()

    No Multi
    ```lua
    Dropdown:Select("Tab 2")
    ```

    Multi
    ```lua
    Dropdown:Select({
        "Tab 2", "Tab 3"
    })
    ```