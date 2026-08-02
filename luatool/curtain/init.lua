print("Andrey's smart curtain initializing");
print("Setting up devices");
dofile("init_devices.lua");
print("Setting up phone watch service");
dofile("init_service_phonewatch.lua");
print("Running main program");
dofile("main.lua");

