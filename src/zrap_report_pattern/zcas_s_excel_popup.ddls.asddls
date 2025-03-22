@EndUserText.label: 'Excel Pop'
define abstract entity ZCAS_S_EXCEL_POPUP

{
  @EndUserText.label: 'Comment'
  EventComment : abap.char(60);
  @EndUserText.label: 'Test run'
  TestRun      : abap_boolean;

}
