with Ada.Text_IO;
with Translations;
with Warehouse_Pkg;
with Coffee;

package body Workers is

   task body Worker_Type is
      Current_Item : Character;
      Current_Amount : Integer;
      Caffeine_Level : Integer := 100;
   begin
      loop
         select
            accept Transport (Item : Character; Amount : Integer) do
               Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " odebrał polecenie transportu.");
               Current_Item := Item;
               Current_Amount := Amount;
            end Transport;
         
            Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " idzie do magazynu...");
            delay 2.5;
            
            Warehouse_Pkg.Warehouse.Store_Item (Current_Item, Current_Amount);
            Caffeine_Level := Caffeine_Level - 60;
            Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " przekazał towar i wraca na stację... (Poziom kofeiny:" & Integer'Image(Caffeine_Level) & "%)");
            
            if Caffeine_Level < 50 then
               Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " opadł z sił i idzie do ekspresu po kawę.");
               Coffee.Machine.Make_Coffee (Id);
               Caffeine_Level := 100;
            end if;

            delay 2.5;
            
            Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " wrócił i oczekuje na pracę.");
         or
            delay 20.0;
            Ada.Text_IO.Put_Line (Translations.Get_Worker_Name(Id) & " zasnął podczas czekania i zakończył pracę.");
            exit;
         end select;
      end loop;
   end Worker_Type;

end Workers;