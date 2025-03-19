@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection for  IVIT- ITEM'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define  view entity ZCAS_C_IVIT as projection on ZCAS_I_IVIT
{
    
    key Document,
    key PosNumber,
    Material,
    @Semantics.quantity.unitOfMeasure: 'StockUnit'
    Quantity,
    StockUnit,
    @Semantics.amount.currencyCode: 'Currency'
    Price,
    Currency,
    
    /* Associations */
    _Invoice:redirected to parent ZCAS_C_INVC
}
