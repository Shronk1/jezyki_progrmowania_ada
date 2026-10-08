package body Translations is

   function Get_Item_Name (Item : Character) return String is
   begin
      if Item = 'P' then
         return "Pralki";
      elsif Item = 'L' then
         return "Lodówki";
      elsif Item = 'T' then
         return "Telewizory";
      else
         return "Error: produkt Nieznany";
      end if;
   end Get_Item_Name;

   function Get_Worker_Name (Id : Character) return String is
   begin
      if Id = 'M' then
         return "Mietek";
      elsif Id = 'W' then
         return "Wiesiek";
      else
         return "Error: nieznany pracownik";
      end if;
   end Get_Worker_Name;

end Translations;