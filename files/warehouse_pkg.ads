package Warehouse_Pkg is

   task Warehouse is
      entry Store_Item (Item : Character; Amount : Integer);
   end Warehouse;

end Warehouse_Pkg;