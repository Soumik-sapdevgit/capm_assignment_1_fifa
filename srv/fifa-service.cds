using fifa from '../db/schema';

/** Service definition for FifaService */
/** this creates OData service and exposes the entities */
@protocol: ['odata-v4'] /**protocol is specified as odata-v4 to
                               indicate that the service will use the OData version 4 protocol for communication.
                               rest is specified to indicate that the service will also support RESTful communication. */
service FifaService @(path: '/fifa')@(impl: 'srv/handlers/fifa-handler.js')@(requires: 'authenticated-user') {

    /** Expose Team entity */
    /** provide read-only access to the Teams entity for FifaViewer role */
    @restrict: [
        {
        grant: 'READ',
        to   : ['FifaViewer', 'FifaManager', 'FifaAdmin']
    },
    {
        grant: ['CREATE', 'UPDATE', 'DELETE'],
        to   : ['FifaManager', 'FifaAdmin']
    }    
    ]
    entity Teams       as projection on fifa.Team;

    /** Expose Player entity */
    @restrict: [
        {
        grant: 'READ',
        to   : ['FifaViewer', 'FifaManager', 'FifaAdmin']
    },
    {
        grant: ['CREATE', 'UPDATE', 'DELETE'],
        to   : ['FifaManager', 'FifaAdmin']
    }    
    ]    
    entity Players     as projection on fifa.Player;

    /** Expose PlayerGoals entity */
    entity PlayerGoals as projection on fifa.PlayerGoals;

    /** Expose Match entity */
    @restrict: [
        {
        grant: 'READ',
        to   : ['FifaViewer', 'FifaManager', 'FifaAdmin']
    },
    {
        grant: ['CREATE', 'UPDATE', 'DELETE'],
        to   : ['FifaManager', 'FifaAdmin']
    }    
    ]      
    entity Matches     as projection on fifa.Match;

    /** Expose Stadium entity */
    @restrict: [
        {
        grant: 'READ',
        to   : ['FifaViewer', 'FifaAdmin']
    },
    {
        grant: ['CREATE', 'UPDATE', 'DELETE'],
        to   : ['FifaAdmin']
    }    
    ]      
    entity Stadiums    as projection on fifa.Stadium;


    // Function (Read Only)
    function getPlayerGoalCount(playerID: UUID)          returns Integer;

    // Action (Updates Data)
    action   updateCoach(teamID: UUID, newCoach: String) returns String;


}
