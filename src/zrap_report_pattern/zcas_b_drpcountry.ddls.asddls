@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interfaceforZDASDRCOUNCountryAssignment'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCAS_B_DRPCOUNTRY as select from zdas_drp_country
{
key currency as Currency,
  key country  as Country,
      ranking  as CountryRanking
}
