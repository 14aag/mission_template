#define COMPONENT rearm
#define DEBUG_MODE_FULL 1
#define DISABLE_COMPILE_CACHE 1

#include "..\..\script_component.hpp"

#define REARM_ACTION_DISTANCE 9
#define REARM_ACTION_DISTANCE_SQR 81

#define REARM_CALIBERS        [  6,   7,   8,  13, 19, 20, 25, 30, 35, 39, 40, 60, 70, 80, 82, 100, 105, 120, 122, 125, 155, 230, 250]
#define REARM_DURATION_TAKE   [  5,   5,   5,   5,  5,  5,  5,  5,  5,  5,  5,  3,  3,  3,  3,   3,   4,   5,   5,   5,   5,  13,  10]
#define REARM_DURATION_REARM  [ 10,  10,  10,  10, 10, 10, 10, 10, 10, 10, 10,  7,  7,  7,  7,   7,   8,  10,  10,  10,  10,  27,  20]
#define REARM_COUNT           [500, 500, 400, 100, 50, 50, 40, 25, 34, 24, 10,  2,  2,  2,  2,   1,   1,   1,   1,   1,   1,   1,   1]


#define REARM_HOLSTER_WEAPON \
    _unit setVariable ["ace_rearm_selectedWeaponOnRearm", currentWeapon _unit]; \
    TRACE_2("REARM_HOLSTER_WEAPON",_unit,currentWeapon _unit); \
    _unit action ["SwitchWeapon", _unit, _unit, 299];

#define REARM_UNHOLSTER_WEAPON \
    _weaponSelect = _unit getVariable "ace_rearm_selectedWeaponOnRearm"; \
    if (!isNil "_weaponSelect") then { \
        TRACE_2("REARM_UNHOLSTER_WEAPON",_unit,_weaponSelect); \
        _unit selectWeapon _weaponSelect; \
        _unit setVariable ["ace_rearm_selectedWeaponOnRearm", nil]; \
    };

#ifdef FAST_PROGRESSBARS
    #define TIME_PROGRESSBAR(X) ((X) * 0.075)
#else
    #define TIME_PROGRESSBAR(X) (X)
#endif
