@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'UNION EXAMPLE'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
define view entity ZCAS_C_UNION
  as select from ZCAS_C_ITEMERORR
{
  key DocumentNumber,
  key PositionNumber,
      'Normal' as PositionType,
      @Semantics.amount.currencyCode: 'PositionCurrency'
      PositionPrice,
      PositionCurrency

}

where
  ErrorInConversion = ' '

union select from ZCAS_C_ITEMERORR

{
  key DocumentNumber,
  key PositionNumber,
      'Error'                           as PositionType,
      cast( 0.0 as abap.curr( 15, 2 ) ) as PositionPrice,
      PositionCurrency

}
where
  ErrorInConversion = 'X'
