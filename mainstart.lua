-- Initialize the file system
local filesystem = {}

-- File system functions
function filesystem.exists(file)
  return fs.exists(file)
end

function filesystem.read(file)
  local handle = fs.open(file, "r")
  local content = handle.readAll()
  handle.close()
  return content
end

function filesystem.write(file, content)
  local handle = fs.open(file, "w")
  handle.write(content)
  handle.close()
end

function filesystem.delete(file)
  fs.delete(file)
end

-- Command processor
local commands = {}

function commands.help()
  print("Available commands:")
  print("- help: Displays this help message")
  print("- list: Lists all files in the current directory")
  print("- read <file>: Reads the content of a file")
  print("- write <file> <content>: Writes content to a file")
  print("- delete <file>: Deletes a file")
end

function commands.list()
  local files = fs.list(shell.dir())
  for _, file in ipairs(files) do
    print(file)
  end
end

function commands.read(file)
  if filesystem.exists(file) then
    local content = filesystem.read(file)
    print(content)
  else
    print("File does not exist.")
  end
end

function commands.write(file, content)
  filesystem.write(file, content)
  print("File written successfully.")
end

function commands.delete(file)
  if filesystem.exists(file) then
    filesystem.delete(file)
    print("File deleted successfully.")
  else
    print("File does not exist.")
  end
end

-- Command prompt
while true do
  write("> ")
  local input = read()
  local args = {}
  for arg in string.gmatch(input, "%S+") do
    table.insert(args, arg)
  end

  local command = args[1]
  if command == "exit" then
    break
  elseif commands[command] then
    table.remove(args, 1)
    commands[command](unpack(args))
  else
    print("Unknown command. Type 'help' for a list of commands.")
  end
end
