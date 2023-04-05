// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

contract Job_Candidate {
    using UintArray for uint[];
    mapping(uint => uint[]) internal s_jobToCandidate;
    mapping(uint => uint[]) internal s_candidateToJob;

    function connectJobCandidate(uint _candidate, uint _job) public {
        s_candidateToJob[_candidate].push(_job);
        s_jobToCandidate[_job].push(_candidate);
    }

    function disconnectJobCandidate(uint _candidate, uint _job) public {
        s_candidateToJob[_candidate].removeElement(_job);
        s_jobToCandidate[_job].removeElement(_candidate);
    }

    function isExistedJobCandidate(
        uint _candidate,
        uint _job
    ) public view returns (bool) {
        return s_candidateToJob[_candidate].isElementExisted(_job);
    }

    function getCandidatesThruJob(
        uint _id
    ) public view returns (uint[] memory) {
        return s_jobToCandidate[_id];
    }

    function getJobsThruCandidate(
        uint _id
    ) public view returns (uint[] memory) {
        return s_candidateToJob[_id];
    }
}
