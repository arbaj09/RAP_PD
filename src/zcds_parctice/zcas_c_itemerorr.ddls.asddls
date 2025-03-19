@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item with error'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZCAS_C_ITEMERORR
  as select from ZCAS_I_ITEM
{
  key DocumentNumber,
  key PositionNumber,
      MaterialNumber,
      @Semantics.quantity.unitOfMeasure: 'PositonStockUnit'
      PositionQuantity,
      PositonStockUnit,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      PositionPrice,
      PositionCurrency,
      case PositionPrice

          when 37707 then 'X'
          else ' '
          end as ErrorInConversion



}
