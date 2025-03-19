CLASS lhc_ZCAS_I_INVC DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Invoice RESULT result.
    METHODS createinvoicedocument FOR MODIFY
      IMPORTING keys FOR ACTION invoice~createinvoicedocument.

ENDCLASS.

CLASS lhc_ZCAS_I_INVC IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.



  METHOD CreateInvoiceDocument.
  DATA lt_document TYPE TABLE FOR ACTION IMPORT ZCAS_I_INVC~CreateInvoiceDocument.

lt_document = VALUE #( ( %cid   = to_upper( cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ) )
                         %param = VALUE #( Document  = 'TEST'
                                           Partner   = '1000000004'
                                           _position = VALUE #(
                                               Unit     = 'ST'
                                               Currency = 'EUR'
                                               ( Material = 'F0001' Quantity = '2' Price = '13.12' )
                                               ( Material = 'H0001' Quantity = '1' Price = '28.54' ) ) ) ) ).

MODIFY ENTITIES OF ZCAS_I_INVC
       ENTITY Invoice
       EXECUTE CreateInvoiceDocument FROM lt_document
       FAILED DATA(ls_failed_deep)
       REPORTED DATA(ls_reported_deep).


  ENDMETHOD.

ENDCLASS.
