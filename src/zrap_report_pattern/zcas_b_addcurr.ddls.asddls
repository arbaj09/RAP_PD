@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for ZDAS_ADD_CURR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCAS_B_ADDCURR as select from zdas_add_curr
{
  key curreny      as Currency,
      ccomment      as CurrencyComment,
      documentation as Documentation,
      picture_url   as PictureURL,
      last_editor   as LastEditor,
      last_changed  as LastChanged,
      excel_attachment   as ExcelAttachement,
      excel_mimetype     as ExcelMimetype,
      excel_filename     as ExcelFilename,
      picture_attachment as PictureAttachement,
      picture_mimetype   as PictureMimetype,
      picture_filename   as PictureFilename,
      local_last_changed as LocalLastChanged
}
