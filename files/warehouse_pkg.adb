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
            accept Fulfill_Order (Id : Integer; Item : Character; Amount : Integer; Fulfilled : out Boolean) do
               if Item = 'P' and Count_P >= Amount then
                  Count_P := Count_P - Amount;
                  Count_All := Count_All - Amount;
                  Fulfilled := True;
               elsif Item = 'L' and Count_L >= Amount then
                  Count_L := Count_L - Amount;
                  Count_All := Count_All - Amount;
                  Fulfilled := True;
               elsif Item = 'T' and Count_T >= Amount then
                  Count_T := Count_T - Amount;
                  Count_All := Count_All - Amount;
                  Fulfilled := True;
               else
                  Fulfilled := False;
               end if;

               if Fulfilled then
                  Ada.Text_IO.Put_Line ("[Magazyn] Zrealizowano zamówienie nr " &
                                        Integer'Image(Id)(2 .. Integer'Image(Id)'Last) &
                                        ": wydano" & Integer'Image(Amount) & " szt. towaru " &
                                        Translations.Get_Item_Name(Item));
                  Ada.Text_IO.Put_Line ("[Magazyn] Stan magazynu po wydaniu -> Pralki:" & Integer'Image(Count_P) &
                                        " | Lodówki:" & Integer'Image(Count_L) &
                                        " | Telewizory:" & Integer'Image(Count_T));
               else
                  Ada.Text_IO.Put_Line ("[Magazyn] Brak wystarczającej ilości towaru " &
                                        Translations.Get_Item_Name(Item) &
                                        " na zamówienie nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) &
                                        " (potrzeba:" & Integer'Image(Amount) & "). Zamówienie oczekuje.");
               end if;
            end Fulfill_Order;
         or
            accept Check_Storage (Storage : out Integer) do
               Storage := Count_All;
               Ada.Text_IO.Put_Line ("[Magazyn] Sprawdzono stan ogólny magazynu: " & Integer'Image(Count_All) & " szt.");
            end Check_Storage;
         or
            delay 20.0;
            Ada.Text_IO.Put_Line ("[Magazyn] Koniec pracy (brak aktywności przez 20s). Końcowy stan towarów:" & Integer'Image(Count_All));
            exit;
         end select;
      end loop;
   end Warehouse;

end Warehouse_Pkg;
