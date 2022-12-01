weapons = {
    [0] = {
        name = "ak47",
        fire_rate = 600,
        magazine_capacity = 30,
        recoil = {{0, 0}, {-2, 4}, {2, 17}, {-3, 28}, {0, 29}, {11, 28}, {7, 26}, {13, 20}, {-16, 14}, {-37, -5},
                  {-20, 3}, {11, 12}, {-16, 3}, {-22, -8}, {-4, 5}, {34, 3}, {19, 8}, {16, 4}, {23, 0}, {31, -9},
                  {-17, 4}, {5, -1}, {-9, 4}, {-4, 7}, {13, -1}, {6, -1}, {-15, 0}, {-30, 0}, {-41, -14}, {-16, -3}}
    },
    [1] = {
        name = "m4a4",
        fire_rate = 666,
        magazine_capacity = 30,
        recoil = {{0, 0}, {1, 6}, {0, 9}, {-4, 15}, {4, 19}, {-6, 22}, {-4, 26}, {13, 12}, {10, 14}, {21, 6}, {-6, 7},
                  {-16, 5}, {-25, 0}, {-22, -7}, {-25, -2}, {-1, 4}, {7, 7}, {-11, 2}, {-11, -6}, {3, 1}, {28, 4},
                  {12, 3}, {23, 1}, {10, 2}, {10, 5}, {-9, 3}, {6, 0}, {2, 0}, {2, 6}, {6, 1}}
    },
    [2] = {
        name = "galil",
        fire_rate = 666,
        magazine_capacity = 35,
        recoil = {{0, 0}, {1, 2}, {-1, 2}, {6, 10}, {11, 15}, {1, 20}, {1, 21}, {5, 17}, {10, 11}, {-4, 9}, {-20, 10},
                  {-26, -5}, {-26, -7}, {-11, 4}, {-9, 3}, {-6, 0}, {0, 5}, {4, 4}, {22, 6}, {14, 4}, {23, 0},
                  {26, -14}, {5, 2}, {-10, 7}, {12, 2}, {9, 0}, {15, -4}, {-8, 0}, {-28, -3}, {-21, 0}, {-15, 4},
                  {5, 4}, {-12, -1}, {-22, -10}, {-12, -3}}
    },
    [3] = {
        name = "famas",
        fire_rate = 666,
        magazine_capacity = 25,
        recoil = {{0, 0}, {-2, 2}, {0, 1}, {-5, 10}, {-2, 19}, {0, 21}, {12, 14}, {14, 11}, {-4, 13}, {-17, 7},
                  {-14, 4}, {-13, 3}, {4, 8}, {19, 0}, {8, 4}, {19, -1}, {6, 3}, {14, -2}, {2, 4}, {0, 4}, {-22, 1},
                  {-5, 0}, {11, -1}, {14, -5}, {14, -6}}
    },
    [4] = {
        name = "cz75",
        fire_rate = 600,
        magazine_capacity = 12,
        recoil = {{0, 0}, {-3, 1}, {-20, 11}, {6, 28}, {26, 1}, {27, 21}, {-25, 24}, {-23, 20}, {-30, 12}, {12, 24},
                  {-13, 16}, {-4, 13}}
    },
    [5] = {
        name = "negev",
        fire_rate = 800,
        magazine_capacity = 80, -- out of 150
        recoil = {{0, 0}, {0, 3}, {0, 6}, {0, 17}, {0, 18}, {0, 20}, {0, 20}, {0, 17}, {0, 15}, {0, 12}, {0, 8}, {0, 8},
                  {0, 6}, {0, 0}, {0, 3}, {0, 2}, {0, 3}, {0, 3}, {0, 0}, {0, 0}, {0, 0}, {0, -3}, {0, 0}, {0, 0},
                  {0, 2}, {0, 2}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 3}, {0, 3}, {0, 1}, {0, 2}, {0, 0}, {0, 4},
                  {0, 0}, {0, -1}, {0, -3}, {0, -4}, {0, 0}, {0, 0}, {0, 0}, {0, 4}, {0, 0}, {0, -2}, {0, 0}, {0, 0},
                  {0, 0}, {0, 0}, {0, -1}, {0, 2}, {0, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},
                  {0, 0}, {0, 0}, {0, 0}, {0, 3}, {0, 4}, {0, -7}, {0, -12}, {0, -10}, {0, -7}, {0, -5}, {0, 3}, {0, 4},
                  {0, 4}, {0, 6}, {0, 2}, {0, 4}, {0, 1}, {0, -2}, {0, 1}, {0, 0}}
    },
    [6] = {
        name = "m4a1s",
        fire_rate = 600,
        magazine_capacity = 20,
        recoil = {{0, 0}, {0, 3}, {0, 3}, {-2, 12}, {3, 16}, {-4, 17}, {-3, 19}, {11, 13}, {6, 10}, {15, 1}, {-4, 6},
                  {-13, 7}, {-20, -1}, {-16, -1}, {-16, -7}, {0, 5}, {6, 6}, {-6, 0}, {-10, -4}, {2, 1}}
    }
}

EnablePrimaryMouseButtonEvents(true)
activation_button = 3

is_activated = false

function OnEvent(event, arg)
    time_start = GetRunningTime()
    if event == "MOUSE_BUTTON_PRESSED" then
        if arg == activation_button then
            is_activated = not is_activated
        elseif is_activated then
            if arg == 1 then
                weapon_index = BoolToInt(IsKeyLockOn("capslock")) + BoolToInt(IsKeyLockOn("numlock")) * 2 +
                                   BoolToInt(IsKeyLockOn("scrolllock")) * 4
                CompensateRecoilSmooth(weapons[weapon_index])
                -- CompensateRecoil(weapons[weapon_index])

            -- elseif arg == 5 then
            --     draw_cross()
            end
        end
    end
    -- OutputLogMessage("%.3f sec\t%-30s%d\n", (GetRunningTime() - time_start)/1000, event, arg)
end

function BoolToInt(x)
    return x and 1 or 0
end

function WaitTill(time)
    while GetRunningTime() < time_start + time do
    end
end

function CompensateRecoil(weapon)
    local delay = 60000 / weapon["fire_rate"]
    local i = 1
    while not (i == weapon["magazine_capacity"]) do
        WaitTill((i - 1) * delay + 30)
        i = i + 1
        MoveMouseRelative(weapon["recoil"][i][1], weapon["recoil"][i][2])
        if not IsMouseButtonPressed(1) then
            break
        end
    end
    while IsMouseButtonPressed(1) do
    end
end

function CompensateRecoilSmooth(weapon)
    local smoothness = 8
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
        WaitTill(((i - 1) * smoothness - j + 1) * delay)
        dx = math.floor(x / j)
        dy = math.floor(y / j)
        MoveMouseRelative(dx, dy)
        x = x - dx
        y = y - dy
        if not IsMouseButtonPressed(1) then
            break
        end
    end
    while IsMouseButtonPressed(1) do
    end
end

function DrawCross()
    local w, delay = 10, 1500
    local shift = {{w, 0}, {-w, -w}, {-w, w}, {w, w}, {0, -w}}
    for r = 1, #shift do
        Sleep(delay)
        MoveMouseRelative(shift[r][1], shift[r][2])
        PressAndReleaseMouseButton(1)
    end
end

function Autoclick(delay)
    local i = 1
    while true do
        PressAndReleaseMouseButton(1)
        Sleep(delay)
        i = i + 1
        if IsModifierPressed("alt") then
            break
        end
    end
end
