@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility.extensible: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds extension'
@Metadata.ignorePropagatedAnnotations: true


define view entity ZCAS_C_DISCOUNT_EXTENSION
  as select from ZCAS_I_DISCOUNT
{
  key PartnerNumber,
  key MaterialNumber,
      DiscountValue,
      
      concat_with_space(cast(DiscountValue as abap.char( 12 ) ),'%',2) as dicountInPer,
      /* Associations */
      _Material.MaterialName,
      _Material.MaterialDescription
}
