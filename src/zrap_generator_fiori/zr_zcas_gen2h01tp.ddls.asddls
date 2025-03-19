@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forZCAS_GEN2H'
@ObjectModel.sapObjectNodeType.name: 'ZZCAS_GEN2H'
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAA', 
  allowNewDatasources: false, 
  allowNewCompositions: true, 
  dataSources: [ '_Extension' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define root view entity ZR_ZCAS_GEN2H01TP
  as select from ZDAS_GEN2H as ZCAS_GEN2H
  association [1] to ZE_ZCAS_GEN2H as _Extension on $projection.UuidKey = _Extension.UuidKey
  composition [0..*] of ZR_ZCAS_GEN2PTP as _ZCAS_GEN2P
{
  key UUID_KEY as UuidKey,
  DESCRIPTION as Description,
  IS_ACTIVE as IsActive,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED as LocalLastChanged,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED as LastChanged,
  _ZCAS_GEN2P,
  _Extension
  
}
