-- Set up the monitor
local monitor = peripheral.find("monitor")
monitor.setTextScale(0.5)
monitor.clear()

-- GUI functions
local function clearScreen()
  monitor.clear()
  monitor.setCursorPos(1, 1)
end

local function drawMenu()
  clearScreen()
  monitor.write("1. List files")
  monitor.setCursorPos(1, 3)
  monitor.write("2. Read file")
  monitor.setCursorPos(1, 5)
  monitor.write("3. Write file")
  monitor.setCursorPos(1, 7)
  monitor.write("4. Delete file")
  monitor.setCursorPos(1, 9)
  monitor.write("5. Exit")
end

local function getInput()
  local event, side, x, y = os.pullEvent("monitor_touch")
  return y / 2
end

-- File system functions
local function listFiles()
  local files = fs.list("/")
  clearScreen()
  for _, file in ipairs(files) do
    monitor.write(file .. "\n")
  end
end

local function readFile()
  clearScreen()
  monitor.write("Enter file name:")
  local file = read()
  if fs.exists(file) then
    clearScreen()
    monitor.write(fs.open(file, "r").readAll())
  else
    monitor.write("File does not exist.")
  end
end

local function writeFile()
  clearScreen()
  monitor.write("Enter file name:")
  local file = read()
  clearScreen()
  monitor.write("Enter file content:")
  local content = read()
  local handle = fs.open(file, "w")
  handle.write(content)
  handle.close()
  monitor.write("File written successfully.")
end

local function deleteFile()
  clearScreen()
  monitor.write("Enter file name:")
  local file = read()
  if fs.exists(file) then
    fs.delete(file)
    monitor.write("File deleted successfully.")
  else
    monitor.write("File does not exist.")
  end
end

-- Main loop
while true do
  drawMenu()
  local option = getInput()
  
  if option == 1 then
    listFiles()
  elseif option == 2 then
    readFile()
  elseif option == 3 then
    writeFile()
  elseif option == 4 then
    deleteFile()
  elseif option == 5 then
    break
  end
  
  os.pullEvent("monitor_touch")
end
