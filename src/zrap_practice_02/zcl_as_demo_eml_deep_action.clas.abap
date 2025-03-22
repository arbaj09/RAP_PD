CLASS zcl_as_demo_eml_deep_action DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES tt_document TYPE TABLE FOR ACTION IMPORT zcas_i_invc~CreateMultipleInvoices.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_as_demo_eml_deep_action IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA lt_document TYPE tt_document.
    INSERT VALUE #( %cid = xco_cp=>uuid(  )->value ) INTO TABLE lt_document REFERENCE INTO DATA(lr_new_item).



    lr_new_item->%param = VALUE #(  Partner = '1000000004'  Document  = 'TEST'
                                                            _item = VALUE #( Unit     = 'ST'
                                                                                Currency = 'USD'
                                                                                ( Material = 'G0001' Quantity = '2' Price = '17.12' )
                                                                                ( Material = 'Z0001' Quantity = '1' Price = '29.55' ) ) ).
*                                                          ( Document  = 'TEST'
*                                                            _item = VALUE #( Unit     = 'ST'
*                                                                                Currency = 'USD'
*                                                                                ( Material = 'G0001' Quantity = '2' Price = '17.12' )
*                                                                                ( Material = 'Z0001' Quantity = '1' Price = '29.55' ) ) )

*     Partner = '1000000004'
*                                  ( Document  = 'TEST'
*                                   _item = VALUE #( Unit = 'ST' Currency = 'EUR' Material = 'F0001' Quantity = '2' Price = '13.12' ) ) ).

*                                                        ( Material = 'F0001' Quantity = '2' Price = '13.12' )
*                                                        ( Material = 'H0001' Quantity = '1' Price = '28.54' ) ) )
*                                 ( Document  = 'TEST2'
*                                   _item = VALUE #( Unit     = 'ST'
*                                                        Currency = 'USD'
*                                                        ( Material = 'G0001' Quantity = '2' Price = '17.12' )
*                                                        ( Material = 'Z0001' Quantity = '1' Price = '29.55' ) ) ) ).






    MODIFY ENTITIES OF zcas_i_invc
           ENTITY Invoice
           EXECUTE CreateMultipleInvoices FROM lt_document
           FAILED DATA(ls_failed_deep)
           REPORTED DATA(ls_reported_deep).


  ENDMETHOD.

ENDCLASS.
