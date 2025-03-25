local dap_cortex_debug = require("dap-cortex-debug")
local dap = require("dap")
table.insert(
  dap.configurations.c,
  dap_cortex_debug.openocd_config({
    name = "debugging with stlink-v2",
    type = "cortex-debug",
    request = "launch",
    servertype = "stlink",
    serverpath = "st-util",
    gdbPath = "arm-none-eabi-gdb",
    --toolchainPath = "C:/Program Files (x86)/Arm GNU Toolchain arm-none-eabi/12.2 mpacbti-rel1/bin",
    toolchainPrefix = "arm-none-eabi",
    --runToEntryPoint = "main",
    swoConfig = { enabled = false },
    showDevDebugOutput = false,
    --gdbTarget = "localhost:4242",
    cwd = "${workspaceFolder}",
    executable = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
    end,
    --stlinkPath = "C:/Program Files (x86)/stlink-1.7.0-x86_64-w64-mingw32/bin/st-util.exe",
    rttConfig = {
      address = "auto",
      decoders = {
        {
          label = "RTT:0",
          port = 0,
          type = "console",
        },
      },
      enabled = false,
    },
  })
)
