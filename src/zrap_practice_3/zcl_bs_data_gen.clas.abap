CLASS zcl_bs_data_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bs_data_gen IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  DATA
     lt_gen TYPE STANDARD TABLE OF ZDAS_GEN WITH EMPTY KEY.

     lt_gen = VALUE #(
     ( uuid_key = '100001'
        price   = '10009'
        currency = 'USA'
        description = 'RAP - Generator (ADT)'

     )
       ( uuid_key = '100002'
        price   = '10004'
        currency = 'INR'
        description = 'RAP - Generator (ADT)'

     )
       ( uuid_key = '100003'
        price   = '102224'
        currency = 'EUR'
        description = 'RAP - Generator (ADT)'

     )
       ( uuid_key = '100004'
        price   = '12334'
        currency = 'INR'
        description = 'RAP - Generator (ADT)'

     )
       ( uuid_key = '100005'
        price   = '98976'
        currency = 'INR'
        description = 'RAP - Generator (ADT) demo'

     )
       ( uuid_key = '100006'
        price   = '10004'
        currency = 'INR'
        description = 'RAP - Generator (ADT)'

     )
     ).

     DELETE FROM zdas_gen.
     INSERT ZDAS_GEN from TABLE @lt_gen.


      out->write( |Data: { lines( lt_gen ) }| ).




  ENDMETHOD.

ENDCLASS.
