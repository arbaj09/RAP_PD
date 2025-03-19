@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Draft query view forZCAS_GEN2H'
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
define view entity ZR_ZCAS_GEN2H_D
  as select from ZZCAS_GEN2H00D as ZCAS_GEN2H
{
  key UuidKey as UuidKey,
  Description as Description,
  IsActive as IsActive,
  LocalLastChanged as LocalLastChanged,
  LastChanged as LastChanged,
  draftentitycreationdatetime as Draftentitycreationdatetime,
  draftentitylastchangedatetime as Draftentitylastchangedatetime,
  draftadministrativedatauuid as Draftadministrativedatauuid,
  draftentityoperationcode as Draftentityoperationcode,
  hasactiveentity as Hasactiveentity,
  draftfieldchanges as Draftfieldchanges
  
}
