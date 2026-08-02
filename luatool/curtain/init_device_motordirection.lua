print("[INIT] Initializing MotorDirection");
print("[INIT] Setting MotorDirection to GPIO 2, output mode");
MotorDirection 	= 2;
gpio.mode(MotorDirection, gpio.OUTPUT);
MotorDirectionClose = gpio.LOW;
MotorDirectionOpen = gpio.HIGH;
local MovementDirection = MotorDirectionClose;
print("[INIT] MotorDirection initialized");
