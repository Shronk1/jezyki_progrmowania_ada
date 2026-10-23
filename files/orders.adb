with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Warehouse_Pkg;
with Translations;

package body Orders is

   subtype Wait_Range is Integer range 1 .. 4;
   package Wait_Random is new Ada.Numerics.Discrete_Random (Wait_Range);

   task body Order_Type is
      Gen : Wait_Random.Generator;
      Fulfilled : Boolean := False;
      Attempts : Integer := 0;
      Max_Attempts : constant Integer := 8;
   begin
      Wait_Random.Reset (Gen);
      -- Krótkie losowe opóźnienie przed pojawieniem się zamówienia w systemie
      delay Duration (Wait_Random.Random (Gen));

      Ada.Text_IO.Put_Line ("[Klient] Złożono zamówienie nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) &
                            ": " & Integer'Image(Amount)(2 .. Integer'Image(Amount)'Last) & " szt. towaru " &
                            Translations.Get_Item_Name (Item));

      while not Fulfilled and Attempts < Max_Attempts loop
         Attempts := Attempts + 1;

         select
            Warehouse_Pkg.Warehouse.Fulfill_Order (Id, Item, Amount, Fulfilled);
         or
            delay 4.0;
            Fulfilled := False;
         end select;

         if Fulfilled then
            Ada.Text_IO.Put_Line ("[Klient] Zamówienie nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) &
                                  " zostało zrealizowane pomyślnie!");
            exit;
         else
            Ada.Text_IO.Put_Line ("[Klient] Zamówienie nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) &
                                  " oczekuje na dostawę towaru (próba " &
                                  Integer'Image(Attempts)(2 .. Integer'Image(Attempts)'Last) & ")...");
            delay 4.0;
         end if;
      end loop;

      if not Fulfilled then
         Ada.Text_IO.Put_Line ("[Klient] Zamówienie nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) &
                               " zrezygnowało z oczekiwania po zbyt długim czasie.");
      end if;

   exception
      when Tasking_Error =>
         Ada.Text_IO.Put_Line ("[Klient] Zamówienie nr " & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) &
                               ": Magazyn zakończył pracę, anulowano zamówienie.");
   end Order_Type;

end Orders;
