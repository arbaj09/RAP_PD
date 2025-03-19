@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Currency Overview'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZCAS_R_DRPCURRENCY as select from I_Currency
composition of many ZCAS_I_CURRENCY_COUNTRY as _Country
association of one to one ZCAS_B_ADDCURR as _Data on _Data.Currency = $projection.Currency
//association of one to one I_BusinessUserVH as _User on _User.UserID = $projection.lasteditor
{

    key Currency,
    Decimals,
    CurrencyISOCode,
    AlternativeCurrencyKey,
    _Data.LastChanged,
    _Data.LocalLastChanged,
    _Data.CurrencyComment,
    _Data.Documentation,
    _Data.PictureURL,
    _Data.ExcelAttachement,
      _Data.ExcelMimetype,
      _Data.ExcelFilename,
      _Data.PictureAttachement,
      _Data.PictureMimetype,
      _Data.PictureFilename,
    
    
    _Country,
    
    _Data.LastEditor,
      _Text[ Language = $session.system_language ].CurrencyName,
      _Text[ Language = $session.system_language ].CurrencyShortName

    /* Associations */
    //_Text,
    //_association_name // Make association public
}
