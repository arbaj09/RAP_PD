CLASS zcl_as_rebuild_intf_data DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  CLASS-METHODS : rebuild_data .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_as_rebuild_intf_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
  zcl_as_rebuild_intf_data=>rebuild_data(  ).




  ENDMETHOD.

  METHOD rebuild_data.

  DATA lt_value TYPE SORTED TABLE OF zdas_cname WITH UNIQUE KEY name .

  lt_value = VALUE #(
 ( name = 'SAP'
        branch = 'Software'
        description = 'SAP SE is a German multinational software company based in Walldorf, Baden-Württemberg. It develops enterprise software to manage business operations and customer relations.' )
      ( name = 'Microsoft'
        branch = 'Software'
        description = 'Microsoft Corporation is an American multinational technology corporation producing computer software, consumer electronics, personal computers, and related services.' )
      ( name = 'BMW'
        branch = 'Automotive Industry'
        description = 'Bayerische Motoren Werke AG, abbreviated as BMW, is a German multinational manufacturer of luxury vehicles and motorcycles headquartered in Munich, Bavaria.' )
      ( name = 'Nestle'
        branch = 'Food'
        description = 'Nestlé S.A. is a Swiss multinational food and drink processing conglomerate corporation headquartered in Vevey, Vaud, Switzerland.' )
      ( name = 'Amazon'
        branch = 'Online Trade'
        description = 'Amazon.com, Inc. is an American multinational technology company focusing on e-commerce, cloud computing, online advertising, digital streaming, and artificial intelligence.' )
        ).

        INSERT ZDAS_CNAME from TABLE @lt_value.
         COMMIT WORK.




  ENDMETHOD.

ENDCLASS.
