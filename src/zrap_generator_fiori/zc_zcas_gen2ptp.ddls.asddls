@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
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
@ObjectModel.semanticKey: [ 'UuidKey' ]
@Search.searchable: true
define view entity ZC_ZCAS_GEN2PTP
  as projection on ZR_ZCAS_GEN2PTP as ZCAS_GEN2P
{
  key UuidPos,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  UuidKey,
  Price,
  Currency,
  LocalLastChanged,
  LastChanged,
  _ZCAS_GEN2H : redirected to parent ZC_ZCAS_GEN2H01TP
  
}
