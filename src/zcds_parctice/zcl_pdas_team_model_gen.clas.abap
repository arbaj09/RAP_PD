CLASS zcl_pdas_team_model_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pdas_team_model_gen IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA
        lt_team TYPE STANDARD TABLE OF ZDAS_TEAM  WITH EMPTY KEY.

    lt_team =
        VALUE #( ( user_id  = 'P0020'
                   name     = 'Lester P. Riley'
                   email    = 'LesterPRiley@einrot.com'
                   team_pos = 'Manager'
                   score    = '0.00'
                   team     = 'Proud SNC'
                   leader   = '' )
                 ( user_id  = 'P0021'
                   name     = 'Brayden Zichy-Woinarski'
                   email    = 'BraydenZichy-Woinarski@einrot.com'
                   team_pos = 'Coach'
                   score    = '1465'
                   team     = 'Proud SNC'
                   leader   = 'P0020' )
                 ( user_id  = 'P0022'
                   name     = 'Yong Wang'
                   email    = 'YongWang@cuvox.de'
                   team_pos = 'Mid-Lane'
                   score    = '2100'
                   team     = 'Proud SNC'
                   leader   = 'P0020' )
                 ( user_id  = 'P0023'
                   name     = 'Garland Robert'
                   email    = 'GarlandRobert@cuvox.de'
                   team_pos = 'Bot-Lane'
                   score    = '2200'
                   team     = 'Proud SNC'
                   leader   = 'P0020' )
                 ( user_id  = 'P0024'
                   name     = 'Søren C. Nilsson'
                   email    = 'SorenCNilsson@einrot.com'
                   team_pos = 'Jungle'
                   score    = '1925'
                   team     = 'Proud SNC'
                   leader   = 'P0020' )
                 ( user_id  = 'P0025'
                   name     = 'Emily Correia Oliveira'
                   email    = 'EmilyCorreiaOliveira@cuvox.de'
                   team_pos = 'Manager'
                   score    = '0.00'
                   team     = 'Wasteland'
                   leader   = '' )
                 ( user_id  = 'P0026'
                   name     = 'Erin Chandler'
                   email    = 'ErinChandler@einrot.com'
                   team_pos = 'Coach'
                   score    = '2000'
                   team     = 'Wasteland'
                   leader   = 'P0025' )
                 ( user_id  = 'P0027'
                   name     = 'Panu Sibelius'
                   email    = 'PanuSibelius@cuvox.de'
                   team_pos = 'Jungle'
                   score    = '2122'
                   team     = 'Wasteland'
                   leader   = 'P0025' )
                 ( user_id  = 'P0028'
                   name     = 'Katharina Fuerst'
                   email    = 'KatharinaFuerst@einrot.com'
                   team_pos = 'Bot-Lane'
                   score    = '1980'
                   team     = 'Wasteland'
                   leader   = 'P0025' ) ).
    DELETE FROM ZDAS_TEAM.
    INSERT ZDAS_TEAM FROM TABLE @lt_team.
    COMMIT WORK.
  ENDMETHOD.
ENDCLASS.
