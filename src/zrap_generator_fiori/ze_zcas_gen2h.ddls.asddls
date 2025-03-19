@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extension include view forZCAS_GEN2H'
@AbapCatalog.viewEnhancementCategory: [ #PROJECTION_LIST ]
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAA', 
  allowNewDatasources: false, 
  allowNewCompositions: false, 
  dataSources: [ 'ZCAS_GEN2H' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define view entity ZE_ZCAS_GEN2H
  as select from ZDAS_GEN2H as ZCAS_GEN2H
{
  key UUID_KEY as UuidKey
  
}
