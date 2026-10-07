package Deliveries is

   type Delivery is record
      Id : Integer;
      Item : Character;
      Amount: Integer;
   end record;

   task Station is
      entry Accept_Delivery (D : Delivery);
   end Station;

   task type Truck_Type (Id : Integer; Item : Character; Amount : Integer);

end Deliveries;