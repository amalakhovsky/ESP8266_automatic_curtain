print("Initializing SwitchUser");
print("Setting SwitchUser to GPIO 5, output mode");
SwitchUser 	= 5;
SwitchUserLastPress = 0;
gpio.mode(SwitchUser, gpio.INT,gpio.PULLUP);
gpio.trig(SwitchUser,"down",
	function()
		local now = tmr.now();
		local delta = now - SwitchUserLastPress;
		--tmr.now wraps around, a negative delta is not a bounce
		if ((delta >= 0) and (delta < 300000)) then
			return;
		end
		SwitchUserLastPress = now;
		print("[TRIGGER][SwitchUser] User button pressed");
		if (gpio.read(MotorPower) == 1) then
			print("[TRIGGER][SwitchUser] Curtain moving, stopping");
			gpio.write(MotorPower, gpio.LOW);
			tmr.stop(MotorPowerTimerOpen);
			tmr.stop(MotorPowerTimerClose);
			gpio.write(MotorDirection,MotorDirectionClose); --put the relay down, to have less power consumption
		else
			if (MovementDirection == MotorDirectionOpen) then
				print("[TRIGGER][SwitchUser] Toggling direction, closing");
				CurtainClose();
			else
				print("[TRIGGER][SwitchUser] Toggling direction, opening");
				CurtainOpen();
			end
		end
	end);
print("SwitchUser initialized");
