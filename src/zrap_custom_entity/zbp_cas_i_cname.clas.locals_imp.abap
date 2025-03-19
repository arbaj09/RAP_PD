CLASS lhc_ZCAS_I_CNAME DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zcas_i_cname RESULT result.

ENDCLASS.

CLASS lhc_ZCAS_I_CNAME IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
