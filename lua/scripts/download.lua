local M = {}

-- 获取特定目录中匹配 *.elf 的第一个文件
function M.get_first_elf_file(directory)
  local uv = vim.loop
  local handle = uv.fs_scandir(directory) -- 扫描指定目录
  while handle do
    local name, type = uv.fs_scandir_next(handle)
    if not name then
      break
    end
    if type == "file" and name:match("%.elf$") then
      local full_path = directory .. "/" .. name -- 拼接目录和文件名
      return full_path -- 返回第一个匹配的 .elf 文件路径
    end
  end
  return nil -- 如果没有匹配的文件，返回 nil
end

function M.flash_firmware(cmake_build_dir, flash_start_addr)
  cmake_build_dir = cmake_build_dir or "build/Debug"
  local cmake_build_elf = M.get_first_elf_file(cmake_build_dir)
  flash_start_addr = flash_start_addr or "0x08000000"

  local Job = require("plenary.job")

  -- Build the project
  Job:new({
    command = "cmake",
    args = { "--build", cmake_build_dir },
    on_exit = function(j, return_val)
      vim.schedule(function()
        if return_val == 0 then
          print("构建成功完成。") -- 构建成功
        else
          print("构建失败: " .. table.concat(j:stderr_result(), "\n")) -- 输出错误信息
        end
      end)
    end,
  }):sync()

  -- Convert ELF to binary
  Job:new({
    command = "arm-none-eabi-objcopy",
    args = { "-O", "binary", "--gap-fill", "0xFF", cmake_build_elf, "output.bin" },
    on_exit = function(j, return_val)
      vim.schedule(function()
        if return_val == 0 then
          print("ELF 文件成功转换为二进制文件。") -- 转换成功
        else
          print("ELF 转换失败: " .. table.concat(j:stderr_result(), "\n")) -- 输出错误信息
        end
      end)
    end,
  }):sync()

  -- Flash the binary
  Job:new({
    command = "st-flash",
    args = { "--reset", "write", "output.bin", flash_start_addr },
    on_exit = function(j, return_val)
      vim.schedule(function()
        if return_val == 0 then
          print("固件烧录成功。") -- 烧录成功
        else
          print("烧录失败: " .. table.concat(j:stderr_result(), "\n")) -- 输出错误信息
        end
      end)
    end,
  }):start()
end

return M
