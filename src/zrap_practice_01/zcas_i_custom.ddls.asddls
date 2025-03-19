@EndUserText.label: 'Custom entity for company Name'
@ObjectModel.query.implementedBy: 'ABAP:ZBP__CAS_CNAME_QUERY'
define custom entity ZCAS_I_CUSTOM

{
   key CompanyName        : abap.char( 60 );
      Branch             : abap.char( 50 );
      CompanyDescription : abap.char( 255 );
  
}
