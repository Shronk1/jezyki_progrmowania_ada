with Ada.Text_IO;
with Workers;
with Translations;

package body Station_Pkg is

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

end Station_Pkg;