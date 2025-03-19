@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extension include view forZCAS_GEN2P'
@AbapCatalog.viewEnhancementCategory: [ #PROJECTION_LIST ]
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAB', 
  allowNewDatasources: false, 
  allowNewCompositions: false, 
  dataSources: [ 'ZCAS_GEN2P' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define view entity ZE_ZCAS_GEN2P
  as select from ZDAS_GEN2P as ZCAS_GEN2P
{
  key UUID_POS as UuidPos
  
}
