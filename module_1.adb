with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Test_Package;

procedure Main is

   subtype Time_Range is Integer range 1 .. 8;
   package Time_Random is new Ada.Numerics.Discrete_Random (Time_Range);

   type Delivery is record
      Id : Integer;
      Item : Character;
      Amount: Integer;
   end record;

   task Station is
      entry Accept_Delivery (D : Delivery);
   end Station;

   task type Truck_Type (Id : Integer; Item : Character; Amount : Integer);

   task body Station is
   begin
      loop
         accept Accept_Delivery (D : Delivery) do
            Ada.Text_IO.Put_Line ("Rozpoczęto rozładunek D" & Integer'Image(D.Id)(2 .. Integer'Image(D.Id)'Last));
            delay 2.0;
            Ada.Text_IO.Put_Line ("Zakończono rozładunek D" & Integer'Image(D.Id)(2 .. Integer'Image(D.Id)'Last));
         end Accept_Delivery;
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
         delay Duration(Random_Time);
         
         Ada.Text_IO.Put_Line ("Przyjazd samochodu D" & Integer'Image(Id)(2 .. Integer'Image(Id)'Last));
         Ada.Text_IO.Put_Line ("D" & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) & " oczekuje na rozładunek");
         
         Station.Accept_Delivery(D);
      end loop;
   end Truck_Type;

   Truck1 : Truck_Type (1, 'A', 10);
   Truck2 : Truck_Type (2, 'B', 15);
   Truck3 : Truck_Type (3, 'C', 20);

begin
   Test_Package.Print;
end Main;