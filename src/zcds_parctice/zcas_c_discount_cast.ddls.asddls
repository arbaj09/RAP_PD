@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cast from number'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE


define view entity ZCAS_C_DISCOUNT_CAST
  as select from ZCAS_I_DISCOUNT
{
  key PartnerNumber,
  key MaterialNumber,
      DiscountValue,
      concat( cast (DiscountValue as abap.char(15) ), '%' ) as DiscoutText

}
