with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Station_Pkg;

package body Deliveries is

   subtype Time_Range is Integer range 1 .. 8;
   package Time_Random is new Ada.Numerics.Discrete_Random (Time_Range);

   task body Truck_Type is
      D : Station_Pkg.Delivery;
      Gen : Time_Random.Generator;
      Random_Time : Time_Range;
   begin
      Time_Random.Reset (Gen);
      D := (Id => Id, Item => Item, Amount => Amount);
      
      loop
         Random_Time := Time_Random.Random (Gen);
         delay Duration(Random_Time*2);
         
         Ada.Text_IO.Put_Line ("Przyjazd samochodu nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last));
         Ada.Text_IO.Put_Line ("Samochód nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) & " oczekuje na rozładunek");
         
         Station_Pkg.Station.Accept_Delivery(D);
      end loop;
   end Truck_Type;

end Deliveries;