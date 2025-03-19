@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
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
@ObjectModel.semanticKey: [ 'UuidKey' ]
@Search.searchable: true
define root view entity ZC_ZCAS_GEN2H01TP
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_ZCAS_GEN2H01TP as ZCAS_GEN2H
{
  key UuidKey,
  Description,
  IsActive,
  LocalLastChanged,
  LastChanged,
  _ZCAS_GEN2P : redirected to composition child ZC_ZCAS_GEN2PTP
  
}
