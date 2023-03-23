// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";

contract Job_Skill {
    using StringArray for string[];
    mapping(string => string[]) s_jobToSkill;
    mapping(string => string[]) s_skillToJob;

    function connectJobSkill(string memory _skill, string memory _job) public {
        s_jobToSkill[_job].push(_skill);
        s_skillToJob[_skill].push(_job);
    }

    function disconnectJobSkill(string memory _skill, string memory _job) public {
        s_jobToSkill[_job].removeElement(_skill);
        s_skillToJob[_skill].removeElement(_job);
    }

    function isExistedJobSkill(
        string memory _skill,
        string memory _job
    ) public view returns (bool) {
        return s_jobToSkill[_job].isElementExisted(_skill);
    }

    function getSkillsThruJob(
        string memory _id
    ) public view returns (string[] memory) {
        return s_jobToSkill[_id];
    }

    function getJobsThruSkill(
        string memory _id
    ) public view returns (string[] memory) {
        return s_skillToJob[_id];
    }
}
