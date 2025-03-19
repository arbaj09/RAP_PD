CLASS ZCL_TEST_AS DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS:
      c_destination TYPE string VALUE `https://11b69711-9bcb-491b-b504-a9ba7e4b7e97.abap-web.us10.hana.ondemand.com/sap/opu/odata/sap/ZCAS_API_COMPANY_NAMES_O2`.

    METHODS:
      get_client
        RETURNING VALUE(ro_result) TYPE REF TO if_web_http_client
        RAISING
                  cx_http_dest_provider_error
                  cx_web_http_client_error.
ENDCLASS.


CLASS ZCL_TEST_AS IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA:
      lt_business_data TYPE TABLE OF zcas_i_cname.

    TRY.
        DATA(lo_client_proxy) = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'ZCAS_RAP_ONPREM_ODATA'
            io_http_client             = get_client( )
            iv_relative_service_root   = '/sap/opu/odata/sap/ZCAS_API_COMPANY_NAMES_O2' ).

        DATA(lo_request) = lo_client_proxy->create_resource_for_entity_set( 'ZCAS_I_CNAME' )->create_request_for_read( ).
        lo_request->set_top( 50 )->set_skip( 0 ).

        DATA(lo_response) = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

        out->write( 'Data on-premise found:' ).
        out->write( lt_business_data ).

      CATCH cx_root INTO DATA(lo_error).
        out->write( lo_error->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD get_client.
    DATA(lo_destination) = cl_http_destination_provider=>create_by_url(
 c_destination

    ).

    ro_result  = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
  ENDMETHOD.
ENDCLASS.
