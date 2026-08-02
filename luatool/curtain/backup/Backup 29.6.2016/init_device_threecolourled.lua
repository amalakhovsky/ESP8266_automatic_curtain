print("Initializing ThreeColourLED");
print("Setting ThreeColourLED to GPIO 6 and 7, output mode");
ThreeColourLED1Pin 	= 6;
ThreeColourLED2Pin 	= 7;
gpio.mode(ThreeColourLED1Pin, gpio.OUTPUT);
gpio.mode(ThreeColourLED2Pin, gpio.OUTPUT);

function ThreeColourLedShowGreen()
	gpio.write(ThreeColourLED1Pin, gpio.HIGH);
	gpio.write(ThreeColourLED2Pin, gpio.LOW);
end

function ThreeColourLedShowRed()
	gpio.write(ThreeColourLED1Pin, gpio.LOW);
	gpio.write(ThreeColourLED2Pin, gpio.HIGH);
end

function ThreeColourLedShowYellow()
	gpio.write(ThreeColourLED1Pin, gpio.HIGH);
	gpio.write(ThreeColourLED2Pin, gpio.HIGH);
end

function ThreeColourLedOff()
	gpio.write(ThreeColourLED1Pin, gpio.LOW);
	gpio.write(ThreeColourLED2Pin, gpio.LOW);
end

print("ThreeColourLED initialized");
