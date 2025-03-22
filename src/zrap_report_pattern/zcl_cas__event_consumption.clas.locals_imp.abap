
CLASS lcl_local_events DEFINITION INHERITING FROM cl_abap_behavior_event_handler.
  PRIVATE SECTION.

   TYPES ts_parameter TYPE STRUCTURE FOR EVENT zcas_r_drpcurrency\\currency~afterexcelload.
    TYPES td_mail      TYPE REF TO cl_bcs_mail_message.
    TYPES tt_mail      TYPE STANDARD TABLE OF td_mail WITH EMPTY KEY.

    CONSTANTS c_sender TYPE cl_bcs_mail_message=>ty_address VALUE 'arbaaz.sh001@gmail.com'.

    DATA mt_mails TYPE tt_mail.
    METHODS after_excel_load FOR ENTITY EVENT it_parameters FOR Currency~AfterExcelLoad.



    METHODS send_mail_to_receiver
      IMPORTING is_parameter TYPE ts_parameter.

    METHODS get_receiver
      IMPORTING is_parameter     TYPE ts_parameter
      RETURNING VALUE(rd_result) TYPE cl_bcs_mail_message=>ty_address.

    METHODS get_mail_content
      IMPORTING is_parameter     TYPE ts_parameter
      RETURNING VALUE(rd_result) TYPE string.
ENDCLASS.


CLASS lcl_local_events IMPLEMENTATION.

  METHOD after_excel_load.
    IF 0 = 0.
    ENDIF.
  ENDMETHOD.

   METHOD send_mail_to_receiver.
    TRY.
        DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).

        DATA(ld_receiver) = get_receiver( is_parameter ).
        DATA(ld_content) = get_mail_content( is_parameter ).

        lo_mail->set_sender( c_sender ).
        lo_mail->add_recipient( ld_receiver ).

        lo_mail->set_subject( |Currency Changed ({ is_parameter-Currency })| ).

        lo_mail->set_main( cl_bcs_mail_textpart=>create_instance( iv_content      = ld_content
                                                                  iv_content_type = 'text/html' ) ).

        INSERT lo_mail INTO TABLE mt_mails.
      CATCH cx_bcs_mail.
    ENDTRY.
  ENDMETHOD.

 METHOD get_receiver.
  rd_result = 'shaikharbaj092@gmail.com'.
ENDMETHOD.

    METHOD get_mail_content.

    READ ENTITIES OF zcas_r_drpcurrency
         ENTITY Currency
         ALL FIELDS WITH VALUE #( ( Currency = is_parameter-Currency ) )
         RESULT DATA(lt_currency).

    DATA(ls_currency) = VALUE #( lt_currency[ 1 ] OPTIONAL ).

    DATA(ld_base64) = cl_web_http_utility=>encode_x_base64( ls_currency-PictureAttachement ).

    DATA(ld_message) = |<h3>{ is_parameter-EventComment }</h3>|.
    ld_message &&= |<img src="data:{ ls_currency-PictureMimetype };base64, { ld_base64 }" style="height:200px; width: 200px" />|.
    ld_message &&= |<p>{ ls_currency-CurrencyComment }</p>|.

    RETURN ld_message.
  ENDMETHOD.
ENDCLASS.
*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations>
