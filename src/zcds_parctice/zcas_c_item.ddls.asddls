@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sum for partner and material'


define view entity ZCAS_C_ITEM
  as select from ZCAS_I_ITEM
{
  key  _Invoice.PartnerNumber,
  key  MaterialNumber,



       PositionCurrency,

       @Semantics.amount.currencyCode: 'PositionCurrency'

       sum ( PositionPrice ) as PriceForPartnerMaterial




}
group by
  _Invoice.PartnerNumber,
  MaterialNumber,
  PositionCurrency
