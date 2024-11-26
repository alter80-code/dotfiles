local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end
config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 14
config.window_decorations = "RESIZE"
config.enable_wayland = false 
config.leader = { key = "z", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{key="3", mods="CTRL|ALT", action=wezterm.action.SendString("@")},
	{key="4", mods="CTRL|ALT", action=wezterm.action.SendString("#")},
	{key="5", mods="CTRL|ALT", action=wezterm.action.SendString("[")},
	{key="6", mods="CTRL|ALT", action=wezterm.action.SendString("]")},
	{key="7", mods="CTRL|ALT", action=wezterm.action.SendString("{")},
	{key="8", mods="CTRL|ALT", action=wezterm.action.SendString("}")},
	{
    key = "ù",
    mods = "LEADER",
    action = wezterm.action.ActivateCopyMode,
  },
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    mods = "LEADER",
    key = "b",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = "LEADER",
    key = "n",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    mods = "LEADER",
    key = "à",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    mods = "LEADER",
    key = "ò",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    mods = "LEADER",
    key = "LeftArrow",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    mods = "LEADER",
    key = "DownArrow",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    mods = "LEADER",
    key = "UpArrow",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    mods = "LEADER",
    key = "RightArrow",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    key = "LeftArrow",
    mods = "SHIFT",
    action = wezterm.action.AdjustPaneSize { "Left", 1 },
  },
  {
    key = "RightArrow",
    mods = "SHIFT",
    action = wezterm.action.AdjustPaneSize { "Right", 1 },
  },
  {
    key = "UpArrow",
    mods = "SHIFT",
    action = wezterm.action.AdjustPaneSize { "Up", 1 },
  },
  {
    key = "DownArrow",
    mods = "SHIFT",
    action = wezterm.action.AdjustPaneSize { "Down", 1 },
  },
  {
    key = "Home",
    mods = "SHIFT",
    action = wezterm.action.Multiple {
      wezterm.action.ActivateCopyMode,
      wezterm.action.CopyMode("MoveToStartOfLine"),
    },
  },
  {
    key = "End",
    mods = "SHIFT",
    action = wezterm.action.Multiple {
      wezterm.action.ActivateCopyMode,
      wezterm.action.CopyMode("MoveToEndOfLineContent"),
    },
  },
  {
    key = "LeftArrow",
    mods = "CTRL",
    action = wezterm.action.CopyMode("MoveBackwardWord"),
  },
  {
    key = "RightArrow",
    mods = "CTRL",
    action = wezterm.action.CopyMode("MoveForwardWord"),
  },
}

for i = 0, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i),
  })
end

-- Mappatura delle chiavi per la navigazione in modalità Vi
-- Abilitare la modalità Vi in modalità copia

-- config.enable_vi_mode = true

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.tab_and_split_indices_are_zero_based = true


wezterm.on("update-right-status", function(window, _)
  local SOLID_LEFT_ARROW = ""
  local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
  local prefix = ""

  if window:leader_is_active() then
    prefix = " " .. utf8.char(0x1f30a)
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then
    ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
  end

  window:set_left_status(wezterm.format {
    { Background = { Color = "#b7bdf8" } },
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW },
  })
end)

return config

