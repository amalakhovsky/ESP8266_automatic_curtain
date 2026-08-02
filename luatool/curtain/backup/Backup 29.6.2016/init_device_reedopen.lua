print("[INIT] Initializing ReedOpen");
print("[INIT] Setting ReedOpen to GPIO 1, input mode");
ReedOpen 	= 1;
gpio.mode(ReedOpen, gpio.INT,gpio.PULLUP);
gpio.trig(ReedOpen,"down",
	function() 
		if (MovementDirection == MotorDirectionOpen) then
			print("[TRIGGER][ReedOpen] Curtain opened");
			gpio.write(MotorPower, gpio.LOW);
			gpio.write(MotorDirection,MotorDirectionClose); --put the relay down, to have less power consumption
		end
	end);
print("[INIT] ReedOpen initialized");
