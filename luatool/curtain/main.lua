print("[INIT][HTTPD] Initializing web server");
conn=net.createConnection(net.TCP, true); 
conn:on("receive", function(conn, pl) print(pl) end);

-- function VerifyKey(

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
	
        local _on,_off = "",""
	
	if(_GET.key == "banana") then
		if (_GET.action == "close") then
			print("[HTTPD] Received web request to close curtain");
			http.post('https://maker.ifttt.com/trigger/curtain_close/with/key/IFTTT-KEY-REDACTED','Content-Type: application/json\r\n\r\n','', function(code, data) print(code); end);
			CurtainClose();
		end

		if (_GET.action == "open") then
			print("[HTTPD] Received web request to open curtain");
			http.post('https://maker.ifttt.com/trigger/curtain_open/with/key/IFTTT-KEY-REDACTED','Content-Type: application/json\r\n\r\n','', function(code, data) print(code); end);
			CurtainOpen();
		end

		if (_GET.action == "stop") then
			print("[HTTPD] Received web request to stop curtain");
			gpio.write(MotorPower,gpio.LOW);
			tmr.stop(MotorPowerTimerOpen);
			tmr.stop(MotorPowerTimerClose);
			gpio.write(MotorDirection,MotorDirectionClose); --put the relay down, to have less power consumption
		end

		if (_GET.action == "red") then
			print("[HTTPD] Received web request to Red");
			ThreeColourLedShowRed();
		end


		if (_GET.action == "green") then
			print("[HTTPD] Received web request to Green");
			ThreeColourLedShowGreen();
		end

		if (_GET.action == "yellow") then
			print("[HTTPD] Received web request to Yellow");
			ThreeColourLedShowYellow();
		end

		if (_GET.action == "off") then
			print("[HTTPD] Received web request to Off");
			ThreeColourLedOff();
		end
		
		buf = "HTTP/1.1 200 OK\n"

	else
		file.open("index.html","r");
		buf = file.read();
		file.close();
	end

        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
