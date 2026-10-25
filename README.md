# Języki Programowania - Projekt Ada (MM_Logistics)

Symulacja współbieżnego systemu logistyczno-magazynowego napisana w języku Ada.

## 🚀 How to open project?

### Linux
Before the first run, `gnat` and `gprbuild` are required:
```bash
sudo apt update
sudo apt install gnat gprbuild
```

To compile and run the simulation:
```bash
gprbuild -P MM_logistics
./bin/main
```

### Windows
https://sppchoroszcz.med.pl/

> **Want to add something?**  
> Just drop the new `.ads` and `.adb` files into the source folder – no need to modify the `.gpr` file!

---

## 📦 What is in the project?

* **`Translations` (`translations.ads` / `.adb`)**  
  A helper package that decodes character codes into full string names for items (`'P'` for washing machines, `'L'` for fridges, `'T'` for TVs) and workers (`'M'` for Mietek, `'W'` for Wiesiek).

* **`Deliveries` (`deliveries.ads` / `.adb`)**  
  * `Truck_Type`: Simulates trucks arriving at random intervals to deliver a specific quantity of goods. Includes a patience timeout (**Moduł H**) – if the unloading station is busy for too long (20 seconds), the truck gives up and leaves.

* **`Station_Pkg` (`station_pkg.ads` / `.adb`)**  
  * `Station`: Manages the unloading process (taking 2 seconds) and delegates the transported payload to the first available worker using a conditional `select ... else` block.

* **`Workers` (`workers.ads` / `.adb`)**  
  * `Worker_Type`: Represents individual workers. They receive goods from the station, transport them to the warehouse (2.5 seconds), drop them off, and walk back to the station (2.5 seconds). Each delivery reduces their caffeine level – when it drops below 50%, the worker must visit the coffee machine before returning to work (**Moduł E**).

* **`Coffee` (`coffee.ads` / `.adb`)**  
  * `Machine`: Simulates a single shared coffee machine (**Moduł E**). Workers queue up to brew coffee (taking 2 seconds) and restore their caffeine level back to 100%.

* **`Warehouse_Pkg` (`warehouse_pkg.ads` / `.adb`)**  
  * `Warehouse`: The final storage destination that accepts goods (guarded by a `when` clause checking the storage limit), fulfills client orders (**Moduł A**), and maintains inventory counters for all three item types.

* **`Orders` (`orders.ads` / `.adb`)**  
  * `Order_Type`: Simulates client orders appearing in the system (**Moduł A**). Each order has an ID, item type, and quantity. Communicates with `Warehouse` to receive items, waiting and retrying if stock is currently insufficient.

* **`Main` (`main.adb`)**  
  The entry point of the program that starts the simulation by initializing delivery trucks and customer orders.