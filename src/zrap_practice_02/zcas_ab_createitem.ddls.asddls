@EndUserText.label: 'create Item-abstract'
define abstract entity ZCAS_AB_CREATEITEM

{
    key DummyKey : abap.char(1);
      Material : abap.char(5);
      @Semantics.quantity.unitOfMeasure : 'Unit'
      Quantity : abap.quan(10,0);
      Unit     : abap.unit(3);
      @Semantics.amount.currencyCode : 'Currency'
      Price    : abap.curr(15,2);
      Currency : abap.cuky;
      _DummAssociation : association to parent ZCAS_AB_CREATEINVOICE on $projection.DummyKey = _DummAssociation.DummyKey;


    
}
