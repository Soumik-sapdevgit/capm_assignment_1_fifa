const cds = require('@sap/cds');

module.exports = async function () {

    const { Teams, PlayerGoals } = this.entities; //this.entities contains all entities exposed by your service.
    /**this is equivalent to 
     * const Teams = this.entities.Teams;
        const PlayerGoals = this.entities.PlayerGoals; */

    /**
     * Function
     * GET /odata/v4/fifa/getPlayerGoalCount(playerID='P001') -> when someone calls the function from the client, 
     * this is the code that will be executed
     */
    this.on('getPlayerGoalCount', async (req) => {

        const { playerID } = req.data;//req.data contains { playerID: 'P001' }, so playerID will be 'P001' in this case
        /**below code is equilavent to
         * 
        SELECT *
        FROM PlayerGoals
        WHERE player_ID = 'P001';
         */
        const records = await SELECT
            .from(PlayerGoals)
            .where({
                player_ID: playerID
            });

        let totalGoals = 0;

        for (const record of records) {
            totalGoals += record.goalsScored;
        }

        return totalGoals;
    });

    /**
     * Action
     * POST /odata/v4/fifa/updateCoach
     */
    this.on('updateCoach', async (req) => {

        const { teamID, newCoach } = req.data;

        /**below code is equivalent to
         * 
        UPDATE Teams
        SET coach = 'Pep Guardiola'
        WHERE ID = 'T001';
        */

        await UPDATE(Teams)
            .set({
                coach: newCoach
            })
            .where({
                ID: teamID
            });

        return `Coach updated successfully to ${newCoach}`;
    });

};