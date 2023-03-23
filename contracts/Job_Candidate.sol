// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";

contract Job_Candidate {
    using StringArray for string[];
    mapping(string => string[]) internal s_jobToCandidate;
    mapping(string => string[]) internal s_candidateToJob;

    function connectJobCandidate(string memory _candidate, string memory _job) public {
        s_candidateToJob[_candidate].push(_job);
        s_jobToCandidate[_job].push(_candidate);
    }

    function disconnectJobCandidate(string memory _candidate, string memory _job) public {
        s_candidateToJob[_candidate].removeElement(_job);
        s_jobToCandidate[_job].removeElement(_candidate);
    }

    function isExistedJobCandidate(
        string memory _candidate,
        string memory _job
    ) public view returns (bool) {
        return s_candidateToJob[_candidate].isElementExisted(_job);
    }

    function getCandidatesThruJob(
        string memory _id
    ) public view returns (string[] memory) {
        return s_jobToCandidate[_id];
    }

    function getJobsThruCandidate(
        string memory _id
    ) public view returns (string[] memory) {
        return s_candidateToJob[_id];
    }
}
