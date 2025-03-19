@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for Country Assignment'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['Currency']
define view entity ZCAS_C_CURRENCY_COUNTRY 
 as projection on ZCAS_I_CURRENCY_COUNTRY
{
    key Currency,
    @Consumption.valueHelpDefinition: [{ entity :{ name: 'I_CountryVH' , element: 'Country'}  }]
    key Country,
    CountryRanking,
    CountryName,
    /* Associations */
    _currency : redirected to parent ZCAS_C_DRPCURRENCY
}
