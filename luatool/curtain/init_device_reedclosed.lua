print("[INIT] Initializing ReedClosed");
print("[INIT] Setting ReedClosed to GPIO 0, input mode");
ReedClosed 	= 3;
gpio.mode(ReedClosed, gpio.INT,gpio.PULLUP);
gpio.trig(ReedClosed,"down",
	function()
		if (MovementDirection == MotorDirectionClose) then 
			print("[TRIGGER][ReedClose] Curtain closed");
			gpio.write(MotorPower, gpio.LOW);
			gpio.write(MotorDirection,MotorDirectionClose); --put the relay down, to have less power consumption
		end
	end);
print("[INIT] ReedClosed initialized");
