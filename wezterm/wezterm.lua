local wezterm = require 'wezterm'

function get_script_path()
  local status, err = pcall(function () error("") end)
  local index = string.find(err, ":")
  if index == nil then
    return err
  else
    return string.sub(err, 1, index - 1)
  end
end


local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Solarized (dark) (terminal.sexy)'
config.font = wezterm.font_with_fallback { 'MesloLGS NF', 'D2Coding' }
config.font_size = 15

config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
}

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollToPrompt(1) },
  { key = 'UpArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(1) },
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.Multiple {
      wezterm.action.DetachDomain { DomainName = 'rachel' },
      wezterm.action.AttachDomain 'rachel',
    },
  },
}

config.unix_domains = {
  {
    name = 'unix',
  }
}

config.ssh_domains = {
  {
    name = 'rachel',
    remote_address = '192.168.0.2',
    username = 'pi',
  },
}

wezterm.on('user-var-changed', function(window, pane, name, value)
  if name == "__OPEN_URI" then
    local chrome_profile = pane:get_user_vars().CHROME_PROFILE
    if chrome_profile == nil then
      wezterm.run_child_process{wezterm.home_dir .. "/bin/chrome", value}
    else
      wezterm.run_child_process{wezterm.home_dir .. "/bin/chrome", "--profile-email=" .. chrome_profile, value}
    end
  end
end)

local status, err = pcall(function() require('corp.wezterm')(config, wezterm) end)
if not status and not string.find(err, [[module 'corp.wezterm' not found]]) then
  error(err)
end

return config

-- vim: set ts=2 sw=2 et:
