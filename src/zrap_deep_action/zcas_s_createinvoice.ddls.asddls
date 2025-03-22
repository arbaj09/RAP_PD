@EndUserText.label: 'Create Invoice'
define  root abstract entity ZCAS_S_CreateInvoice

{
  key DummyKey : abap.char(1);
      Document : abap.char(8);
      Partner  : abap.char(10);
      _Item    :  composition [0..*] of ZCAS_S_CreateItem;    
    
    

}
