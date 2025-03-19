CLASS lcl_data_buffer DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA gt_create TYPE zif_bs_demo_rap_data_handler=>tt_data.
    CLASS-DATA gt_update TYPE zif_bs_demo_rap_data_handler=>tt_data.
    CLASS-DATA gt_delete TYPE zif_bs_demo_rap_data_handler=>tt_data.
ENDCLASS.

CLASS lhc_ZCAS_I_UNMGD DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zcas_i_unmgd RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zcas_i_unmgd.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zcas_i_unmgd.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zcas_i_unmgd.

    METHODS read FOR READ
      IMPORTING keys FOR READ zcas_i_unmgd RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zcas_i_unmgd.

ENDCLASS.

CLASS lhc_ZCAS_I_UNMGD IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  INSERT LINES OF
         CORRESPONDING zif_bs_demo_rap_data_handler=>tt_data( entities MAPPING cdate = CreationDate text = Discription )
         INTO TABLE lcl_data_buffer=>gt_create.
  ENDMETHOD.

  METHOD update.
  DATA(lo_data_handler) = zcl_bs_demo_rap_data_handler=>create_instance( ).

  LOOP AT entities INTO DATA(ls_entity).
    DATA(ls_original) = lo_data_handler->read( ls_entity-TableKey ).

    IF ls_entity-%control-Discription = if_abap_behv=>mk-on.
      ls_original-text = ls_entity-Discription.
    ENDIF.

    IF ls_entity-%control-CreationDate = if_abap_behv=>mk-on.
      ls_original-cdate = ls_entity-CreationDate.
    ENDIF.

    INSERT ls_original INTO TABLE lcl_data_buffer=>gt_update.
  ENDLOOP.
  ENDMETHOD.

  METHOD delete.
   INSERT LINES OF
         CORRESPONDING zif_bs_demo_rap_data_handler=>tt_data( keys MAPPING gen_key = TableKey )
         INTO TABLE lcl_data_buffer=>gt_delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZCAS_I_UNMGD DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.


    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZCAS_I_UNMGD IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
   DATA(lo_data_handler) = zcl_bs_demo_rap_data_handler=>create_instance( ).

  LOOP AT lcl_data_buffer=>gt_create INTO DATA(ls_create).
    lo_data_handler->modify( ls_create ).
  ENDLOOP.

  LOOP AT lcl_data_buffer=>gt_update INTO DATA(ls_update).
    lo_data_handler->modify( ls_update ).
  ENDLOOP.

  LOOP AT lcl_data_buffer=>gt_delete INTO DATA(ls_delete).
    lo_data_handler->delete( ls_delete-gen_key ).
  ENDLOOP.

  CLEAR: lcl_data_buffer=>gt_create, lcl_data_buffer=>gt_update, lcl_data_buffer=>gt_delete.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
