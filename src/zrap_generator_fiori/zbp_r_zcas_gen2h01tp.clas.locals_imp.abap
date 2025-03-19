CLASS LHC_ZCAS_GEN2H DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZCAS_GEN2H
        RESULT result,
      CALCULATEUUIDKEY FOR DETERMINE ON SAVE
        IMPORTING
          KEYS FOR  ZCAS_GEN2H~CalculateUuidKey .
ENDCLASS.

CLASS LHC_ZCAS_GEN2H IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD CALCULATEUUIDKEY.
  READ ENTITIES OF ZR_ZCAS_GEN2H01TP IN LOCAL MODE
    ENTITY ZCAS_GEN2H
      ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(entities).
  DELETE entities WHERE UuidKey IS NOT INITIAL.
  Check entities is not initial.
  "Dummy logic to determine object_id
  SELECT MAX( UUID_KEY ) FROM ZDAS_GEN2H INTO @DATA(max_object_id).
  "Add support for draft if used in modify
  "SELECT SINGLE FROM FROM ZZCAS_GEN2H00D FIELDS MAX( UuidKey ) INTO @DATA(max_orderid_draft). "draft table
  "if max_orderid_draft > max_object_id
  " max_object_id = max_orderid_draft.
  "ENDIF.
  MODIFY ENTITIES OF ZR_ZCAS_GEN2H01TP IN LOCAL MODE
    ENTITY ZCAS_GEN2H
      UPDATE FIELDS ( UuidKey )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
        %tky          = entity-%tky
        UuidKey     = max_object_id + i
  ) ).
  ENDMETHOD.
ENDCLASS.
