package Warehouse_Pkg is

   task Warehouse is
      entry Store_Item (Item : Character; Amount : Integer);
      entry Fulfill_Order (Id : Integer; Item : Character; Amount : Integer; Fulfilled : out Boolean);
      entry Check_Storage (Storage : out Integer);
   end Warehouse;

end Warehouse_Pkg;
