with Ada.Text_IO;
with Translations;

package body Workers is

   task body Warehouse is
   begin
      loop
         accept Store_Item (Item : Character; Amount : Integer) do
            Ada.Text_IO.Put_Line ("[Magazyn] Przyjęto" & Integer'Image(Amount) & " szt. towaru " & Translations.Get_Item_Name(Item));
         end Store_Item;
      end loop;
   end Warehouse;

   task body Worker_Type is
      Current_Item : Character;
      Current_Amount : Integer;
   begin
      loop
         accept Transport (Item : Character; Amount : Integer) do
            Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " odebrał polecenie transportu.");
            Current_Item := Item;
            Current_Amount := Amount;
         end Transport;
         
         Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " idzie do magazynu...");
         delay 3.0;
         
         Warehouse.Store_Item (Current_Item, Current_Amount);
         Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " przekazał towar i wraca na stację...");
         
         delay 3.0;
         
         Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " wrócił i oczekuje na pracę.");
      end loop;
   end Worker_Type;

end Workers;