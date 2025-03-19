@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Conversion for Units'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCAS_C_MATERIAL_CONVERSION
  as select from ZCAS_I_MATERIAL
{
  key MaterialNumber,
      MaterialName,

      @Semantics.quantity.unitOfMeasure: 'StockUnit'
      Stock,


      StockUnit,

      @Semantics.quantity.unitOfMeasure: 'StockUnit'
      unit_conversion(
          quantity     => Stock,
          source_unit  => StockUnit,
          target_unit  => cast( 'ST' as abap.unit(3) ),
          error_handling => 'SET_TO_NULL'
      ) as UnitInPieces
}
