# jezyki_progrmowania_ada

Checklista na punkty:

Moduł 1: Dostawy i rozładunek 2 ZROBIONE
 
Moduł 2: Roboty transportowe  2 ZROBIONE

Moduł 3: Magazyn 2 ZROBIONE (przyjęcie towaru, stan zapełnienia, sprawdzenie aktualnego stanu Check_Storage)

3 wybrane moduły dodatkowe 4,5:
- Moduł A: Zamówienia klientów (ZROBIONE)
- Moduł dodatkowy 2 (do wyboru)
- Moduł dodatkowy 3 (do wyboru)

Integracja i współbieżność  1,5 (...)

3 różne konstrukcje select i min 1 dozór  2 (użyte: selective accept, conditional call, timed call, dozór when w Warehouse)

Jakość programu i prezentacja 1 




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

Station_Pkg (station_pkg.ads/adb):

    Station: Manages the unloading process (taking 2 seconds) and delegates the transported payload to the first available worker.

Workers (workers.ads/adb):

    Worker_Type: Represents individual workers. They receive goods from the station, transport them to the warehouse (3 seconds), drop them off, and walk back to the station (3 seconds).

Warehouse_Pkg (warehouse_pkg.ads/adb):

    Warehouse: The final storage destination that accepts goods, fulfills client orders (Moduł A), and maintains an independent state (inventory counters) for all three item types.

Orders (orders.ads/adb):

    Order_Type: Simulates client orders appearing in the system (Moduł A). Each order has an ID, item type, and quantity. Communicates with Warehouse to receive items, waiting and retrying if stock is currently insufficient.

Main (main.adb): The entry point of the program that starts the simulation by initializing delivery trucks and customer orders.
