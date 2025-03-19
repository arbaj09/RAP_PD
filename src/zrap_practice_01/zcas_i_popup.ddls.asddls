@EndUserText.label: 'Entity for popup'
define abstract entity ZCAS_I_POPUP

{

@Consumption.valueHelpDefinition: [{ entity :{name: 'ZCAS_C_CountryVH' ,element: 'Country'} }]
@EndUserText.label: 'Search Country'
    SearchCountry :land1;
    @EndUserText.label: 'New Date'
    NewDate       : abap.dats;
    @EndUserText.label: 'Message Type'
    MessageType   : abap.int4;
    @EndUserText.label: 'Update Data'
    FlagUpdaten    :abap.char( 1 );
    @EndUserText.label: 'Show Message'
    FlagMessage  : abap_boolean;
    
}
