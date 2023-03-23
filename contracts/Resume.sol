// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";

contract Resume {
    struct AppResume {
        string id;
        string candidate;
        string data;
    }

    using StringArray for string[];
    mapping(string => AppResume) internal s_resumes;
    string[] internal s_resumeIds;
    mapping(string => string[]) internal s_candidateToResume;

    function addResume(
        string memory _id,
        string memory _candidate,
        string memory _data
    ) public virtual {
        s_resumeIds.push(_id);
        s_candidateToResume[_candidate].push(_id);
        s_resumes[_id] = AppResume(_id, _candidate, _data);
    }

    function updateResume(string memory _id, string memory _data) public {
        s_resumes[_id].data = _data;
    }

    function deleteResume(string memory _id) public {
        s_resumeIds.removeElement(_id);
        string memory candidateId = s_resumes[_id].candidate;
        s_candidateToResume[candidateId].removeElement(_id);
        delete s_resumes[_id];
    }

    function getResume(
        string memory _id
    ) public view returns (AppResume memory) {
        return s_resumes[_id];
    }

    function getResumes(
        string[] memory _ids
    ) public view returns (AppResume[] memory) {
        AppResume[] memory Resumes = new AppResume[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            Resumes[i] = s_resumes[_ids[i]];
        }
        return Resumes;
    }

    function getAllResumes() public view returns (AppResume[] memory) {
        AppResume[] memory Resumes = new AppResume[](s_resumeIds.length);
        for (uint i = 0; i < s_resumeIds.length; i++) {
            Resumes[i] = s_resumes[s_resumeIds[i]];
        }
        return Resumes;
    }

    function getResumesThruCandidate(
        string memory _id
    ) public view returns (AppResume[] memory) {
        string[] memory ids = s_candidateToResume[_id];
        return getResumes(ids);
    }
}
