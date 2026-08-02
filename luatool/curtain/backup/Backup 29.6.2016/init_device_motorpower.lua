print("[INIT] Initializing MotorPower");
print("[INIT] Setting MotorPower to GPIO 3, output mode");
MotorPower 	= 0;
gpio.mode(MotorPower, gpio.OUTPUT);

function CurtainOpen()
	print("[FUNCTION][CurtainOpen] Opening curtain");
	MovementDirection = MotorDirectionOpen;
	gpio.write(MotorDirection,MotorDirectionOpen);
	gpio.write(MotorPower, gpio.HIGH);
end

function CurtainClose()
	print("[FUNCTION][CurtainClose] Closing curtain");
	MovementDirection = MotorDirectionClose;
	gpio.write(MotorDirection,MotorDirectionClose);
	gpio.write(MotorPower, gpio.HIGH);
end
print("[INIT] MotorPower initialized");
