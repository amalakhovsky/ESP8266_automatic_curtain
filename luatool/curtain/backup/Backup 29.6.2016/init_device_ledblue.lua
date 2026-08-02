print("[INIT][LedBlue] Initializing LedBlue");
LedBlue 	= 4;
print("[INIT][LedBlue] Setting LedBlue to GPIO " .. LedBlue .. ", output mode");
gpio.mode(LedBlue, gpio.OUTPUT);
gpio.write(LedBlue,gpio.LOW);

LedBlueErrorTimer = 2;
LedBlueOKShortTimer = 1;
LedBlueOKLongTimer = 0;

--Error blink timer
ledblue_value = true;
tmr.register(LedBlueErrorTimer, 300, tmr.ALARM_AUTO, 
	function ()
		gpio.write(LedBlue, ledblue_value and gpio.HIGH or gpio.LOW);
		ledblue_value = not ledblue_value;
		tmr.stop(LedBlueOKShortTimer);
		tmr.stop(LedBlueOKLongTimer);
	end)

--Normal operation timers
tmr.register(LedBlueOKShortTimer, 200, tmr.ALARM_SEMI, 
	function()
		gpio.write(LedBlue, gpio.HIGH);
		tmr.start(LedBlueOKLongTimer);
		tmr.stop(LedBlueErrorTimer);
	end)

tmr.register(LedBlueOKLongTimer, 7000, tmr.ALARM_SEMI, 
	function()
		gpio.write(LedBlue, gpio.LOW);
		tmr.start(LedBlueOKShortTimer);
		tmr.stop(LedBlueErrorTimer);			
	end)

print("[INIT][LedBlue] LedBlue initialized");
