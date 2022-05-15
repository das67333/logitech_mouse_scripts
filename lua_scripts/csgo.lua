EnablePrimaryMouseButtonEvents(true);
activation_button = 3

weapons = {
  ak47  = {fire_rate = 600, magazine_capacity = 30, color = {r = 255, g = 255, b =   0}, recoil = {
    {  0,  0}, { -2,  4}, {  2, 18}, { -3, 30}, {  0, 31}, { 11, 29}, {  8, 28}, { 14, 21}, {-17, 15}, {-40, -5},
    {-21,  3}, { 12, 12}, {-17,  4}, {-23, -9}, { -5,  5}, { 37,  4}, { 20,  8}, { 17,  4}, { 24,  0}, { 33, -9},
    {-18,  4}, {  5, -1}, { -9,  4}, { -5,  8}, { 14, -1}, {  6, -2}, {-15,  0}, {-30,  0}, {-44,-14}, {-16, -3},
    },
  },
  m4a4  = {fire_rate = 666, magazine_capacity = 30, color = {r =   0, g = 192, b = 255}, recoil = {
    {  0,  0}, {  1,  6}, {  0, 10}, { -4, 16}, {  4, 20}, { -6, 24}, { -4, 28}, { 14, 13}, { 11, 15}, { 22,  6},
    { -6,  8}, {-17,  5}, {-27,  0}, {-24, -8}, {-27, -2}, { -1,  4}, {  8,  7}, {-12,  2}, {-12, -6}, {  3,  1},
    { 30,  4}, { 13,  3}, { 25,  1}, { 11,  2}, { 11,  5}, {-10,  3}, {  6,  0}, {  2,  0}, {  2,  6}, {  6,  1},
    },
  },
  m4a1s = {fire_rate = 600, magazine_capacity = 25, color = {r =   0, g =   0, b = 255}, recoil = {
    {  0,  0}, {  0,  3}, {  0,  3}, { -2, 13}, {  3, 17}, { -4, 18}, { -3, 20}, { 11, 14}, {  7, 11}, { 16,  1},
    { -5,  6}, {-13,  7}, {-22, -1}, {-17, -1}, {-17, -7}, {  0,  5}, {  7,  6}, { -7,  0}, {-10, -4}, {  2,  1},
    { 25,  3}, {  9,  4}, { 19, -1}, {  6,  0}, {  6,  4},
    },
  },
}

is_activated = false


function OnEvent(event, arg)
    time_start = GetRunningTime()
    if event == "MOUSE_BUTTON_PRESSED" then
      if arg == activation_button then
        is_activated = not is_activated
      elseif is_activated then
        if arg == 1 then
          if IsKeyLockOn("capslock") then
            compensate_recoil(weapons["m4a1s"])
          else
            compensate_recoil(weapons["ak47"])
          end
        end
      end
    end
    --OutputLogMessage("%.3f sec\t%-30s%d\n", (GetRunningTime() - time_start)/1000, event, arg)
end


--Logitech will implement SetBacklightColor() someday 
--function set_backlight_color(color)
--    SetBacklightColor(color["r"], color["g"], color["b"])
--end


function wait_till(time)
    while GetRunningTime() < time_start + time do end
end


--sensitivity is about 2.10
function compensate_recoil_rude(weapon)
    local shot_number = 25
    local delay = 60000 / weapon["fire_rate"]
    local i = 1
    while not (i == weapon["magazine_capacity"]) do
        wait_till((i - 1) * delay + 30)
        i = i + 1
        MoveMouseRelative(weapon["recoil"][i][1], weapon["recoil"][i][2])
        --if i == 2 then MoveMouseRelative(50, 0) end
        --if i == shot_number then MoveMouseRelative(-50, 0) end
        --if i == shot_number + 1 then MoveMouseRelative(50, 0) end
        if not IsMouseButtonPressed(1) then break end
    end
    while IsMouseButtonPressed(1) do end
end


--sensitivity is about 2.22
function compensate_recoil(weapon)
    local smoothness = 4
    local delay = 60000 / weapon["fire_rate"] / smoothness
    local i, j = 1, 1
    local x, y, dx, dy
    while not (i == weapon["magazine_capacity"] and j == 1) do
        if j == 1 then
          j = smoothness
          i = i + 1
          x = weapon["recoil"][i][1]
          y = weapon["recoil"][i][2]
        else
          j = j - 1
        end
        wait_till(((i - 1) * smoothness - j + 1) * delay)
        dx = x / j
        dy = y / j
        MoveMouseRelative(dx, dy)
        x = x - dx
        y = y - dy
        if not IsMouseButtonPressed(1) then break end
    end
    while IsMouseButtonPressed(1) do end
end


function autoclick(delay)
    local i = 1
    while true do
      PressAndReleaseMouseButton(1)
      Sleep(delay)
      i = i + 1
      if IsModifierPressed("alt") then break end
    end
end
