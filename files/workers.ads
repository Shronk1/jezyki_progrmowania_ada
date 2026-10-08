package Workers is

   task Warehouse is
      entry Store_Item (Item : Character; Amount : Integer);
   end Warehouse;

   task type Worker_Type (Id : Character) is
      entry Transport (Item : Character; Amount : Integer);
   end Worker_Type;

   Worker1 : Worker_Type ('M');
   Worker2 : Worker_Type ('W');

end Workers;