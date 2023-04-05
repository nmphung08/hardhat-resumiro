// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

contract JobType {
    struct AppJobType {
        uint id;
        string name;
    }

    using UintArray for uint[];
    mapping(uint => AppJobType) internal s_jobtypes;
    uint[] internal s_jobtypeIds;
    uint internal s_jobTypeCounter = 0;

    function addJobType(string memory _name) public {
        uint _id = s_jobTypeCounter;
        s_jobtypeIds.push(_id);
        s_jobtypes[_id] = AppJobType(_id, _name);
        s_jobTypeCounter++;
    }

    function updateJobType(uint _id, string memory _name) public {
        s_jobtypes[_id].name = _name;
    }

    function deleteJobType(uint _id) public {
        s_jobtypeIds.removeElement(_id);
        delete s_jobtypes[_id];
    }

    function getJobType(uint _id) public view returns (AppJobType memory) {
        return s_jobtypes[_id];
    }

    function getNewestJobType() public view returns (AppJobType memory) {
        return s_jobtypes[s_jobtypeIds.length - 1];
    }

    function getJobTypes(
        uint[] memory _ids
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
