--@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS WITH PARAMETER'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE

define view entity ZCAS_C_PARAMETER
  with parameters
    P_Date  : abap.dats,
    P_type  : abap.char( 1 ),
    P_Field : abap.char( 10 )
  as select from ZCAS_I_INVOICE
{
  key DocumentNumber,
      DocumentDate,
      _Partner.PartnerName,
      _Partner.Country,
      case $parameters.P_type
          when 'A' then 'New'
          when 'B' then 'old'
          else 'unknown'
          end             as Status,
      $parameters.P_Field as ImportedField

}
where
  DocumentDate = $parameters.P_Date
