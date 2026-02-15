local system = require("config.system")
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

if system:isLinux()
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
