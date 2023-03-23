// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";

/**
 * @custom:many-to-many-constraint
 * Each candidate has skill(s)
 * Each skill is learned by candidate(s)
 */

contract Candidate_SKill {
    using StringArray for string[];
    mapping(string => string[]) internal s_candidateToSkill;
    mapping(string => string[]) internal s_skillToCandidate;

    function connectCandidateSkill(string memory _skill, string memory _candidate) public {
        s_skillToCandidate[_skill].push(_candidate);
        s_candidateToSkill[_candidate].push(_skill);
    }

    function disconnectCandidateSkill(string memory _skill, string memory _candidate) public {
        s_skillToCandidate[_skill].removeElement(_candidate);
        s_candidateToSkill[_candidate].removeElement(_skill);
    }

    function isExistedCandidateSkill(
        string memory _skill,
        string memory _candidate
    ) public view returns (bool) {
        if (s_skillToCandidate[_skill].isElementExisted(_candidate)) {
            return true;
        }
        return false;
    }

    function getSkillsThruCandidate(
        string memory _candidate
    ) public view returns (string[] memory) {
        return s_candidateToSkill[_candidate];
    }

    function getCandidatesThruSkill(
        string memory _skill
    ) public view returns (string[] memory) {
        return s_skillToCandidate[_skill];
    }
}
