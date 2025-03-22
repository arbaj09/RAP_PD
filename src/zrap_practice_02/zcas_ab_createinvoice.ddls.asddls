@EndUserText.label: 'Create Invoice-abstract'
define root abstract entity ZCAS_AB_CREATEINVOICE

{
    key DummyKey : abap.char(1);
      Document : abap.char(8);
      Partner  : abap.char(10);
     _Item    :  composition [0..*] of ZCAS_AB_CREATEITEM;    
    
}
