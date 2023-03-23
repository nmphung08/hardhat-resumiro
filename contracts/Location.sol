// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";

contract Location {
    struct AppLocation {
        string id;
        string name;
    }

    using StringArray for string[];
    mapping(string => AppLocation) internal s_locations;
    string[] internal s_locationIds;

    function addLocation(string memory _id, string memory _name) public {
        s_locationIds.push(_id);
        s_locations[_id] = AppLocation(_id, _name);
    }

    function updateLocation(string memory _id, string memory _name) public {
        s_locations[_id].name = _name;
    }

    function deleteLocation(string memory _id) public {
        s_locationIds.removeElement(_id);
        delete s_locations[_id];
    }

    function getLocation(
        string memory _id
    ) public view returns (AppLocation memory) {
        return s_locations[_id];
    }

    function getLocations(
        string[] memory _ids
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
