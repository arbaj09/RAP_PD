@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface for discount'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
define view entity ZCAS_I_DISCOUNT
  as select from zdas_discount
  association [0..1] to ZCAS_I_PARTNER  as _Partner  on $projection.PartnerNumber = _Partner.PartnerNumber
  association [0..1] to ZCAS_I_MATERIAL as _Material on $projection.MaterialNumber = _Material.MaterialNumber
{
  key partner  as PartnerNumber,
  key material as MaterialNumber,
      discount as DiscountValue,
      _Partner,
      _Material
}
