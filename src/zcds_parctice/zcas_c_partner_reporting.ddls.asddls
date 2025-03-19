@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Currency Conversion-Reporting For Partner'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE

define view entity ZCAS_C_PARTNER_REPORTING
  with parameters
    @Environment.systemField: #SYSTEM_DATE
    P_CalculationDate : abap.dats
  as select from ZCAS_C_PARTNERSUM
{
  key PartnerNumber,
      PositionCurrency,
      @Semantics.amount.currencyCode: 'PositionCurrency'

      PriceForPartnerMetarial,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      currency_conversion(
      amount => PriceForPartnerMetarial,
      source_currency => PositionCurrency,
      round => 'X' ,
      target_currency => cast('USD' as abap.cuky( 5 )),
      exchange_rate_date => $parameters.P_CalculationDate,
      exchange_rate_type => 'M',
      error_handling => 'SET_TO_NULL'


      ) as PriceInUSD


}
