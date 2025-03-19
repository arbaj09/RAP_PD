@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface for invoice'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
define view entity ZCAS_I_INVOICE
  as select from zdas_invoice

  association [0..1] to ZCAS_I_PARTNER as _Partner on $projection.PartnerNumber = _Partner.PartnerNumber
  association [0..*] to ZCAS_I_ITEM    as _Item    on $projection.DocumentNumber = _Item.DocumentNumber


{
  key document                                 as DocumentNumber,
      doc_date                                 as DocumentDate,
      doc_time                                 as DocumentTime,
      partner                                  as PartnerNumber,
      _Partner.PartnerName,

      dats_add_days( doc_date, 10 , 'INITIAL') as NewDate,

      _Partner,
      _Item
}
