print("[INIT] Initializing ReedOpen");
print("[INIT] Setting ReedOpen to GPIO 1, input mode");
ReedOpen 	= 1;
gpio.mode(ReedOpen, gpio.INT,gpio.PULLUP);
CurtainIsOpen = (gpio.read(ReedOpen) == 0);
gpio.trig(ReedOpen,"down",
	function()
		if (MovementDirection == MotorDirectionOpen) then
			print("[TRIGGER][ReedOpen] Curtain opened");
			CurtainIsOpen = true;
			gpio.write(MotorPower, gpio.LOW);
			tmr.stop(MotorPowerTimerOpen);
			gpio.write(MotorDirection,MotorDirectionClose); --put the relay down, to have less power consumption
		end
	end);
print("[INIT] ReedOpen initialized");
