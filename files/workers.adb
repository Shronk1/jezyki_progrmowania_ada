with Ada.Text_IO;
with Translations;
with Warehouse_Pkg;

package body Workers is

   task body Worker_Type is
      Current_Item : Character;
      Current_Amount : Integer;
   begin
      loop
      -- W przykładzie mamy roboty a tu pracowników, więc zamiast stacji ładującej
      -- możemy zastosować ekspres do kawy, i poziom kofeiny jako energię pracowników
         select
            accept Transport (Item : Character; Amount : Integer) do
               Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " odebrał polecenie transportu.");
               Current_Item := Item;
               Current_Amount := Amount;
            end Transport;
         
            Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " idzie do magazynu...");
            delay 3.0;
            
            Warehouse_Pkg.Warehouse.Store_Item (Current_Item, Current_Amount);
            Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " przekazał towar i wraca na stację...");
            
            delay 3.0;
            
            Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " wrócił i oczekuje na pracę.");
         or
            delay 20.0;
            Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " zasnął podczas czekania i zakończył pracę.");
            exit;
         end select;
      end loop;
   end Worker_Type;

end Workers;