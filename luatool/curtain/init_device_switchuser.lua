print("Initializing SwitchUser");
print("Setting SwitchUser to GPIO 5, output mode");
SwitchUser 	= 5;
gpio.mode(SwitchUser, gpio.INT,gpio.PULLUP);
gpio.trig(SwitchUser,"down",
	function() 
		print("User button pressed");
--TODO: Write the button behaviour.
--		gpio.write(MotorPower, gpio.LOW);
--		gpio.write(MotorDirection,MotorDirectionClose); --put the relay down, to have less power consumption
	end);
print("SwitchUser initialized");
