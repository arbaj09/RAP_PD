
@AccessControl.authorizationCheck: #NOT_REQUIRED


define hierarchy ZCAS_TEAM_HR
  as parent child hierarchy (
    source ZCAS_I_TEAM
    child to parent association _Leader
    start where TeamLeader is initial
    siblings order by  UserIdentification
  )
{
    key UserIdentification,
    TeamLeader
    
}
