#include "script_component.hpp"
params ["_vehicleType", "_location"];

private _nearRoads = _location nearRoads 50;
private _vehicleMapSize = (getNumber (configFile >> "CfgVehicles" >> _vehicleType >> "mapSize")) max 5;
TRACE_4("", _vehicleType, _location, _nearRoads, _vehicleMapSize);

private _ret = [];
if (count _nearRoads > 0) then {
    private _road = _nearRoads select 0;
    private _connectedRoad = (roadsConnectedTo _road) select 0;
    private _direction = if (!isNil "_connectedRoad") then {
        _road getDir _connectedRoad;
    } else {
        (getDir _road) - 90;
    };

    private _position = _road getPos [1.5, _direction - 90];
    _position set [2, 1];
    private _list = (nearestObjects [_position, ["House", "Wall"], 15]) + (nearestTerrainObjects [_position, ["TREE", "SMALL TREE", "ROCK", "ROCKS", "FENCE", "WALL", "HIDE"], _vehicleMapSize + 1]);
    if (count _list > 0) then {
        private _item = ([_list, [_position], {_input0 distance _x}, "ASCEND"] call BIS_fnc_sortBy) select 0;
        TRACE_2("items", _list, _item);
        private _itemPos = getPos _item;
        _itemPos set [2, 1];
        if !(lineIntersects [_position, _itemPos]) then {
            _ret = [_position, _direction];
        };
    } else {
        _ret = [_position, _direction];
    };
};

TRACE_1("return", _ret);
_ret
