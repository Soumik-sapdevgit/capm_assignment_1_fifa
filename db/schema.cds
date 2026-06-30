namespace fifa;

/** aspect in CAPM */
using {
    cuid,
    managed
} from '@sap/cds/common';

/**Custom aspect */
aspect CustomAspect {
    customaspectproperty : String(100);
}

/** Team Entity */
entity Team : cuid, managed, CustomAspect {
    name             : String(100);
    country          : String(100);
    coach            : String(100);
    generalFormation : String(100);
    players          : Composition of many Player
                           on players.team = $self; /*players is a navigation property of Team entity and
                                                    it is a composition of many Player entities.
                                                    The association is defined using the "on" clause,
                                                    which specifies that the players are related
                                                    to the team through the "team" association in the Player entity.
                                                    The "$self" keyword refers to the current instance of the Team entity.
                                                    join condition players.team = $self is equivalent to Player.team = Team.ID*/

}

/** Player Entity */
entity Player : cuid, managed {

    playerName   : String(100);
    age          : Integer;
    jerseyNumber : Integer;
    position     : String(50);
    team         : Association to Team; /*team is a navigation property of Player entity and
                                            it is an association to the Team entity.
                                        This means that each Player is associated with a specific Team.*/
    goals        : Composition of many PlayerGoals
                       on goals.player = $self;
}

/** Player Goals Entity */
entity PlayerGoals : cuid, managed {

    player      : Association to Player;
    match       : Association to Match;
    goalsScored : Integer;
}

/** Match Entity */
entity Match : cuid, managed {

    matchDate  : Date;
    matchTime  : Time;
    Team1      : Association to Team;
    Team2      : Association to Team;
    stadium    : Association to Stadium;
    Team1Score : Integer;
    Team2Score : Integer;
}

/** Stadium Entity */
entity Stadium : cuid, managed {
    name     : String(100);
    city     : String(100);
    capacity : Integer;
}
