// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library/StringArray.sol";

contract Skill {
    struct AppSkill {
        string id;
        string name;
    }

    using StringArray for string[];
    string[] internal s_skillIds;
    mapping(string => AppSkill) internal s_skills;

    function addSkill(
        string memory _id,
        string memory _name
    ) public {
        s_skillIds.push(_id);
        s_skills[_id] = AppSkill(_id, _name);
    }

    function deleteSkill(string memory _id) public {
        s_skillIds.removeElement(_id);
        delete s_skills[_id];
    }

    function getSkill(string memory _id) public view returns (AppSkill memory) {
        return s_skills[_id];
    }

    function getSkills(
        string[] memory _ids
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
