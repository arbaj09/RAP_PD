@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interace for UNMAGD'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZCAS_I_UNMGD as select from zdas_unmgd
{
    key gen_key as TableKey,
    text as Discription,
    cdate as CreationDate,
    last_changed as Last_Changed
    
}
