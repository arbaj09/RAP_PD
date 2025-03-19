@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection for INVC-INVOICE'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZCAS_C_INVC 
provider contract transactional_query
as projection on ZCAS_I_INVC
{
@Search.defaultSearchElement: true
    key Document,
    DocDate,
    DocTime,
    Partner,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_BS_DEMO_CRAP_VE_EXIT'
     // cast(0 as abap.int4) as VirtualNumberofPosition,
     virtual NumberOfPositions : abap.int4,
      
         
    /* Associations */
    _Item:redirected to composition child ZCAS_C_IVIT
}
