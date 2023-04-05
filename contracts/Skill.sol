// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library/UintArray.sol";

contract Skill {
    struct AppSkill {
        uint id;
        string name;
    }

    using UintArray for uint[];
    uint[] internal s_skillIds;
    mapping(uint => AppSkill) internal s_skills;
    uint internal s_skillCounter = 0;

    function addSkill(string memory _name) public {
        uint _id = s_skillCounter;
        s_skillIds.push(_id);
        s_skills[_id] = AppSkill(_id, _name);
        s_skillCounter++;
    }

    function deleteSkill(uint _id) public {
        s_skillIds.removeElement(_id);
        delete s_skills[_id];
    }

    function getSkill(uint _id) public view returns (AppSkill memory) {
        return s_skills[_id];
    }

    function getSkills(
        uint[] memory _ids
    ) public view returns (AppSkill[] memory) {
        AppSkill[] memory skills = new AppSkill[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            skills[i] = s_skills[_ids[i]];
        }
        return skills;
    }

    function getAllSkills() public view returns (AppSkill[] memory) {
        AppSkill[] memory skills = new AppSkill[](s_skillIds.length);
        for (uint i = 0; i < s_skillIds.length; i++) {
            skills[i] = s_skills[s_skillIds[i]];
        }
        return skills;
    }
}
