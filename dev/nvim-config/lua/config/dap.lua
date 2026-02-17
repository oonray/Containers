local dap = require("dap")
local ui = require("dapui")
local go = require("dap-go")
local mason = require("mason-nvim-dap")

ui.setup()
go.setup()

--Debug-DAP
dap.listeners.before.attach.dapui_config = function()
    ui.open()
  end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end

mason.setup{
  ensure_installed = {
    "bash-debug-adapter"
    ,"debugpy"
    ,"js-debug-adapter"
    ,"go-debug-adapter"
    ,"stylua"
    ,"netcoredbg"
    },
  handlers = {},
}

if System.linux
then
    dap.adapters.ansible = {
          type = "executable",
          command = "python3",
          args = { "-m", "ansibug", "dap" },
    }
    dap.configurations["yaml.ansible"] = {
      {
        type = "ansible",
        request = "launch",
        name = "Debug playbook",
        playbook = "${file}"
      }
    }
end

-- Secrets
require("nvim-dap-virtual-text").setup {
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
}
