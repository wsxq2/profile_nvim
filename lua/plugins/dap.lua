return {
  {
    "jedrzejboczar/nvim-dap-cortex-debug",
    dependencies = { "mfussenegger/nvim-dap" },
    -- 在此处直接初始化DAP配置
    config = true,
    opts = {
      -- add your options that should be passed to the setup() function here
      debug = false, -- log debug messages
      -- path to cortex-debug extension, supports vim.fn.glob
      -- by default tries to guess: mason.nvim or VSCode extensions
      extension_path = nil,
      lib_extension = nil, -- shared libraries extension, tries auto-detecting, e.g. 'so' on unix
      node_path = "node", -- path to node.js executable
      dapui_rtt = false, -- register nvim-dap-ui RTT element
      -- make :DapLoadLaunchJSON register cortex-debug for C/C++, set false to disable
      dap_vscode_filetypes = { "c", "cpp" },
      rtt = {
        buftype = "Terminal", -- 'Terminal' or 'BufTerminal' for terminal buffer vs normal buffer
      },
    },
  },
}
