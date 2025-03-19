@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forZCAS_GEN2P'
@ObjectModel.sapObjectNodeType.name: 'ZZCAS_GEN2P'
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAB', 
  allowNewDatasources: false, 
  allowNewCompositions: true, 
  dataSources: [ '_Extension' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define view entity ZR_ZCAS_GEN2PTP
  as select from zdas_gen2p as ZCAS_GEN2P
  association to parent ZR_ZCAS_GEN2H01TP as _ZCAS_GEN2H on $projection.UuidKey = _ZCAS_GEN2H.UuidKey
  association [1] to ZE_ZCAS_GEN2P as _Extension on $projection.UuidPos = _Extension.UuidPos
{
  key uuid_pos as UuidPos,
  uuid_key as UuidKey,
  
  price as Price,
 @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH', element: 'Currency' } }]
  currency as Currency,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed as LocalLastChanged,
  last_changed as LastChanged,
  _ZCAS_GEN2H,
  _Extension
  
}
