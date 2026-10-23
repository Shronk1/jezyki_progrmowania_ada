with Deliveries;
with Orders;

procedure Main is

   -- Samochody dostawcze (Moduł 1)
   Truck1 : Deliveries.Truck_Type (1, 'P', 7);
   Truck2 : Deliveries.Truck_Type (2, 'L', 13);
   Truck3 : Deliveries.Truck_Type (3, 'T', 8);

   -- Zamówienia klientów (Moduł A)
   Order1 : Orders.Order_Type (101, 'P', 5);
   Order2 : Orders.Order_Type (102, 'L', 10);
   Order3 : Orders.Order_Type (103, 'T', 12);

begin
   null;
end Main;
