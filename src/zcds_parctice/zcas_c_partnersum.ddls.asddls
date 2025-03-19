@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sum for partner'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE

define view entity ZCAS_C_PARTNERSUM
  as select from ZCAS_I_ITEM
{

  key _Invoice.PartnerNumber,
      PositionCurrency,

     @Semantics.amount.currencyCode: 'PositionCurrency'

      sum (PositionPrice) as PriceForPartnerMetarial
      

      
            
      

}

group by
  _Invoice.PartnerNumber,
  PositionCurrency

