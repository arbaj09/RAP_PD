@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Complete Invoice Document  join'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCAS_C_COMPLETE_DOCUMENT
  as select from ZCAS_I_ITEM    as Position
    inner join   ZCAS_I_INVOICE as Head    on Head.DocumentNumber = Position.DocumentNumber
    inner join   ZCAS_I_PARTNER as Partner on Partner.PartnerNumber = Head.PartnerNumber



{
  key Position.DocumentNumber,
  key Position.PositionNumber,
      Head.PartnerNumber,
      Partner.PartnerName,
      Partner.City,
      Partner.Country,
      Position.MaterialNumber,
      @Semantics.quantity.unitOfMeasure: 'PositonStockUnit'
      Position.PositionQuantity,
      Position.PositonStockUnit,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      Position.PositionPrice,
      Position.PositionCurrency,
      Head.DocumentDate


}
