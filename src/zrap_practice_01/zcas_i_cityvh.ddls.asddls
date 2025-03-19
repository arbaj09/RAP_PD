@EndUserText.label: 'City Value Help'
@ObjectModel.query.implementedBy: 'ABAP:ZCAS_QUERY_PROVIDER'
define custom entity ZCAS_I_CITYVH

{

      @EndUserText.label: 'City'
      @EndUserText.quickInfo: 'Name of the City'
  key City      : abap.char(60);
      @EndUserText.label: 'City (Short)'
      @EndUserText.quickInfo: 'Short name of the City'
      CityShort : abap.char(10);

}
