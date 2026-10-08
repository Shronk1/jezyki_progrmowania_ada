with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Workers;
with Translations;

package body Deliveries is

   subtype Time_Range is Integer range 1 .. 8;
   package Time_Random is new Ada.Numerics.Discrete_Random (Time_Range);

   task body Station is
   Current_Item : Character;
   Current_Amount : Integer;
   begin
      loop
         accept Accept_Delivery (D : Delivery) do
            Ada.Text_IO.Put_Line ("Rozpoczęto rozładunek samochodu nr " & Integer'Image(D.Id)(2 .. Integer'Image(D.Id)'Last)&" (Towar: " & Translations.Get_Item_Name(D.Item) & ")");
            delay 2.0;
            Ada.Text_IO.Put_Line ("Zakończono rozładunek samochodu nr " & Integer'Image(D.Id)(2 .. Integer'Image(D.Id)'Last));
         Current_Item := D.Item;
         Current_Amount := D.Amount;
         end Accept_Delivery;

         select
            Workers.Worker1.Transport (Current_Item, Current_Amount);
         else
            Workers.Worker2.Transport (Current_Item, Current_Amount);
         end select;
      end loop;
   end Station;

   task body Truck_Type is
      D : Delivery;
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
         
         Station.Accept_Delivery(D);
      end loop;
   end Truck_Type;

end Deliveries;