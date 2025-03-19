@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for INVOICE ITEM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCAS_I_IVIT as select from zdas_item
association    to parent ZCAS_I_INVC as _Invoice on $projection.Document = _Invoice.Document
{
    key document as Document,
    key pos_number as PosNumber,
    material as Material,
    @Semantics.quantity.unitOfMeasure: 'StockUnit'
    quantity as Quantity,
    stock_unit as StockUnit,
    @Semantics.amount.currencyCode: 'Currency'
    price as Price,
    currency as Currency,
    _Invoice
    
}
