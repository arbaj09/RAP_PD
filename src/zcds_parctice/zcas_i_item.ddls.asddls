@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface for item'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
define view entity ZCAS_I_ITEM
  as select from zdas_item

  association [0..1] to ZCAS_I_INVOICE  as _Invoice  on $projection.DocumentNumber = _Invoice.DocumentNumber
  association [0..1] to ZCAS_I_MATERIAL as _Material on $projection.MaterialNumber = _Material.MaterialNumber




{
  key document   as DocumentNumber,
  key pos_number as PositionNumber,
      material   as MaterialNumber,
      @Semantics.quantity.unitOfMeasure: 'PositonStockUnit'
      quantity   as PositionQuantity,
      stock_unit as PositonStockUnit,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      price      as PositionPrice,
      currency   as PositionCurrency,
      _Invoice,
      _Material

}
