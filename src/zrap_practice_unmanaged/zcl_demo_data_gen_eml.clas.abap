CLASS zcl_demo_data_gen_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_demo_data_gen_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


 DATA
        lt_team TYPE STANDARD TABLE OF zdas_unmgd  WITH EMPTY KEY.

    lt_team =
        VALUE #( ( gen_key  = 'ef19093f-63e0-4c57-9bc8-38e017e28d22'
                   cdate     = '20250311 '
                   text    = 'hey there dummy'
                   )
                   ( gen_key  = 'f58ae89e-2ed3-4e13-938f-7f131ef161ac'
                   cdate     = '20250310 '
                   text    = 'hey there dummy demo'
                   )
                     ( gen_key  = 'pfaab0e26-fa2f-4d3c-a866-739ea2d76bca'


                   cdate     = '20250309 '
                   text    = 'hey there dummy demo test'
                   )
                     ( gen_key  = 'e3dd7a3e-d320-4ea2-9564-8ba115c25d1b'
                   cdate     = '20250308 '
                   text    = 'hey there dummy demo test hello '
                   )

                   ).
    DELETE FROM zdas_unmgd.
   " INSERT zdas_unmgd FROM TABLE @lt_team.
   "" MODIFY zdas_unmgd FROM TABLE @lt_team.
    ""COMMIT WORK.

  ENDMETHOD.

ENDCLASS.
