@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Country Assignment'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCAS_I_CURRENCY_COUNTRY as select from ZCAS_B_DRPCOUNTRY
association   to parent  ZCAS_R_DRPCURRENCY as _currency on _currency.Currency = $projection.Currency
association of one to one I_Country as _Country on _Country.Country = $projection.Country
{
    key Currency,
    key Country,
    CountryRanking,
    _currency,
    _Country._Text[ Language = $session.system_language ].CountryName
}
