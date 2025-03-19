CLASS zcl_pdas_eml_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS read_data
      IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.



CLASS zcl_pdas_eml_2 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    read_data( out ).

    .


  ENDMETHOD.

  METHOD read_data.
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
     IF ls_failed-invoice IS NOT INITIAL.
      io_out->write( `Failed!` ).
    ENDIF.
    io_out->write( `Positions:` ).
    io_out->write( lt_position ).

  ENDMETHOD.


ENDCLASS.
