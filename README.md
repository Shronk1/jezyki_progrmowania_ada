# jezyki_progrmowania_ada

How to open project?

Linux:

before first run gprbuild is required:

sudo apt update

sudo apt install gnat gprbuild



then to compile and open:

gprbuild -P MM_logistics

./bin/main




Windows:

https://sppchoroszcz.med.pl/



Want to add something? 

Just throw files to files folder, no need to modify .gpr file!




What is in project?

Translations (translations.ads/adb): A helper package that decodes character codes into full string names for items ('P' for washing machines, 'L' for fridges, 'T' for TVs) and workers ('M' for Mietek, 'W' for Wiesiek).

Deliveries (deliveries.ads/adb):

    Truck_Type: Simulates trucks arriving at random intervals to deliver a specific quantity of goods.

    Station: Manages the unloading process (taking 2 seconds) and delegates the transported payload to the first available worker.

Workers (workers.ads/adb):

    Worker_Type: Represents individual workers. They receive goods from the station, transport them to the warehouse (3 seconds), drop them off, and walk back to the station (3 seconds).

    Warehouse: The final storage destination that accepts and logs the deposited goods.

Main (main.adb): The entry point of the program that starts the simulation by initializing three trucks with different item types and am