local wezterm = require "wezterm"
local act = wezterm.action

function is_platform(name)
  return string.sub(string.gsub(wezterm.target_triple, "-", "_"), -#name) == name
end

function get_platform_name()
  name, _ = string.gsub(string.match(wezterm.target_triple, "[%w_]+-%a+-([%w-]+)"), "-", "_")
  return name
end

function main()
  global_keys = {
    { key = "phys:Space", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
    { key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
    { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
    { key = "Home", mods = "SHIFT", action = act.ScrollToTop },
    { key = "End", mods = "SHIFT", action = act.ScrollToBottom },
    { key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
    { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo "Clipboard" },
    { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom "Clipboard" },
    { key = "r", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
    { key = "f", mods = "SHIFT|CTRL", action = act.Search "CurrentSelectionOrEmptyString" },
    { key = "=", mods = "CTRL", action = act.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
    { key = "0", mods = "CTRL", action = act.ResetFontSize },
  }
   
  platform_specific = {
    linux_gnu = {
      font_size = 9,
      line_height = 1,
      freetype_load_target = "HorizontalLcd",
      freetype_load_flags = "DEFAULT",
      keys = {},
    },
    darwin = {
      font_size = 12,
      line_height = 1,
      freetype_load_target = "HorizontalLcd",
      freetype_load_flags = "DEFAULT",
      keys = {
        { key = "c", mods = "SUPER", action = act.CopyTo "Clipboard" },
        { key = "v", mods = "SUPER", action = act.PasteFrom "Clipboard" },
        { key = "r", mods = "SUPER", action = act.ReloadConfiguration },
        { key = "f", mods = "SUPER", action = act.Search "CurrentSelectionOrEmptyString" },
        { key = "=", mods = "SUPER", action = act.IncreaseFontSize },
        { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
        { key = "0", mods = "SUPER", action = act.ResetFontSize },
        
        { key = "n", mods = "SUPER", action = act.SpawnWindow },
      },
    },
  }

  name = get_platform_name()
  if platform_specific[name] ~= nil then
    platform_options = platform_specific[name]

    for _, v in pairs(platform_options.keys) do 
      table.insert(global_keys, v) 
    end

    local_config_path = wezterm.glob(wezterm.home_dir .. "/.config/wezterm/local_cfg.lua")
    if #local_config_path == 1 then
      local_config = loadfile(local_config_path[1])()

      for k, v in pairs(local_config) do
        platform_options[k] = v
      end
    end
  else
    wezterm.log_error("Failed to load configuration: unsupported platform => " .. name)
    return {}
  end
    
  return {
    enable_scroll_bar = false,
    
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,

    window_background_opacity = 0.9,
    window_padding = {
      top = "1pt",
      bottom = "1pt",
      left = "1pt",
      right = "1pt",
    },

    color_scheme = "Spring (Gogh)",
    
    font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" }),
    font_rules = {
      {
        intensity = "Bold",
        italic = false,
        font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold" }),
      },
      {
        intensity = "Normal",
        italic = true,
        font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular", italic = true }),
      },
      {
        intensity = "Bold",
        italic = true,
        font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold", italic = true }),
      },
    },
    font_size = platform_options.font_size,

    line_height = platform_options.line_height,
    
    freetype_load_target = platform_options.freetype_load_target,
    freetype_load_flags = platform_options.freetype_load_flags,
    
    disable_default_key_bindings = true,

    keys = global_keys,

    window_close_confirmation = "NeverPrompt",
    exit_behavior = "Close",
  }
end

return main()
