@EndUserText.label: 'Create Invoice'
define root abstract entity ZCAS_I_RAPCreateInvoice
{
  key DummyKey  : abap.char(1);
      Document  : abap.char(8);
      Partner   : abap.char(10);
     _Position : composition [0..*] of ZCAS_I_RAPCreatePosition;
}
