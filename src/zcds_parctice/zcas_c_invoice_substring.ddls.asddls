@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Substring for month'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCAS_C_INVOICE_SUBSTRING
  as select from ZCAS_I_INVOICE
{
  key DocumentNumber,
      DocumentDate,
      substring(DocumentDate , 5 ,2 ) as MonthInDocumentdate,
      PartnerNumber



}
