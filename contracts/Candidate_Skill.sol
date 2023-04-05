// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

/**
 * @custom:many-to-many-constraint
 * Each candidate has skill(s)
 * Each skill is learned by candidate(s)
 */

contract Candidate_SKill {
    using UintArray for uint[];
    mapping(uint => uint[]) internal s_candidateToSkill;
    mapping(uint => uint[]) internal s_skillToCandidate;

    function connectCandidateSkill(uint _skill, uint _candidate) public {
        s_skillToCandidate[_skill].push(_candidate);
        s_candidateToSkill[_candidate].push(_skill);
    }

    function disconnectCandidateSkill(uint _skill, uint _candidate) public {
        s_skillToCandidate[_skill].removeElement(_candidate);
        s_candidateToSkill[_candidate].removeElement(_skill);
    }

    function isExistedCandidateSkill(
        uint _skill,
        uint _candidate
    ) public view returns (bool) {
        if (s_skillToCandidate[_skill].isElementExisted(_candidate)) {
            return true;
        }
        return false;
    }

    function getSkillsThruCandidate(
        uint _candidate
    ) public view returns (uint[] memory) {
        return s_candidateToSkill[_candidate];
    }

    function getCandidatesThruSkill(
        uint _skill
    ) public view returns (uint[] memory) {
        return s_skillToCandidate[_skill];
    }
}
