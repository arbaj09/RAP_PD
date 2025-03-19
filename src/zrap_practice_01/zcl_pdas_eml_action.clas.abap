CLASS zcl_pdas_eml_action DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pdas_eml_action IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
   MODIFY ENTITIES OF zcas_i_partner
       ENTITY zcas_i_partner EXECUTE fillEmptyStreets
      FROM VALUE #( ( PartnerNumber = '1000000007' ) )

      MAPPED DATA(ls_mapped)
      FAILED DATA(ls_failed)
      REPORTED DATA(ls_reported).

    COMMIT ENTITIES.






  ENDMETHOD.

ENDCLASS.
