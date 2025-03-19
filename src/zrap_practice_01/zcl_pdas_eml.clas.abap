CLASS zcl_pdas_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pdas_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.



  DATA:
  lt_selection TYPE TABLE FOR READ IMPORT zcas_i_partner,

  lt_creation TYPE TABLE FOR CREATE ZCAS_I_PARTNER,
  lt_update TYPE TABLE FOR UPDATE  zcas_i_partner.


lt_selection = VALUE #(
  ( PartnerNumber = '1000000001' )
  ( PartnerNumber = '1000000003' )
).

READ ENTITIES OF zcas_i_partner ENTITY zcas_i_partner
  ALL FIELDS WITH lt_selection
  RESULT DATA(lt_partner_long)
  FAILED DATA(ls_failed)
  REPORTED DATA(ls_reported).

out->write( lt_partner_long ).


READ ENTITIES OF zcas_i_partner ENTITY zcas_i_partner
  FIELDS ( PartnerName Street City PaymentCurrency ) WITH VALUE #(
    ( PartnerNumber = '1000000001' )
    ( PartnerNumber = '1000000003' )
  )
  RESULT DATA(lt_partner_short)
  FAILED ls_failed
  REPORTED ls_reported.

out->write( lt_partner_short ).


 lt_creation = VALUE #(
    (

    %cid = 'DummyKey1'
    PartnerNumber = '1000000007'
    PartnerName = 'Amazon'
    Country = 'US'
    %control-PartnerNumber = if_abap_behv=>mk-on
    %control-PartnerName = if_abap_behv=>mk-on
    %control-Country = if_abap_behv=>mk-on


     )
    ).
    MODIFY ENTITIES OF zcas_i_partner ENTITY zcas_i_partner
    CREATE FROM lt_creation
    FAILED ls_failed
    MAPPED DATA(ls_mapped)
    REPORTED ls_reported.


    TRY.
    out->write( ls_mapped-zcas_i_partner[ 1 ]-PartnerNumber ).
  out->write( ls_mapped ).
  out->write( ' Data has been created ' ).





    COMMIT ENTITIES.

    CATCH cx_sy_itab_line_not_found.
        out->write( ls_failed-zcas_i_partner[ 1 ]-%cid ).

    ENDTRY.

    lt_update = VALUE #(
    (
    PartnerNumber = '1000000007'
    PartnerName = 'Amazon Fake'
    City = 'sattale'
    PaymentCurrency = 'INR'

    %control-PaymentCurrency = if_abap_behv=>mk-on
    %control-City = if_abap_behv=>mk-on




    )
    ).
    MODIFY ENTITIES OF zcas_i_partner ENTITY zcas_i_partner
    UPDATE from lt_update
    FAILED ls_failed
    MAPPED ls_mapped
    REPORTED ls_reported.
    IF ls_failed-zcas_i_partner IS INITIAL.
    out->write( 'updated' ).
    COMMIT ENTITIES.
    ENDIF.

  ENDMETHOD.


ENDCLASS.
