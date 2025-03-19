
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Virtual Elements -Exist in CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCAS_C_ITEM_PRICE_PER_UNIT as select from ZCAS_I_ITEM
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
    
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_PDAS_DEMO_CDS_EXIT'
    @Semantics.amount.currencyCode: 'PositionCurrency'
    
    cast( 0 as abap.curr(15,2) ) as PricePerUnit
    
}
