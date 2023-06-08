-- Set up the monitor
local monitor = peripheral.find("monitor")
monitor.setTextScale(1)
monitor.clear()

-- Set up the computer terminal
local term = term.redirect(monitor)

-- GUI functions
local function clearScreen()
  term.setBackgroundColor(colors.black)
  term.clear()
  term.setCursorPos(1, 1)
end

local function drawClock()
  clearScreen()
  local time = textutils.formatTime(os.time(), true)
  local x = math.floor((monitor.getSize() - string.len(time)) / 2)
  local y = math.floor((monitor.getHeight() - 1) / 2)
  term.setCursorPos(x, y)
  term.setTextColor(colors.white)
  term.write(time)
end

local function drawEditor()
  clearScreen()
  term.setCursorPos(1, 1)
  term.setTextColor(colors.white)
  term.write("=== File Editor ===")
  term.setCursorPos(1, 3)
  term.write("Enter file name:")
  local filename = read()
  clearScreen()
  term.setCursorPos(1, 1)
  term.setTextColor(colors.white)
  term.write("=== File Editor ===")
  term.setCursorPos(1, 3)
  term.write("Enter file content:")
  local content = read()
  fs.open(filename, "w").write(content)
  clearScreen()
  term.setTextColor(colors.green)
  term.write("File saved successfully.")
  sleep(2)
end

-- Main loop
while true do
  drawClock()
  
  local event, side, x, y = os.pullEvent("monitor_touch")
  if x >= 1 and x <= 5 and y == 1 then
    drawEditor()
  end
end

-- Clear the screen before exiting
clearScreen()
term.restore()
