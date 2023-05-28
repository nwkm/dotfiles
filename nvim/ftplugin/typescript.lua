local config = require("plugins.dap.configurations")
if not config then
  return
end
config.config_typescript()