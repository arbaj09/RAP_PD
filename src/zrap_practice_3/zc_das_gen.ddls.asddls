@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_DAS_GEN
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_DAS_GEN
{
  key UuidKey,
  Description,
  Price,
  @Semantics.currencyCode: true
  Currency,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
