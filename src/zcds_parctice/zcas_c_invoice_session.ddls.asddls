@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'session infromation'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZCAS_C_INVOICE_SESSION
  as select from ZCAS_I_INVOICE
{
  key DocumentNumber,
      DocumentDate,

      $session.system_language as SystemLanguage,

      $session.system_date     as Current_Dates


}

where
  DocumentDate < $session.system_date  
