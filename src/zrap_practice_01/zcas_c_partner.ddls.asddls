@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection for partner interface'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZCAS_C_PARTNER 
provider contract transactional_query
as projection on ZCAS_I_PARTNER
{
    key PartnerNumber,
    PartnerName,
    Street,
    @Consumption.valueHelpDefinition: [{ entity:{name: 'ZCAS_I_CITYVH',element: 'City'} }]
    City,
    @Consumption.valueHelpDefinition: [{ entity :{name: 'ZCAS_C_CountryVH', element: 'Country'} }]
    Country,
    @Consumption.valueHelpDefinition: [{ entity:{name: 'I_CurrencyStdVH' , element: 'Currency'}  }]

    PaymentCurrency,
    
    CreatedAt,
    CreatedBy,
    LastChangedAt,
    LastChangedBy,
    /* Associations */
    _Country,
    _Currency
}
