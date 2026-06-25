namespace fifa;

/** aspect in CAPM */
using { cuid, managed } from '@sap/cds/common'; 

/**Custom aspect */
aspect CustomAspect {
    customaspectproperty : String(100);
}

/** Team Entity */
entity Team : cuid, managed, CustomAspect {
    name        : String(100);
    country     : String(100);
    coach       : String(100);
    generalFormation : String(100);
}

/** Stadium Entity */
entity Stadium : cuid, managed {
    name        : String(100);
    city        : String(100);
    capacity    : Integer;
}




