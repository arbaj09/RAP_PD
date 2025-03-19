@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Statistic for high performer'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE

define view entity ZCAS_C_StatisticParMat
  as select from ZCAS_C_ITEM                   as Combine
    inner join   ZCAS_C_PARTNER_MATERIAL_COUNT as Number on  Combine.PartnerNumber  = Number.PartnerNumber
                                                         and Combine.MaterialNumber = Number.MaterialNumber
{
  key Combine.PartnerNumber,
  key Combine.MaterialNumber,
      Combine.PositionCurrency,
      @Semantics.amount.currencyCode: 'PositionCurrency'

      Combine.PriceForPartnerMaterial,
      Number.NumberOfDocument

}

where
      Number.NumberOfDocument         >= 10
  and Combine.PriceForPartnerMaterial <= 100000
