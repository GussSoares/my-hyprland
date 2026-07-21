----------------------
---- WINDOW RULES ----
----------------------

-- Regras comentadas do Garuda Assistant e outras ferramentas
local floating_800_600 = { 
    "update-floating", "bluetui-floating", "files-floating", 
}

for _, app in ipairs(floating_800_600) do
    hl.window_rule({
        match = { class = app },
        float = true,
        size = "800 600"
    })
end

hl.window_rule({
    match = { class = ".*-floating$" },
    float = true,
    size = "800 800",
    center = true
})

-- Regras de Opacidade e Blur
hl.window_rule({
    name = "opacity-rules",
    match = { class = "(thunar|gedit|catfish)" },
    -- opacity = { 0.85, 0.85 }
})
