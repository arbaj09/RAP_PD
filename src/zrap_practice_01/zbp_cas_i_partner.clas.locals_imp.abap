CLASS lsc_zcas_i_partner DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zcas_i_partner IMPLEMENTATION.

  METHOD adjust_numbers.
    SELECT FROM zdas_partner
    FIELDS MAX( partner )
    INTO @DATA(ld_max_partner).

    LOOP AT mapped-zcas_i_partner REFERENCE INTO DATA(lr_partner).
      ld_max_partner += 1.
      lr_partner->PartnerNumber = ld_max_partner.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZCAS_I_PARTNER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zcas_i_partner RESULT result.

    METHODS validateKeyIsFilled FOR VALIDATE ON SAVE
      IMPORTING keys FOR zcas_i_partner~validateKeyIsFilled.
    METHODS validateCoreData FOR VALIDATE ON SAVE
      IMPORTING keys FOR zcas_i_partner~validateCoreData.
    METHODS fillCurrency FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zcas_i_partner~fillCurrency.
    METHODS clearAllEmptyStreets FOR MODIFY
      IMPORTING keys FOR ACTION zcas_i_partner~clearAllEmptyStreets.

    METHODS fillEmptyStreets FOR MODIFY
      IMPORTING keys FOR ACTION zcas_i_partner~fillEmptyStreets.
    METHODS copyLine FOR MODIFY
      IMPORTING keys FOR ACTION zcas_i_partner~copyLine.
    METHODS withPopup FOR MODIFY
      IMPORTING keys FOR ACTION zcas_i_partner~withPopup.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zcas_i_partner RESULT result.

    METHODS FillEmptyStreetInstanceFeature FOR MODIFY
      IMPORTING keys FOR ACTION zcas_i_partner~FillEmptyStreetInstanceFeature RESULT result.
    METHODS clearEmptyStreet FOR MODIFY
      IMPORTING keys FOR ACTION zcas_i_partner~clearEmptyStreet RESULT result.
    METHODS get_global_features FOR GLOBAL FEATURES
      IMPORTING REQUEST requested_features FOR ZCAS_I_PARTNER RESULT result.


ENDCLASS.

CLASS lhc_ZCAS_I_PARTNER IMPLEMENTATION.





  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validateKeyIsFilled.


*    LOOP AT keys INTO DATA(ls_key) WHERE PartnerNumber IS INITIAL  OR  PartnerNumber = '10000020'.
*      INSERT VALUE #( PartnerNumber = ls_key-PartnerNumber ) INTO TABLE failed-zcas_i_partner.
*
*      IF  ls_key-PartnerNumber IS INITIAL.
*        INSERT VALUE #(
*                      PartnerNumber = ls_key-PartnerNumber
*                      %msg = new_message_with_text(
*                      severity = if_abap_behv_message=>severity-error text = 'Partner Number is madatoey'
*                         )
*
*
*                      ) INTO TABLE reported-zcas_i_partner.
*
*
*      ELSEIF ls_key-PartnerNumber = '10000020'.
*        INSERT VALUE #(
*                    PartnerNumber = ls_key-PartnerNumber
*                    %msg = new_message_with_text(
*                    severity = if_abap_behv_message=>severity-error text = 'instead of this partner number 10000020 please enter another one'
*                       )
*
*
*                    ) INTO TABLE reported-zcas_i_partner.
*      ENDIF.
*
*
*
*    ENDLOOP.
  ENDMETHOD.

  METHOD validateCoreData.

*    READ ENTITIES OF zcas_i_partner IN LOCAL MODE
*    ENTITY zcas_i_partner
*    FIELDS ( Country PaymentCurrency ) WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_partner_data)
*    FAILED DATA(ls_failed)
*    REPORTED DATA(ls_reported).
*
*    LOOP AT lt_partner_data INTO DATA(ls_partner).
*      SELECT SINGLE FROM zcas_i_partner
*      FIELDS Country
*      WHERE Country = @ls_partner-Country
*      INTO @DATA(ld_found_country).
*      IF sy-subrc <> 0.
*
*
*
*
*        INSERT VALUE #( PartnerNumber = ls_partner-PartnerNumber ) INTO TABLE failed-zcas_i_partner.
*
*        INSERT VALUE #(
*          PartnerNumber = ls_partner-PartnerNumber
*           %msg = new_message_with_text( text = ' Currency not found in I_Currency ' )
*           %element-PaymentCurrency = if_abap_behv=>mk-on
*         ) INTO TABLE reported-zcas_i_partner.
*
*
*      ENDIF.
*
*
*    ENDLOOP.
  ENDMETHOD.

  METHOD fillCurrency.
    READ ENTITIES OF zcas_i_partner IN LOCAL MODE
    ENTITY zcas_i_partner
    FIELDS ( PaymentCurrency )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_partner_data).

    LOOP AT lt_partner_data INTO DATA(ls_partner) WHERE PaymentCurrency IS INITIAL.
      MODIFY ENTITIES OF zcas_i_partner IN LOCAL MODE
        ENTITY zcas_i_partner
        UPDATE FIELDS ( PaymentCurrency )
        WITH VALUE #( ( %tky = ls_partner-%tky PaymentCurrency = 'EUR' %control-paymentcurrency = if_abap_behv=>mk-on ) ).
    ENDLOOP.
  ENDMETHOD.



  METHOD clearAllEmptyStreets.
    SELECT FROM zdas_partner
    FIELDS partner, street
    WHERE street =   'Empty'
    INTO TABLE @DATA(ls_partner_data).
    LOOP AT ls_partner_data INTO DATA(ls_partner).
      MODIFY ENTITIES OF zcas_i_partner IN LOCAL MODE
       ENTITY zcas_i_partner
       UPDATE FIELDS ( Street )
       WITH VALUE #( ( PartnerNumber = ls_partner-partner Street = '' %control-Street = if_abap_behv=>mk-on ) ).

      INSERT VALUE #(
        %msg = new_message_with_text( text = |{ lines( ls_partner_data ) } records changed|
        severity = if_abap_behv_message=>severity-success )
      ) INTO TABLE reported-zcas_i_partner.


    ENDLOOP.



  ENDMETHOD.

  METHOD fillEmptyStreets.
    READ ENTITIES OF zcas_i_partner IN LOCAL MODE
  ENTITY zcas_i_partner
  FIELDS ( Street )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_partner_data).

    LOOP AT lt_partner_data INTO DATA(ls_partner) WHERE Street IS INITIAL.
      MODIFY ENTITIES OF zcas_i_partner IN LOCAL MODE
      ENTITY zcas_i_partner
      UPDATE FIELDS ( Street )
      WITH VALUE #( ( %tky = ls_partner-%tky Street = 'Empty' %control-Street = if_abap_behv=>mk-on ) ).



    ENDLOOP.
  ENDMETHOD.

  METHOD copyLine.
    DATA:
    lt_creation TYPE TABLE FOR CREATE zcas_i_partner.

    READ ENTITIES OF zcas_i_partner IN LOCAL MODE
      ENTITY zcas_i_partner ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_partner_data).

    SELECT FROM zdas_partner
      FIELDS MAX( partner )

      INTO @DATA(ld_number).

    LOOP AT lt_partner_data INTO DATA(ls_partner).
      ld_number += 1.
      ls_partner-PartnerNumber = ld_number.
      ls_partner-PartnerName &&= | copy|.



      INSERT VALUE #( %cid = keys[ sy-tabix ]-%cid ) INTO TABLE lt_creation REFERENCE INTO DATA(lr_create).
      lr_create->* = CORRESPONDING #( ls_partner ).
      lr_create->%control-PartnerNumber = if_abap_behv=>mk-on.
      lr_create->%control-PartnerName = if_abap_behv=>mk-on.
      lr_create->%control-Street = if_abap_behv=>mk-on.
      lr_create->%control-City = if_abap_behv=>mk-on.
      lr_create->%control-Country = if_abap_behv=>mk-on.
      lr_create->%control-PaymentCurrency = if_abap_behv=>mk-on.


    ENDLOOP.






    MODIFY ENTITIES OF zcas_i_partner IN LOCAL MODE
      ENTITY zcas_i_partner CREATE FROM lt_creation
      FAILED DATA(ls_failed)
      MAPPED DATA(ls_mapped)
      REPORTED DATA(ls_reported).

    mapped-zcas_i_partner = ls_mapped-zcas_i_partner.
  ENDMETHOD.




  METHOD withPopup.

    TRY.
        DATA(ls_key) = keys[ 1 ].
      CATCH cx_sy_itab_line_not_found.
        RETURN.
    ENDTRY.

    CASE ls_key-%param-MessageType.
      WHEN 1.
        INSERT VALUE #(
          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success text = 'Dummy message' )
        ) INTO TABLE reported-zcas_i_partner.
      WHEN 2.
        INSERT VALUE #(
          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-information text = 'Dummy message' )
        ) INTO TABLE reported-zcas_i_partner.
      WHEN 3.
        INSERT VALUE #(
          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-warning text = 'Dummy message' )
        ) INTO TABLE reported-zcas_i_partner.
      WHEN 4.
        INSERT VALUE #(
          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = 'Dummy message' )
        ) INTO TABLE reported-zcas_i_partner.
      WHEN 5.
        INSERT VALUE #(
          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-none text = 'Dummy message' )
        ) INTO TABLE reported-zcas_i_partner.
      WHEN 6.
        reported-zcas_i_partner = VALUE #(
          ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success text = 'Dummy message' ) )
          ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-information text = 'Dummy message' ) )
        ).
      WHEN 7.
        reported-zcas_i_partner = VALUE #(
          ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success text = 'Dummy message' ) )
          ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error text = 'Dummy message' ) )
          ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-warning text = 'Dummy message' ) )
          ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-information text = 'Dummy message' ) )
        ).
    ENDCASE.



  ENDMETHOD.

  METHOD get_instance_features.

   IF requested_features-%action-FillEmptyStreetInstanceFeature = if_abap_behv=>mk-on.
  READ ENTITIES OF zcas_i_partner IN LOCAL MODE
    ENTITY zcas_i_partner FIELDS ( Street ) WITH CORRESPONDING #( keys )
    RESULT DATA(lt_partner_data).

  LOOP AT lt_partner_data INTO DATA(ls_partner) WHERE Street IS NOT INITIAL.
    INSERT VALUE #(
      partnernumber = ls_partner-PartnerNumber
      %action-FillEmptyStreetInstanceFeature = if_abap_behv=>mk-on
    ) INTO TABLE result.
  ENDLOOP.
ENDIF.

    IF requested_features-%action-clearEmptyStreet = if_abap_behv=>mk-on.
      READ ENTITIES OF zcas_i_partner IN LOCAL MODE ENTITY zcas_i_partner FIELDS ( Street ) WITH CORRESPONDING #( keys )
      RESULT DATA(ls_partner_data).

      LOOP AT ls_partner_data INTO DATA(lr_partner) WHERE Street IS  INITIAL.
        INSERT VALUE #( partnernumber = lr_partner-PartnerNumber
                         %action-clearEmptyStreet = if_abap_behv=>mk-on
          ) INTO TABLE result .
      ENDLOOP.


    ENDIF.


  ENDMETHOD.

  METHOD FillEmptyStreetInstanceFeature.


    SELECT FROM zdas_partner
    FIELDS partner, street ,name
    WHERE street =   ''
    INTO TABLE @DATA(ls_partner_data).
 .

    LOOP AT ls_partner_data INTO DATA(ls_partner).
      MODIFY ENTITIES OF zcas_i_partner IN LOCAL MODE
       ENTITY zcas_i_partner
       UPDATE FIELDS ( Street )
       WITH VALUE #( ( PartnerNumber = ls_partner-partner Street = 'EMPTY' %control-Street = if_abap_behv=>mk-on ) ).

      INSERT VALUE #(
        %msg = new_message_with_text( text = |{ lines( ls_partner_data ) } records changed|
        severity = if_abap_behv_message=>severity-success )
      ) INTO TABLE reported-zcas_i_partner.


    ENDLOOP.






  ENDMETHOD.

  METHOD clearEmptyStreet.
      LOOP AT keys INTO DATA(ls_key).
      MODIFY ENTITIES OF zcas_i_partner IN LOCAL MODE ENTITY zcas_i_partner
      UPDATE FIELDS ( Street )
      WITH VALUE #( (   PartnerNumber = ls_key-PartnerNumber Street = '' %control-Street = if_abap_behv=>mk-on  ) ).


    ENDLOOP.
  ENDMETHOD.

  METHOD get_global_features.
   if requested_features-%delete = if_abap_behv=>mk-on.
   DATA(ld_deactivate) = COND #(
   when cl_abap_context_info=>get_user_alias(  ) = '' THEN if_abap_behv=>mk-off
   ELSE if_abap_behv=>mk-on
   ).
   result-%delete = ld_deactivate.
   ENDIF.


  ENDMETHOD.

ENDCLASS.
