local wezterm = require 'wezterm'
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local config = wezterm.config_builder()

tabline.setup({
  options = {
    icons_enabled = true,
    theme = 'Catppuccin Mocha',
    tabs_enabled = true,

    section_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
    },
    component_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thin,
      right = wezterm.nerdfonts.ple_left_half_circle_thin,
    },
    tab_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
    },
  },

  sections = {
    tabline_a = {
      { 'mode', icon = wezterm.nerdfonts.cod_terminal },
    },
    tabline_b = {
      { 'workspace', icon = wezterm.nerdfonts.cod_terminal_tmux },
    },
    tabline_c = {
      { 'domain' },
    },

    tab_active = {
      { 'index', zero_indexed = false },
      { 'parent', padding = 0 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 }, max_length = 20 },
      { 'zoomed', padding = 0 },
    },

    tab_inactive = {
      'index',
      { 'process', padding = { left = 0, right = 1 } },
      'output',
    },

    tabline_x = {
      { 'ram', throttle = 5 },
      { 'cpu', throttle = 5 },
    },
    tabline_y = {
      {
        'datetime',
        style = '%H:%M',
        hour_to_icon = {
          ['00'] = wezterm.nerdfonts.md_clock_time_twelve_outline,
          ['12'] = wezterm.nerdfonts.md_clock_time_twelve,
        },
      },
      { 'battery' },
    },
    tabline_z = {
      { 'hostname' },
    },
  },
})

tabline.apply_to_config(config)

config.initial_cols = 216
config.initial_rows = 49
config.font = wezterm.font 'MesloLGL Nerd Font Mono'
config.font_size = 12
config.font = wezterm.font_with_fallback { 'MesloLGL Nerd Font Mono', 'Noto Sans Mono CJK SC', 'Noto Color Emoji' }

config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0
config.scrollback_lines = 1000000
config.enable_scroll_bar = true
config.tab_bar_at_bottom = false

config.window_padding = {
  left = 30, right = 30, top = 30, bottom = 30
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

config.animation_fps = 10
config.audible_bell = "Disabled"
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.command_palette_font_size = 11.0
config.command_palette_fg_color = 'rgba(205, 214, 244, 1.0)'
config.command_palette_bg_color = '#1E1E2E'
config.ui_key_cap_rendering = 'UnixLong'

config.char_select_font_size = 11.0
config.char_select_fg_color = 'rgba(205, 214, 244, 1.0)'
config.char_select_bg_color = "#1E1E2E"

config.clean_exit_codes = { 0, 130, 143 }
config.window_close_confirmation = 'NeverPrompt'

config.ssh_domains = wezterm.default_ssh_domains()

return config

