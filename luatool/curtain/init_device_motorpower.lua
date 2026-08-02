print("[INIT] Initializing MotorPower");
print("[INIT] Setting MotorPower to GPIO 3, output mode");
MotorPower 	= 0;
MotorPowerTimerOpen = 3;
MotorPowerTimerClose = 4;
MotorMaxRunTime = 30000;
gpio.mode(MotorPower, gpio.OUTPUT);

function CurtainOpen()
	if (CurtainIsOpen) then
		print("[FUNCTION][CurtainOpen] Curtain is already open, not running the motor");
		return;
	end
	print("[FUNCTION][CurtainOpen] Opening curtain");
	CurtainIsClosed = false;
	MovementDirection = MotorDirectionOpen;
	gpio.write(MotorDirection,MotorDirectionOpen);
	gpio.write(MotorPower, gpio.HIGH);
	tmr.stop(MotorPowerTimerClose);
	--if the reed never triggers the belt has probably jammed
	tmr.alarm(MotorPowerTimerOpen, MotorMaxRunTime, tmr.ALARM_SINGLE,
		function()
			gpio.write(MotorPower, gpio.LOW);
			gpio.write(MotorDirection,MotorDirectionClose);
			print("[SAFETY][CurtainOpen] Maximum run time reached, stopping motor");
			ThreeColourLedShowRed();
		end);
end

function CurtainClose()
	if (CurtainIsClosed) then
		print("[FUNCTION][CurtainClose] Curtain is already closed, not running the motor");
		return;
	end
	print("[FUNCTION][CurtainClose] Closing curtain");
	CurtainIsOpen = false;
	MovementDirection = MotorDirectionClose;
	gpio.write(MotorDirection,MotorDirectionClose);
	gpio.write(MotorPower, gpio.HIGH);
	tmr.stop(MotorPowerTimerOpen);
	--if the reed never triggers the belt has probably jammed
	tmr.alarm(MotorPowerTimerClose, MotorMaxRunTime, tmr.ALARM_SINGLE,
		function()
			gpio.write(MotorPower, gpio.LOW);
			gpio.write(MotorDirection,MotorDirectionClose);
			print("[SAFETY][CurtainClose] Maximum run time reached, stopping motor");
			ThreeColourLedShowRed();
		end);
end
print("[INIT] MotorPower initialized");
