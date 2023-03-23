// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";

contract JobType {
    struct AppJobType {
        string id;
        string name;
    }

    using StringArray for string[];
    mapping(string => AppJobType) internal s_jobtypes;
    string[] internal s_jobtypeIds;

    function addJobType(string memory _id, string memory _name) public {
        s_jobtypeIds.push(_id);
        s_jobtypes[_id] = AppJobType(_id, _name);
    }

    function updateJobType(string memory _id, string memory _name) public {
        s_jobtypes[_id].name = _name;
    }

    function deleteJobType(string memory _id) public {
        s_jobtypeIds.removeElement(_id);
        delete s_jobtypes[_id];
    }

    function getJobType(
        string memory _id
    ) public view returns (AppJobType memory) {
        return s_jobtypes[_id];
    }

    function getJobTypes(
        string[] memory _ids
    ) public view returns (AppJobType[] memory) {
        AppJobType[] memory jobtypes = new AppJobType[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            jobtypes[i] = s_jobtypes[_ids[i]];
        }
        return jobtypes;
    }

    function getAllJobTypes() public view returns (AppJobType[] memory) {
        AppJobType[] memory jobtypes = new AppJobType[](s_jobtypeIds.length);
        for (uint i = 0; i < s_jobtypeIds.length; i++) {
            jobtypes[i] = s_jobtypes[s_jobtypeIds[i]];
        }
        return jobtypes;
    }
}
