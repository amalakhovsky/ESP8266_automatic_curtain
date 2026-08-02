print("[INIT][WiFi] Initializing WiFi");

wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, 
	function(T)
		print("[WiFi][STA][Event] CONNECTED, SSID: "..T.SSID.." BSSID: "..T.BSSID.." Channel: "..T.channel);
 	end)

wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, 
	function(T) 
		print("[WiFi][STA][Event] DISCONNECTED, SSID: "..T.SSID.." BSSID: "..T.BSSID.." reason: "..T.reason);
		tmr.start(LedBlueErrorTimer);
	end)

wifi.eventmon.register(wifi.eventmon.STA_AUTHMODE_CHANGE,
	function(T) 
		print("[WiFi][STA][Event] AUTHMODE CHANGE, old_auth_mode: "..T.old_auth_mode.." new_auth_mode: "..T.new_auth_mode) 
	end)

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, 
	function(T) 
		print("[WiFi][STA][Event] IP ASSIGNED, Station IP: "..T.IP.." Subnet mask: ".. T.netmask.." Gateway IP: "..T.gateway)
		tmr.start(LedBlueOKShortTimer);
		tmr.stop(LedBlueErrorTimer);
	end)

wifi.eventmon.register(wifi.eventmon.STA_DHCP_TIMEOUT, 
	function() 
		print("[WiFi][STA][Event] DHCP TIMEOUT");
		tmr.start(LedBlueErrorTimer);
	end)

wifi.setmode(wifi.STATION);
print("[INIT][WiFi] Reading settings");
file.open("ssid.txt","r");
my_ssid = file.read();
file.close();
file.open("password.txt","r");
my_password = file.read();
file.close();
print("[INIT][WiFi] Configuring station");
wifi.sta.config(my_ssid,my_password);
--reset the variables
my_ssid = 0;
my_password = 0;
print("[INIT][WiFi] WiFi initialized");
