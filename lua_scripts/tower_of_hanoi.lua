EnablePrimaryMouseButtonEvents(true);
activation_button = 3
positions = {{25035, 54000}, {38273, 54000}, {51511, 54000}}

is_activated = false


function OnEvent(event, arg)
    if event == "MOUSE_BUTTON_PRESSED" then
      if arg == activation_button then
        is_activated = not is_activated
      elseif is_activated and arg == 1 then
        PressAndReleaseMouseButton(1)
        solve(10, 1, 2, 3)
      end
    end
end


function solve(n, t1, t2, t3)
    if n == 1 then
        move(t1, t3)
        return
    end
    solve(n - 1, t1, t3, t2)
    move(t1, t3)
    solve(n - 1, t2, t1, t3)
end


function move(t1, t2)
    local delay = 250
    MoveMouseTo(positions[t1][1], positions[t1][2])
    Sleep(delay)
    PressAndReleaseMouseButton(1)
    Sleep(delay)
    MoveMouseTo(positions[t2][1], positions[t2][2])
    Sleep(delay)
    PressAndReleaseMouseButton(1)
    Sleep(delay)
end
