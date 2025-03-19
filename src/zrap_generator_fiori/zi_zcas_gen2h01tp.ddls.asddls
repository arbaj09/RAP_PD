@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forZCAS_GEN2H'
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAA', 
  allowNewDatasources: false, 
  allowNewCompositions: true, 
  dataSources: [ 'ZCAS_GEN2H' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define root view entity ZI_ZCAS_GEN2H01TP
  provider contract TRANSACTIONAL_INTERFACE
  as projection on ZR_ZCAS_GEN2H01TP as ZCAS_GEN2H
{
  key UuidKey,
  Description,
  IsActive,
  LocalLastChanged,
  LastChanged,
  _ZCAS_GEN2P : redirected to composition child ZI_ZCAS_GEN2PTP
  
}
