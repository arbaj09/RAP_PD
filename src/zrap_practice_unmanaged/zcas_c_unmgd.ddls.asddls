@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for UNMGD'
@Metadata.ignorePropagatedAnnotations: true

@UI: {
  headerInfo: {
    typeName: 'Unmanaged',
    typeNamePlural: 'Unmanaged',
    title: { value: 'Discription' }
  }
}
define root view entity ZCAS_C_UNMGD
  provider contract transactional_query
  as projection on ZCAS_I_UNMGD
{

      @UI.facet      : [
             {
               id         : 'FacetData',
               label      : 'Data',
               type       : #FIELDGROUP_REFERENCE,
               targetQualifier: 'DATA'
             }
           ]

      @UI.lineItem: [{ position: 10, label: 'Key' }]
      @UI.fieldGroup: [{ position: 10, label: 'Key' }]
  key TableKey,
      @UI.selectionField: [{  position: 10 }]
      @UI.lineItem: [{ position: 20, label: 'Text' }]
      @UI.fieldGroup: [{ position: 20, label: 'Text', qualifier: 'DATA' }]
      Discription,
      @UI.selectionField: [{  position: 20 }]
      @UI.lineItem: [{ position: 30, label: 'Created at' }]
      @UI.fieldGroup: [{ position: 20, label: 'Text', qualifier: 'DATA' }]
      CreationDate
}
