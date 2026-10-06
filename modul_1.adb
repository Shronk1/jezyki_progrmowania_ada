with Ada.Text_IO;

procedure Modul_1 is

   type Dostawa is record
      Id : Integer;
      Towar : Character;
      Ilosc: Integer;
   end record;

   task Stanowisko is
      entry Przyjmij (D : Dostawa);
   end Stanowisko;

   task type Samochod_Type (Id : Integer; Towar : Character; Ilosc : Integer; Opoznienie_Startu : Integer);

   task body Stanowisko is
   begin
      loop
         accept Przyjmij (D : Dostawa) do
            Ada.Text_IO.Put_Line ("Rozpoczęto rozładunek D" & Integer'Image(D.Id)(2 .. Integer'Image(D.Id)'Last));
            delay 6.0;
            Ada.Text_IO.Put_Line ("Zakończono rozładunek D" & Integer'Image(D.Id)(2 .. Integer'Image(D.Id)'Last));
         end Przyjmij;
      end loop;
   end Stanowisko;

   task body Samochod_Type is
      D : Dostawa;
   begin
      delay Duration(Opoznienie_Startu);
      
      D := (Id => Id, Towar => Towar, Ilosc => Ilosc);
      Ada.Text_IO.Put_Line ("Przyjazd samochodu D" & Integer'Image(Id)(2 .. Integer'Image(Id)'Last));
      Ada.Text_IO.Put_Line ("D" & Integer'Image(Id)(2 .. Integer'Image(Id)'Last) & " oczekuje na rozładunek");
      
      Stanowisko.Przyjmij(D);
   end Samochod_Type;

   Auto1 : Samochod_Type (1, 'A', 10, 1);
   Auto2 : Samochod_Type (2, 'B', 15, 4);
   Auto3 : Samochod_Type (3, 'C', 20, 7);

begin
   null;
end Modul_1;