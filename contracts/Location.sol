// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

contract Location {
    struct AppLocation {
        uint id;
        string name;
    }

    using UintArray for uint[];
    mapping(uint => AppLocation) internal s_locations;
    uint[] internal s_locationIds;
    uint internal s_locationCounter = 0;

    function addLocation(string memory _name) public {
        uint _id = s_locationCounter;
        s_locationIds.push(_id);
        s_locations[_id] = AppLocation(_id, _name);
        s_locationCounter++;
    }

    function updateLocation(uint _id, string memory _name) public {
        s_locations[_id].name = _name;
    }

    function deleteLocation(uint _id) public {
        s_locationIds.removeElement(_id);
        delete s_locations[_id];
    }

    function getLocation(uint _id) public view returns (AppLocation memory) {
        return s_locations[_id];
    }

    function getNewestLocation() public view returns (AppLocation memory) {
        return s_locations[s_locationIds.length - 1];
    }

    function getLocations(
        uint[] memory _ids
    ) public view returns (AppLocation[] memory) {
        AppLocation[] memory locations = new AppLocation[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            locations[i] = s_locations[_ids[i]];
        }
        return locations;
    }

    function getAllLocation() public view returns (AppLocation[] memory) {
        AppLocation[] memory locations = new AppLocation[](
            s_locationIds.length
        );
        for (uint i = 0; i < s_locationIds.length; i++) {
            locations[i] = s_locations[s_locationIds[i]];
        }
        return locations;
    }
}
