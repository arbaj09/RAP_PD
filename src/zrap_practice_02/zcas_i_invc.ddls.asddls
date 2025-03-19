@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface for invoice'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZCAS_I_INVC
  as select from zdas_invoice
  composition [0..*] of ZCAS_I_IVIT as _Item

{

  @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 1.0
  key document as Document,
      doc_date as DocDate,
      doc_time as DocTime,
         @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.9
      partner  as Partner,



      _Item
}
