// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";

contract Resume_Recruiter {
    using StringArray for string[];
    mapping(string => string[]) internal s_resumeToRecruiter;
    mapping(string => string[]) internal s_recruiterToResume;

    function connectResumeRecruiter(string memory _recruiter, string memory _resume) public {
        s_resumeToRecruiter[_resume].push(_recruiter);
        s_recruiterToResume[_recruiter].push(_resume);
    }

    function disconnectResumeRecruiter(
        string memory _recruiter,
        string memory _resume
    ) public {
        s_resumeToRecruiter[_resume].removeElement(_recruiter);
        s_recruiterToResume[_recruiter].removeElement(_resume);
    }

    function isExistedResumeRecruiter(
        string memory _recruiter,
        string memory _resume
    ) public view returns (bool) {
        return s_resumeToRecruiter[_resume].isElementExisted(_recruiter);
    }

    function getRecruitersThruResume(
        string memory _resume
    ) public view returns (string[] memory) {
        return s_resumeToRecruiter[_resume];
    }

    function getResumesThruRecruiter(
        string memory _recruiter
    ) public view returns (string[] memory) {
        return s_recruiterToResume[_recruiter];
    }
}
