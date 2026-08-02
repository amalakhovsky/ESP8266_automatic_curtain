print("[INIT][PhoneWatch] Initializing phone watch service");
PhoneIP = "192.168.1.5";
PhonePort = 80;
PhoneCheckInterval = 60000;
PhoneProbeTimeout = 5000;
PhoneAwayLimit = 10;
PhoneHome = false;
PhoneMissCount = 0;
PhoneSeen = false;
PhoneWatchTimer = 5;
PhoneWatchProbeTimer = 6;

function PhoneWatchProbe()
	if (wifi.sta.getip() == nil) then
		print("[FUNCTION][PhoneWatchProbe] No wifi, skipping probe");
		return;
	end
	print("[FUNCTION][PhoneWatchProbe] Probing phone at "..PhoneIP);
	PhoneSeen = false;
	PhoneProbeStart = tmr.now();
	local conn = net.createConnection(net.TCP, 0);
	conn:on("connection",
		function(conn)
			print("[FUNCTION][PhoneWatchProbe] Phone responded, must be home");
			PhoneSeen = true;
			conn:close();
		end);
	conn:on("disconnection",
		function(conn)
			--a refused connection still proves the phone is on the network
			--this firmware reports connect errors through the disconnection callback
			--but only a fast refusal counts, slow failures are timeouts
			local elapsed = tmr.now() - PhoneProbeStart;
			if ((elapsed >= 0) and (elapsed < 2000000) and (PhoneSeen == false)) then
				print("[FUNCTION][PhoneWatchProbe] Connection refused, phone must be on the network");
				PhoneSeen = true;
			end
		end);
	conn:connect(PhonePort, PhoneIP);
	tmr.alarm(PhoneWatchProbeTimer, PhoneProbeTimeout, tmr.ALARM_SINGLE,
		function()
			if (PhoneSeen) then
				PhoneMissCount = 0;
				if (PhoneHome == false) then
					PhoneHome = true;
					print("[PHONEWATCH] Phone arrived home, opening curtain");
					CurtainOpen();
				end
			else
				--phone wifi sleeps, one missed probe means nothing
				PhoneMissCount = PhoneMissCount + 1;
				print("[PHONEWATCH] Probe missed, count is "..PhoneMissCount);
				if (PhoneHome and (PhoneMissCount >= PhoneAwayLimit)) then
					PhoneHome = false;
					print("[PHONEWATCH] Phone left home, closing curtain");
					CurtainClose();
				end
			end
			collectgarbage();
		end);
end

tmr.alarm(PhoneWatchTimer, PhoneCheckInterval, tmr.ALARM_AUTO, PhoneWatchProbe);
print("[INIT][PhoneWatch] Phone watch service initialized");
