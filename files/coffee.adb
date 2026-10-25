with Ada.Text_IO;
with Translations;

package body Coffee is

   task body Machine is
   begin
      loop
         select
            accept Make_Coffee (Id : Character) do
               Ada.Text_IO.Put_Line ("[Ekspres] " & Translations.Get_Worker_Name(Id) & " rozpoczął parzenie kawy...");
               delay 2.0;
               Ada.Text_IO.Put_Line ("[Ekspres] Kawa gotowa! " & Translations.Get_Worker_Name(Id) & " wypił kawę i odzyskał siły.");
            end Make_Coffee;
         or
            delay 20.0;
            Ada.Text_IO.Put_Line ("[Ekspres] Ekspres się wyłączył (tryb oszczędzania energii po 20s braku aktywności).");
            exit;
         end select;
      end loop;
   end Machine;

end Coffee;