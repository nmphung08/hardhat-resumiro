// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

contract Job_Skill {
    using UintArray for uint[];
    mapping(uint => uint[]) s_jobToSkill;
    mapping(uint => uint[]) s_skillToJob;

    function connectJobSkill(uint _skill, uint _job) public {
        s_jobToSkill[_job].push(_skill);
        s_skillToJob[_skill].push(_job);
    }

    function disconnectJobSkill(uint _skill, uint _job) public {
        s_jobToSkill[_job].removeElement(_skill);
        s_skillToJob[_skill].removeElement(_job);
    }

    function isExistedJobSkill(
        uint _skill,
        uint _job
    ) public view returns (bool) {
        return s_jobToSkill[_job].isElementExisted(_skill);
    }

    function getSkillsThruJob(uint _id) public view returns (uint[] memory) {
        return s_jobToSkill[_id];
    }

    function getJobsThruSkill(uint _id) public view returns (uint[] memory) {
        return s_skillToJob[_id];
    }
}
