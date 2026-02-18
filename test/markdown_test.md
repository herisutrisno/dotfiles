## Tasks Overview

| Task ID | Task Name            | Status      | Priority |
| ------- | -------------------- | ----------- | -------- |
| 1       | Setup repo           | Done        | High     |
| 2       | Implement core logic | In Progress | Medium   |
| 3       | Write tests          | Pending     | High     |
| 4       | Deploy to server     | Pending     | Low      |

## Todo Checklist

- [x] Initialize Git repository
- [ ] Implement add/edit/delete functions
- [-] Refactor core logic

## Sample Code

```python
def add_task(tasks, title):
    task = {"title": title, "done": False}
    tasks.append(task)
    return tasks

tasks = []
tasks = add_task(tasks, "Write documentation")
print(tasks)
```

# 1. Headers (H1)

## 2. Headers (H2)

### 3. Headers (H3)

#### 4. Headers (H4)

##### 5. Headers (H5)

###### 6. Headers (H6)

---

## 7. Emphasis & Text Styling

_This text is italic_  
_This text is also italic_  
**This text is bold**  
**This text is also bold**  
**_This text is bold and italic_**  
~~This text is strikethrough~~

---

## 8. Lists (Ordered & Unordered)

- Generic Bullet 1
- Generic Bullet 2
  - Nested Bullet A
  - Nested Bullet B

1. First ordered item
2. Second ordered item
   1. Sub-item 1
   2. Sub-item 2

---

## 9. Task Lists (GFM)

- [ ] This is an incomplete task
- [x] This is a completed task
- [ ] ~~This is a cancelled task~~

---

## 10. Links & Images

[GitHub Home Page](https://github.com)  
[Internal Reference to Headers](#1-headers-h1)

Inline image: ![Neovim Logo](https://neovim.io)

---

## 11. Blockquotes & Callouts (GitHub Alerts)

> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goals.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Negative potential consequences of an action.

---

## 12. Code Blocks (Syntax Highlighting)

Inline code: `local x = "Hello World"`

```lua
-- This should be highlighted by Treesitter
local function greet(name)
  print("Hello, " .. name)
end

greet("Neovim User")
```
