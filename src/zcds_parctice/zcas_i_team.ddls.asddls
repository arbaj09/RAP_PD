@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface for team'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCAS_I_TEAM as select from zdas_team
association of many to one ZCAS_I_TEAM as _Leader on _Leader.UserIdentification = $projection.TeamLeader
{
    key user_id as UserIdentification,
    name as   PlayerFullName,
    email as EMailAddress,
    team_pos as PlayerPosition,
    score as ELOScore,
    team as TeamName,
    leader as TeamLeader,
    _Leader
    
}
