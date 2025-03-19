@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Draft query view forZCAS_GEN2P'
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
define view entity ZR_ZCAS_GEN2P_D
  as select from ZZCAS_GEN2P00D as ZCAS_GEN2P
{
  key UuidPos as UuidPos,
  UuidKey as UuidKey,
  Price as Price,
  Currency as Currency,
  LocalLastChanged as LocalLastChanged,
  LastChanged as LastChanged,
  draftentitycreationdatetime as Draftentitycreationdatetime,
  draftentitylastchangedatetime as Draftentitylastchangedatetime,
  draftadministrativedatauuid as Draftadministrativedatauuid,
  draftentityoperationcode as Draftentityoperationcode,
  hasactiveentity as Hasactiveentity,
  draftfieldchanges as Draftfieldchanges
  
}
