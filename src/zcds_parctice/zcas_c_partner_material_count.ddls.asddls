@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'count for partner and material'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE

define view entity ZCAS_C_PARTNER_MATERIAL_COUNT as select from ZCAS_I_ITEM
{
    key  _Invoice.PartnerNumber,
    key MaterialNumber,
            count( * ) as NumberOfDocument
    
}

group by
_Invoice.PartnerNumber,
MaterialNumber

 