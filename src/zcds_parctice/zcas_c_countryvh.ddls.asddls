@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search help for country'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
   
    
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZCAS_C_CountryVH as select from I_Country

{
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH
    @ObjectModel.text.element: [ 'Description' ]
    key Country,
    
   
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #LOW
    _Text[1:Language = $session.system_language].CountryName as Description
}
