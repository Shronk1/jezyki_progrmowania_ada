package Station_Pkg is

   type Delivery is record
      Id : Integer;
      Item : Character;
      Amount: Integer;
   end record;

   task Station is
      entry Accept_Delivery (D : Delivery);
   end Station;

end Station_Pkg;