@EndUserText.label: 'Create Position'
define abstract entity ZCAS_A_CREATEPOSITION
{
  key DummyKey          : abap.char(1);
      Material          : abap.char(5);
      @Semantics.quantity.unitOfMeasure : 'Unit'
      Quantity          : abap.quan(10,0);
      Unit              : abap.unit(3);
      @Semantics.amount.currencyCode : 'Currency'
      Price             : abap.curr(15,2);
      Currency          : abap.cuky;
      _DummyAssociation : association to parent ZCAS_A_CREATEINVOICE on $projection.DummyKey = _DummyAssociation.DummyKey;
}
