@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for Currency'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: ['Currency']
define root view entity ZCAS_C_DRPCURRENCY 
provider contract transactional_query
as projection on ZCAS_R_DRPCURRENCY
{
@Search.defaultSearchElement: true
@Search.fuzzinessThreshold: 1.0
@Search.ranking: #HIGH
    key Currency,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @Search.ranking: #MEDIUM
    CurrencyName,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #MEDIUM
    CurrencyShortName,
    _Country : redirected to composition child  ZCAS_C_CURRENCY_COUNTRY,
    
    
    Decimals,
    CurrencyISOCode,
    AlternativeCurrencyKey,
    LastEditor,
    CurrencyComment,
    PictureURL,
    Documentation,
    @Semantics.largeObject:{
    mimeType: 'ExcelMimetype',
    fileName: 'ExcelFilename',
    contentDispositionPreference: #INLINE,
    acceptableMimeTypes: [ 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ]
    
    }
     ExcelAttachement,
      ExcelMimetype,
      ExcelFilename,
      @Semantics.largeObject:{
      mimeType: 'PictureMimetype',
      fileName: 'PictureFilename',
      contentDispositionPreference: #ATTACHMENT,
      acceptableMimeTypes: [ 'image/*'  ]
      
      }
      PictureAttachement,
      PictureMimetype,
      PictureFilename
    
    

    
}
