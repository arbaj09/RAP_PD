CLASS ZCL_AS_API DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    " Define API Key as a constant
    CONSTANTS: c_api_key TYPE string VALUE '5b0d11e80f018b1dd886580bac17445d'.

    METHODS:
      read_data IMPORTING i_city TYPE string  " Dynamic city input
                          i_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.

CLASS ZCL_AS_API IMPLEMENTATION.

  METHOD read_data.


    DATA(lv_api_endpoint) = |https://api.openweathermap.org/data/2.5/weather?q={ i_city }&appid={ c_api_key }|.

    " Define JSON structure for response
    TYPES:
      BEGIN OF ty_main,
        temp TYPE f,  " Temperature in Kelvin
      END OF ty_main,

      BEGIN OF ty_wind,
        speed TYPE f,  " Wind speed in m/s
      END OF ty_wind,

      BEGIN OF ty_sys,
        country TYPE string,  " Country code
      END OF ty_sys,

      BEGIN OF ty_weather_response,
        name TYPE string,  " City name
        main TYPE ty_main,  " Weather details
        wind TYPE ty_wind,  " Wind details
        sys  TYPE ty_sys,   " System data
      END OF ty_weather_response.

    " Declare structure for JSON response
    DATA: ls_weather_response TYPE ty_weather_response.

    TRY.
        " Create HTTP Destination
        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( lv_api_endpoint ).

        " Create HTTP Client
        DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        " Execute GET request
        DATA(lo_response) = lo_client->execute( i_method = if_web_http_client=>get ).

        " Read API response
        DATA(lv_response_text) = lo_response->get_text( ).

        " Deserialize JSON response into ABAP structure
        /ui2/cl_json=>deserialize(
          EXPORTING json = lv_response_text
          CHANGING data = ls_weather_response
        ).

        " Convert temperature from Kelvin to Celsius
        DATA(lv_temp_celsius) = ls_weather_response-main-temp - '273.15' .

        " Display extracted values
        i_out->write( |City: { ls_weather_response-name }| ).
        i_out->write( |Country: { ls_weather_response-sys-country }| ).
        i_out->write( |Temperature (°C): { lv_temp_celsius }| ).
        i_out->write( |Wind Speed: { ls_weather_response-wind-speed } m/s| ).

      CATCH cx_http_dest_provider_error INTO DATA(lo_http_error).
        i_out->write( 'HTTP Destination Error: ' && lo_http_error->get_text( ) ).

      CATCH cx_web_http_client_error INTO DATA(lo_client_error).
        i_out->write( 'HTTP Client Error: ' && lo_client_error->get_text( ) ).

      CATCH cx_root INTO DATA(lo_generic_error).
        i_out->write( 'Unexpected Error: ' && lo_generic_error->get_text( ) ).

    ENDTRY.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    " Call read_data with a dynamically provided city
   read_data( i_city = 'Delhi' i_out = out ).
  ENDMETHOD.

ENDCLASS.





*CLASS ZCL_AS_API DEFINITION
*  PUBLIC
*  FINAL
*  CREATE PUBLIC.
*
*  PUBLIC SECTION.
*    INTERFACES if_oo_adt_classrun.
*
*  PRIVATE SECTION.
*    CONSTANTS:
*      c_api_endpoint TYPE string VALUE 'https://api.openweathermap.org/data/2.5/weather?q=Chicago&appid=5b0d11e80f018b1dd886580bac17445d'.
*
*    METHODS:
*      read_data IMPORTING i_out TYPE REF TO if_oo_adt_classrun_out.
*
*ENDCLASS.
*
*CLASS ZCL_AS_API IMPLEMENTATION.
*
*  METHOD read_data.
*
*    " Define JSON structure based on API response
*    TYPES:
*      BEGIN OF ty_main,
*        temp TYPE f,  " Temperature in Kelvin
*      END OF ty_main,
*
*      BEGIN OF ty_wind,
*        speed TYPE f,  " Wind speed in m/s
*      END OF ty_wind,
*
*      BEGIN OF ty_sys,
*        country TYPE string,  " Country code (e.g., "IN" for India)
*      END OF ty_sys,
*
*      BEGIN OF ty_weather_response,
*        name TYPE string,  " City name (e.g., "Delhi")
*        main TYPE ty_main,  " Weather details
*        wind TYPE ty_wind,  " Wind details
*        sys  TYPE ty_sys,   " System data (Country)
*      END OF ty_weather_response.
*
*    " Declare structure for JSON response
*    DATA: ls_weather_response TYPE ty_weather_response.
*
*    TRY.
*        " Create HTTP Destination
*        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( c_api_endpoint ).
*
*        " Create HTTP Client
*        DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*
*        " Execute GET request
*        DATA(lo_response) = lo_client->execute( i_method = if_web_http_client=>get ).
*
*        " Read API response
*        DATA(lv_response_text) = lo_response->get_text( ).
*
*        " Deserialize JSON response into ABAP structure
*        /ui2/cl_json=>deserialize(
*          EXPORTING json = lv_response_text
*          CHANGING data = ls_weather_response
*        ).
*
*        " Convert temperature from Kelvin to Celsius
*        DATA(lv_temp_celsius) = ls_weather_response-main-temp - 273.
*
*        " Display extracted values
*        i_out->write( |City: { ls_weather_response-name }| ).
*        i_out->write( |Country: { ls_weather_response-sys-country }| ).
*        i_out->write( |Temperature (°C): { lv_temp_celsius }| ).
*        i_out->write( |Wind Speed: { ls_weather_response-wind-speed } m/s| ).
*
*      CATCH cx_http_dest_provider_error INTO DATA(lo_http_error).
*        i_out->write( 'HTTP Destination Error: ' && lo_http_error->get_text( ) ).
*
*      CATCH cx_web_http_client_error INTO DATA(lo_client_error).
*        i_out->write( 'HTTP Client Error: ' && lo_client_error->get_text( ) ).
*
*      CATCH cx_root INTO DATA(lo_generic_error).
*        i_out->write( 'Unexpected Error: ' && lo_generic_error->get_text( ) ).
*
*    ENDTRY.
*
*  ENDMETHOD.
*
*  METHOD if_oo_adt_classrun~main.
*    read_data( out ).
*  ENDMETHOD.
*
*ENDCLASS.






*CLASS ZCL_AS_API DEFINITION
*  PUBLIC
*  FINAL
*  CREATE PUBLIC.
*
*  PUBLIC SECTION.
*    INTERFACES if_oo_adt_classrun.
*
*  PRIVATE SECTION.
*    CONSTANTS:
*      c_api_endpoint TYPE string VALUE 'https://api.openweathermap.org/data/2.5/weather?q=Delhi&appid=5b0d11e80f018b1dd886580bac17445d'.
*
*
*
*    METHODS:
*      read_data IMPORTING i_out TYPE REF TO if_oo_adt_classrun_out.
*
*ENDCLASS.
*
*CLASS ZCL_AS_API IMPLEMENTATION.
*
*  METHOD read_data.
*
*    TRY.
*        " Create HTTP Destination using create_by_url
*        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( c_api_endpoint ).
*
*        " Create HTTP Client from the Destination
*        DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
*
*        " Execute GET request
*        DATA(lo_response) = lo_client->execute( i_method = if_web_http_client=>get ).
*
*        " Read response data
*        DATA(lv_response_text) = lo_response->get_text( ).
*
*        " Parse JSON response
*        DATA: lt_json TYPE TABLE OF string,
*              ls_data TYPE TABLE OF string.
*
*        SPLIT lv_response_text AT ',' INTO TABLE lt_json.
*
*        " Define structure to hold parsed data
*        DATA: lv_city        TYPE string,
*              lv_country     TYPE string,
*              lv_temp_kelvin TYPE string,
*              lv_temp_celsius TYPE string,
*              lv_wind_speed  TYPE string.
*
*        LOOP AT lt_json INTO DATA(lv_line).
*          IF lv_line CP '*"name":*'.
*            lv_city = lv_line+8.
*            REPLACE ALL OCCURRENCES OF '"' IN lv_city WITH space.
*          ELSEIF lv_line CP '*"country":*'.
*            lv_country = lv_line+11.
*            REPLACE ALL OCCURRENCES OF '"' IN lv_country WITH space.
*          ELSEIF lv_line CP '*"temp":*'.
*            lv_temp_kelvin = lv_line+7.
*          ELSEIF lv_line CP '*"speed":*'.
*            lv_wind_speed = lv_line+8.
*          ENDIF.
*        ENDLOOP.
*
*        " Convert temperature from Kelvin to Celsius
*        DATA(lv_temp_kelvin_num) = lv_temp_kelvin.
*        DATA(lv_temp_celsius_num) = lv_temp_kelvin_num - 273.
*        lv_temp_celsius = lv_temp_celsius_num.
*
*        " Display extracted values
*        i_out->write( |City: { lv_city }| ).
*        i_out->write( |Country: { lv_country }| ).
*        i_out->write( |Temperature (°C): { lv_temp_celsius }| ).
*        i_out->write( |Wind Speed: { lv_wind_speed } m/s| ).
*
*      CATCH cx_http_dest_provider_error INTO DATA(lo_http_error).
*        i_out->write( 'HTTP Destination Error: ' && lo_http_error->get_text( ) ).
*
*      CATCH cx_web_http_client_error INTO DATA(lo_client_error).
*        i_out->write( 'HTTP Client Error: ' && lo_client_error->get_text( ) ).
*
*      CATCH cx_root INTO DATA(lo_generic_error).
*        i_out->write( 'Unexpected Error: ' && lo_generic_error->get_text( ) ).
*
*    ENDTRY.
*
*  ENDMETHOD.
*
*  METHOD if_oo_adt_classrun~main.
*    read_data( out ).
*  ENDMETHOD.
*
*ENDCLASS.

