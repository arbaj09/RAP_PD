@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forZCAS_GEN2P'
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAB', 
  allowNewDatasources: false, 
  allowNewCompositions: true, 
  dataSources: [ 'ZCAS_GEN2P' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define view entity ZI_ZCAS_GEN2PTP
  as projection on ZR_ZCAS_GEN2PTP as ZCAS_GEN2P
{
  key UuidPos,
  UuidKey,
  Price,
  Currency,
  LocalLastChanged,
  LastChanged,
  _ZCAS_GEN2H : redirected to parent ZI_ZCAS_GEN2H01TP
  
}
