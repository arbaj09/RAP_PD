CLASS zccl_as_eml_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zccl_as_eml_2 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
  DATA lt_filter TYPE STANDARD TABLE OF zcas_i_invc WITH EMPTY KEY.

    lt_filter = VALUE #( ( Document = '30000000' )
                         ( Document = '30000005' ) ).


    READ ENTITIES OF zcas_i_invc

    ENTITY Invoice
    ALL FIELDS WITH CORRESPONDING #( lt_filter )
    RESULT DATA(lt_invoice)

    ENTITY Invoice BY \_Item
    FIELDS ( Document PosNumber Material ) WITH CORRESPONDING #( lt_filter )
    RESULT DATA(lt_position)
    FAILED FINAL(ls_failed).

  ENDMETHOD.




ENDCLASS.
