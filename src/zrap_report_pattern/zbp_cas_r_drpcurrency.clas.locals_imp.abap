
**********************************for Event implementaion Step1****************************
CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.
    TYPES tt_keys TYPE TABLE FOR ACTION IMPORT zcas_r_drpcurrency\\currency~loadexcelcontent.

    CLASS-DATA gt_event TYPE tt_keys.
ENDCLASS.
**********************************************************************  step1 end



CLASS lhc_Currency DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    TYPES: BEGIN OF ts_excel,
             currency TYPE string,
             country  TYPE string,
             ranking  TYPE string,
             flag     TYPE string,
           END OF ts_excel.

    TYPES tt_excel TYPE STANDARD TABLE OF ts_excel WITH EMPTY KEY.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Currency RESULT result.

    METHODS loadexcelcontent FOR MODIFY
      IMPORTING keys FOR ACTION currency~loadexcelcontent.

*    METHODS loadexcelcontent FOR MODIFY
*      IMPORTING keys FOR ACTION currency~loadexcelcontent RESULT result.


    METHODS convert_excel_file_to_table
      IMPORTING id_stream        TYPE xstring
      RETURNING VALUE(rt_result) TYPE tt_excel
      RAISING   zcx_drp_excel_error.
ENDCLASS.


CLASS lhc_Currency IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.


  .




  METHOD LoadExcelContent.

    DATA lt_currency_modify  TYPE TABLE FOR UPDATE zcas_r_drpcurrency\\Currency.
    DATA lt_countries_create TYPE TABLE FOR CREATE zcas_r_drpcurrency\_Country.
    DATA lt_countries_modify TYPE TABLE FOR UPDATE zcas_r_drpcurrency\\Country.

    READ ENTITIES OF zcas_r_drpcurrency IN LOCAL MODE
         ENTITY Currency FIELDS ( Currency ExcelAttachement ) WITH CORRESPONDING #( keys )
         RESULT DATA(lt_attachement)
         ENTITY Currency BY \_Country ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(lt_countries).

    TRY.
        DATA(ls_key) = keys[ 1 ].
        DATA(ls_attachement) = lt_attachement[ 1 ].
      CATCH cx_sy_itab_line_not_found.
        INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
                            number   = '003'
                            severity = if_abap_behv_message=>severity-error )
               INTO TABLE reported-%other.
        RETURN.
    ENDTRY.

    "validate field logic madt field

 IF ls_key-%param-EventComment IS INITIAL.
  INSERT new_message( id       = 'ZCAS_RAP_PATTERN'
                      number   = '001'
                      severity = if_abap_behv_message=>severity-error )
         INTO TABLE reported-%other.
  RETURN.
ENDIF.





    TRY.
        DATA(lt_excel) = convert_excel_file_to_table( ls_attachement-excelattachement ).
      CATCH zcx_drp_excel_error INTO DATA(lo_excel_error).
        INSERT lo_excel_error INTO TABLE reported-%other.
        RETURN.
    ENDTRY.

    INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
                        number   = '005'
                        severity = if_abap_behv_message=>severity-success
                        v1       = lines( lt_excel ) )
           INTO TABLE reported-%other.

    IF ls_key-%param-TestRun = abap_true.
      INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
                          number   = '004'
                          severity = if_abap_behv_message=>severity-warning )
             INTO TABLE reported-%other.
      RETURN.
    ENDIF.

    INSERT VALUE #( %tky                      = ls_attachement-%tky
                    excelattachement          = ''
                    excelmimetype             = ''
                    excelfilename             = ''
                    %control-excelattachement = if_abap_behv=>mk-on
                    %control-excelmimetype    = if_abap_behv=>mk-on
                    %control-excelfilename    = if_abap_behv=>mk-on )
           INTO TABLE lt_currency_modify.

    INSERT VALUE #( currency = ls_attachement-Currency )
           INTO TABLE lt_countries_create REFERENCE INTO DATA(lr_new).

    LOOP AT lt_excel INTO DATA(ls_excel) WHERE currency = ls_attachement-Currency.
      TRY.
          DATA(ls_country) = lt_countries[ Country = ls_excel-country ].
          INSERT VALUE #( currency                = ls_country-Currency
                          country                 = ls_country-Country
                          countryranking          = ls_excel-ranking
                          %control-countryranking = if_abap_behv=>mk-on )
                 INTO TABLE lt_countries_modify.

        CATCH cx_sy_itab_line_not_found.
          INSERT VALUE #( %cid                    = xco_cp=>uuid( )->value
                          currency                = ls_excel-currency
                          country                 = ls_excel-country
                          countryranking          = ls_excel-ranking
                          %control-currency       = if_abap_behv=>mk-on
                          %control-country        = if_abap_behv=>mk-on
                          %control-countryranking = if_abap_behv=>mk-on )
                 INTO TABLE lr_new->%target.
      ENDTRY.
    ENDLOOP.

    MODIFY ENTITIES OF zcas_r_drpcurrency IN LOCAL MODE
           ENTITY Currency UPDATE FROM lt_currency_modify
           ENTITY Country UPDATE FROM lt_countries_modify
           ENTITY Currency CREATE BY \_Country FROM lt_countries_create.

    INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
                        number   = '007'
                        severity = if_abap_behv_message=>severity-success
                        v1       = lines( lt_countries_create[ 1 ]-%target ) )
           INTO TABLE reported-%other.

    INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
                        number   = '006'
                        severity = if_abap_behv_message=>severity-success
                        v1       = lines( lt_countries_modify ) )
           INTO TABLE reported-%other.



*****event implementaion step 2
    INSERT ls_key INTO TABLE lcl_buffer=>gt_event.

  ENDMETHOD.


  METHOD convert_excel_file_to_table.
    IF id_stream IS INITIAL.
      RAISE EXCEPTION NEW zcx_drp_excel_error( textid = VALUE #( msgid = 'ZBS_DEMO_RAP_PATTERN'
                                                                 msgno = '001' ) ).
    ENDIF.

    DATA(lo_sheet) = xco_cp_xlsx=>document->for_file_content( id_stream
      )->read_access( )->get_workbook(
      )->worksheet->at_position( 1 ).

    IF NOT lo_sheet->exists( ).
      RAISE EXCEPTION NEW zcx_drp_excel_error( textid = VALUE #( msgid = 'ZBS_DEMO_RAP_PATTERN'
                                                                 msgno = '002' ) ).
    ENDIF.

    DATA(lo_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(
      )->from_column( xco_cp_xlsx=>coordinate->for_alphabetic_value( 'A' )
      )->from_row( xco_cp_xlsx=>coordinate->for_numeric_value( 2 )
      )->get_pattern( ).

    lo_sheet->select( lo_pattern
      )->row_stream(
      )->operation->write_to( REF #( rt_result )
      )->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value
      )->execute( ).
  ENDMETHOD.





ENDCLASS.

CLASS lsc_ZCAS_R_DRPCURRENCY DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZCAS_R_DRPCURRENCY IMPLEMENTATION.

  METHOD save_modified.
    LOOP AT update-currency INTO DATA(ls_new_currency).

      " DATA(ls_modify_currency) = CORRESPONDING zdas_add_curr( ls_new_currency MAPPING FROM ENTITY ).
      ls_new_currency-LastEditor = cl_abap_context_info=>get_user_technical_name( ).
      " MODIFY zdas_add_curr FROM @ls_modify_currency.

      INSERT zdas_add_curr FROM  @ls_new_currency MAPPING FROM ENTITY.
      IF sy-subrc <> 0.
        UPDATE zdas_add_curr FROM @ls_new_currency INDICATORS SET  STRUCTURE %control MAPPING FROM ENTITY.
      ENDIF.
    ENDLOOP.

    LOOP AT create-country INTO DATA(ls_create_country).
      INSERT zdas_drp_country FROM @( CORRESPONDING zdas_drp_country( ls_create_country MAPPING FROM ENTITY ) ).
    ENDLOOP.

    LOOP AT update-country INTO DATA(ls_update_country).
      UPDATE zdas_drp_country FROM @( CORRESPONDING zdas_drp_country( ls_update_country MAPPING FROM ENTITY ) ).
    ENDLOOP.

    LOOP AT delete-country INTO DATA(ls_delete_country).
      DELETE zdas_drp_country FROM @( CORRESPONDING zdas_drp_country( ls_delete_country MAPPING FROM ENTITY ) ).
    ENDLOOP.

*        for event implementaion
    LOOP AT lcl_buffer=>gt_event INTO DATA(ls_event).
      RAISE ENTITY EVENT zcas_r_drpcurrency~AfterExcelload
            FROM VALUE #( ( %key   = ls_event-%key
                            %param = VALUE #( EventComment = ls_event-%param-EventComment
                                              LastEditor   = cl_abap_context_info=>get_user_technical_name( ) ) ) ).
    ENDLOOP.
  ENDMETHOD.


  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.








*
*CLASS lhc_Currency DEFINITION INHERITING FROM cl_abap_behavior_handler.
*
*
*  PRIVATE SECTION.
*
*
*  TYPES: BEGIN OF ts_excel,
*             currency TYPE string,
*             country  TYPE string,
*             ranking  TYPE string,
*             flag     TYPE string,
*           END OF ts_excel.
*
*    TYPES tt_excel TYPE STANDARD TABLE OF ts_excel WITH EMPTY KEY.
*
*
*    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*      IMPORTING keys REQUEST requested_authorizations FOR Currency RESULT result.
*    METHODS loadexcelcontent FOR MODIFY
*      IMPORTING keys FOR ACTION currency~loadexcelcontent RESULT result.
*
*
*    METHODS convert_excel_file_to_table
*      IMPORTING id_stream        TYPE xstring
*      RETURNING VALUE(rt_result) TYPE tt_excel
*      RAISING   zcx_drp_excel_error.
*
*
*
*
*
*ENDCLASS.
*
*CLASS lhc_Currency IMPLEMENTATION.
*
*  METHOD get_instance_authorizations.
*  ENDMETHOD.
*
*
*   METHOD convert_excel_file_to_table.
*    IF id_stream IS INITIAL.
*      RAISE EXCEPTION NEW zcx_drp_excel_error( textid = VALUE #( msgid = 'ZBS_DEMO_RAP_PATTERN'
*                                                                 msgno = '001' ) ).
*    ENDIF.
*
*    DATA(lo_sheet) = xco_cp_xlsx=>document->for_file_content( id_stream
*      )->read_access( )->get_workbook(
*      )->worksheet->at_position( 1 ).
*
*    IF NOT lo_sheet->exists( ).
*      RAISE EXCEPTION NEW zcx_drp_excel_error( textid = VALUE #( msgid = 'ZBS_DEMO_RAP_PATTERN'
*                                                                 msgno = '002' ) ).
*    ENDIF.
*
*    DATA(lo_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(
*      )->from_column( xco_cp_xlsx=>coordinate->for_alphabetic_value( 'A' )
*      )->from_row( xco_cp_xlsx=>coordinate->for_numeric_value( 2 )
*      )->get_pattern( ).
*
*    lo_sheet->select( lo_pattern
*      )->row_stream(
*      )->operation->write_to( REF #( rt_result )
*      )->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value
*      )->execute( ).
*
*TRY.
*.
*    DATA(ls_attachement) = lt_attachement[ 1 ].
*
*  CATCH cx_sy_itab_line_not_found.
*    INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
*                        number   = '003'
*                        severity = if_abap_behv_message=>severity-error )
*           INTO TABLE reported-%other.
*    RETURN.
*ENDTRY.
*
*  ENDMETHOD.
*
*  METHOD LoadExcelContent.
*  READ ENTITIES OF zcas_r_drpcurrency IN LOCAL MODE
*     ENTITY Currency FIELDS ( Currency ExcelAttachement ) WITH CORRESPONDING #( keys )
*     RESULT DATA(lt_attachement)
*     ENTITY Currency BY \_Country ALL FIELDS WITH CORRESPONDING #( keys )
*     RESULT DATA(lt_countries).
*
*TRY.
*    DATA(ls_key) = keys[ 1 ].
*    DATA(ls_attachement) = lt_attachement[ 1 ].
*  CATCH cx_sy_itab_line_not_found.
*    INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
*                        number   = '003'
*                        severity = if_abap_behv_message=>severity-error )
*           INTO TABLE reported-%other.
*    RETURN.
*ENDTRY.
*
*TRY.
*    DATA(lt_excel) = convert_excel_file_to_table( ls_attachement-excelattachement ).
*  CATCH zcx_drp_excel_error INTO DATA(lo_excel_error).
*    INSERT lo_excel_error INTO TABLE reported-%other.
*    RETURN.
*ENDTRY.
*
*INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
*                    number   = '005'
*                    severity = if_abap_behv_message=>severity-success
*                    v1       = lines( lt_excel ) )
*       INTO TABLE reported-%other.
*
*
*
*
*
*
*
*
*   DATA lt_currency_modify  TYPE TABLE FOR UPDATE zcas_r_drpcurrency.
*    DATA lt_countries_create TYPE TABLE FOR CREATE zcas_r_drpcurrency\_Country.
*    DATA lt_countries_modify TYPE TABLE FOR UPDATE ZCAS_I_CURRENCY_COUNTRY.
* READ ENTITIES OF zcas_r_drpcurrency IN LOCAL MODE
*         ENTITY Currency FIELDS ( Currency ExcelAttachement ) WITH CORRESPONDING #( keys )
*         RESULT DATA(lt_attachement)
*         ENTITY Currency BY \_Country ALL FIELDS WITH CORRESPONDING #( keys )
*         RESULT DATA(lt_countries).
*
*    TRY.
*        DATA(ls_key) = keys[ 1 ].
*        DATA(ls_attachement) = lt_attachement[ 1 ].
*      CATCH cx_sy_itab_line_not_found.
*        INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
*                            number   = '003'
*                            severity = if_abap_behv_message=>severity-error )
*               INTO TABLE reported-%other.
*        RETURN.
*    ENDTRY.
*
*    TRY.
*        DATA(lt_excel) = convert_excel_file_to_table( ls_attachement-excelattachement ).
*      CATCH zcx_drp_excel_error INTO DATA(lo_excel_error).
*        INSERT lo_excel_error INTO TABLE reported-%other.
*        RETURN.
*    ENDTRY.
*
*    INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
*                        number   = '005'
*                        severity = if_abap_behv_message=>severity-success
*                        v1       = lines( lt_excel ) )
*           INTO TABLE reported-%other.
*
*    IF ls_key-%param-TestRun = abap_true.
*      INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
*                          number   = '004'
*                          severity = if_abap_behv_message=>severity-warning )
*             INTO TABLE reported-%other.
*      RETURN.
*    ENDIF.
*
*    INSERT VALUE #( %tky                      = ls_attachement-%tky
*                    excelattachement          = ''
*                    excelmimetype             = ''
*                    excelfilename             = ''
*                    %control-excelattachement = if_abap_behv=>mk-on
*                    %control-excelmimetype    = if_abap_behv=>mk-on
*                    %control-excelfilename    = if_abap_behv=>mk-on )
*           INTO TABLE lt_currency_modify.
*
*    INSERT VALUE #( currency = ls_attachement-Currency )
*           INTO TABLE lt_countries_create REFERENCE INTO DATA(lr_new).
*
*    LOOP AT lt_excel INTO DATA(ls_excel) WHERE currency = ls_attachement-Currency.
*      TRY.
*          DATA(ls_country) = lt_countries[ Country = ls_excel-country ].
*          INSERT VALUE #( currency                = ls_country-Currency
*                          country                 = ls_country-Country
*                          countryranking          = ls_excel-ranking
*                          %control-countryranking = if_abap_behv=>mk-on
*                         )
*                 INTO TABLE lt_countries_modify.
*
*        CATCH cx_sy_itab_line_not_found.
*          INSERT VALUE #( %cid                    = xco_cp=>uuid( )->value
*                          currency                = ls_excel-currency
*                          country                 = ls_excel-country
*                          countryranking          = ls_excel-ranking
*                          %control-currency       = if_abap_behv=>mk-on
*                          %control-country        = if_abap_behv=>mk-on
*                          %control-countryranking = if_abap_behv=>mk-on )
*                 INTO TABLE lr_new->%target.
*      ENDTRY.
*    ENDLOOP.
*
*    MODIFY ENTITIES OF zcas_r_drpcurrency IN LOCAL MODE
*           ENTITY Currency UPDATE FROM lt_currency_modify
*           ENTITY Country UPDATE FROM lt_countries_modify
*           ENTITY Currency CREATE BY \_Country FROM lt_countries_create.
*
*    INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
*                        number   = '007'
*                        severity = if_abap_behv_message=>severity-success
*                        v1       = lines( lt_countries_create[ 1 ]-%target ) )
*           INTO TABLE reported-%other.
*
*    INSERT new_message( id       = 'ZBS_DEMO_RAP_PATTERN'
*                        number   = '006'
*                        severity = if_abap_behv_message=>severity-success
*                        v1       = lines( lt_countries_modify ) )
*           INTO TABLE reported-%other.
*  ENDMETHOD.
*
*
*
*
*
*
*ENDCLASS.
*
*CLASS lsc_ZCAS_R_DRPCURRENCY DEFINITION INHERITING FROM cl_abap_behavior_saver.
*  PROTECTED SECTION.
*
*    METHODS save_modified REDEFINITION.
*
*    METHODS cleanup_finalize REDEFINITION.
*
*ENDCLASS.
*
*CLASS lsc_ZCAS_R_DRPCURRENCY IMPLEMENTATION.
*
*  METHOD save_modified.
*  LOOP AT update-currency INTO DATA(ls_new_currency).
*      ls_new_currency-LastEditor = cl_abap_context_info=>get_user_technical_name( ).
*
*      INSERT zdas_add_curr FROM @ls_new_currency MAPPING FROM ENTITY.
*      IF sy-subrc <> 0.
*        UPDATE zdas_add_curr FROM @ls_new_currency INDICATORS SET STRUCTURE %control MAPPING FROM ENTITY.
*      ENDIF.
*    ENDLOOP.
*
*    LOOP AT create-country INTO DATA(ls_create_country).
*      INSERT zdas_drp_country FROM @ls_create_country MAPPING FROM ENTITY.
*    ENDLOOP.
*
*    LOOP AT update-country INTO DATA(ls_update_country).
*      UPDATE zdas_drp_country FROM @ls_update_country INDICATORS SET STRUCTURE %control MAPPING FROM ENTITY.
*    ENDLOOP.
*
*    LOOP AT delete-country INTO DATA(ls_delete_country).
*      DELETE zdas_drp_country FROM @( CORRESPONDING zdas_drp_country( ls_delete_country MAPPING FROM ENTITY ) ).
*    ENDLOOP.
*  ENDMETHOD.
*
*  METHOD cleanup_finalize.
*  ENDMETHOD.
*
*ENDCLASS.
