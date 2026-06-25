using fifa from '../db/schema';

/** Service definition for FifaService */
/** this creates OData service and exposes the entities */
service FifaService {

    /** Expose Team entity */
    entity Teams as projection on fifa.Team;

    /** Expose Stadium entity */
    entity Stadiums as projection on fifa.Stadium;

}
