with Ada.Text_IO;
with Translations;

package body Warehouse_Pkg is

   task body Warehouse is
      Count_P : Integer := 0;
      Count_L : Integer := 0;
      Count_T : Integer := 0;
      Count_All : Integer := 0;
      Storage_Limit : Integer := 75;
   begin
      loop
         select
            when Count_All < Storage_Limit =>
               accept Store_Item (Item : Character; Amount : Integer) do
                  Count_All := Count_All + Amount;
                  if Item = 'P' then
                     Count_P := Count_P + Amount;
                  elsif Item = 'L' then
                     Count_L := Count_L + Amount;
                  elsif Item = 'T' then
                     Count_T := Count_T + Amount;
                  end if;
                  
                  Ada.Text_IO.Put_Line ("[Magazyn] Przyjęto" & Integer'Image(Amount) & " szt. towaru " & Translations.Get_Item_Name(Item));
                  Ada.Text_IO.Put_Line ("[Magazyn] Stan magazynu -> Pralki:" & Integer'Image(Count_P) & " | Lodówki:" & Integer'Image(Count_L) & " | Telewizory:" & Integer'Image(Count_T));
               end Store_Item;
         or
            -- Trzeba rozwinąć sprawdzanie stanu magazynu, najlepiej w komunikacji z klientami
            --  accept Check_Storage (Storage : out Integer) do
            --     Storage := Count_All;
            --  end Check_Storage;
            delay 20.0;
            Ada.Text_IO.Put_Line ("Magazyn pełen. Koniec pracy" & Integer'Image(Count_All));
            exit;
         end select;
      end loop;
   end Warehouse;

end Warehouse_Pkg;