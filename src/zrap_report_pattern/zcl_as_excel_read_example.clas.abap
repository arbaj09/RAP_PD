CLASS zcl_as_excel_read_example DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_dummy_excel_stream
      RETURNING VALUE(rd_result) TYPE xstring.

    METHODS get_all_from_sheet.

ENDCLASS.



CLASS zcl_as_excel_read_example IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
 DATA(ld_stream) = get_dummy_excel_stream( ).
  DATA(lo_document) = xco_cp_xlsx=>document->for_file_content( ld_stream )->read_access( ).
  LOOP AT lo_document->get_workbook( )->worksheet->all->get( ) INTO DATA(lo_sheet).
  out->write( lo_sheet->get_name( ) ).
ENDLOOP.
*  DATA(ld_stream) = get_dummy_excel_stream( ).
*    DATA(lo_document) = xco_cp_xlsx=>document->for_file_content( ld_stream )->read_access( ).
*    DATA(lo_sheet) = lo_document->get_workbook( )->worksheet->for_name( cs_sheets-users ).
  ENDMETHOD.
  METHOD get_all_from_sheet.
*   DATA(ld_stream) = get_dummy_excel_stream( ).
*    DATA(lo_document) = xco_cp_xlsx=>document->for_file_content( ld_stream )->read_access( ).
*    DATA(lo_sheet) = lo_document->get_workbook( )->worksheet->for_name( cs_sheets-users ).
*
 ENDMETHOD.

 METHOD get_dummy_excel_stream.

 ENDMETHOD.

ENDCLASS.
