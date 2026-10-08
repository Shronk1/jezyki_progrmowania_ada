with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Station_Pkg;

package body Deliveries is

   subtype Time_Range is Integer range 5 .. 17;
   package Time_Random is new Ada.Numerics.Discrete_Random (Time_Range);

   task body Truck_Type is
      D : Station_Pkg.Delivery;
      Gen : Time_Random.Generator;
      Random_Time : Time_Range;
   begin
      Time_Random.Reset (Gen);
      D := (Id => Id, Item => Item, Amount => Amount);
      for I in 1 .. 2 loop
         Random_Time := Time_Random.Random (Gen);
         delay Duration(Random_Time);
         
         Ada.Text_IO.Put_Line ("Przyjazd samochodu nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last));
         Ada.Text_IO.Put_Line ("Samochód nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) & " oczekuje na rozładunek");
         select
            Station_Pkg.Station.Accept_Delivery(D);
         or
            delay 20.0;
            Ada.Text_IO.Put_Line ("Samochód nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) & " znudził się czekaniem i odjechał w siną dal");
            exit;
         end select;
      end loop;
      Ada.Text_IO.Put_Line ("Samochód nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) & " zakończył pracę");
   end Truck_Type;

end Deliveries;