// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

contract Resume_Recruiter {
    using UintArray for uint[];
    mapping(uint => uint[]) internal s_resumeToRecruiter;
    mapping(uint => uint[]) internal s_recruiterToResume;

    function connectResumeRecruiter(uint _recruiter, uint _resume) public {
        s_resumeToRecruiter[_resume].push(_recruiter);
        s_recruiterToResume[_recruiter].push(_resume);
    }

    function disconnectResumeRecruiter(uint _recruiter, uint _resume) public {
        s_resumeToRecruiter[_resume].removeElement(_recruiter);
        s_recruiterToResume[_recruiter].removeElement(_resume);
    }

    function isExistedResumeRecruiter(
        uint _recruiter,
        uint _resume
    ) public view returns (bool) {
        return s_resumeToRecruiter[_resume].isElementExisted(_recruiter);
    }

    function getRecruitersThruResume(
        uint _resume
    ) public view returns (uint[] memory) {
        return s_resumeToRecruiter[_resume];
    }

    function getResumesThruRecruiter(
        uint _recruiter
    ) public view returns (uint[] memory) {
        return s_recruiterToResume[_recruiter];
    }
}
