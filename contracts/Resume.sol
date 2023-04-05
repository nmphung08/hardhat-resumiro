// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

contract Resume {
    struct AppResume {
        uint id;
        string data;
        uint candidate;
        string title;
        string createAt;
    }

    using UintArray for uint[];
    mapping(uint => AppResume) internal s_resumes;
    uint[] internal s_resumeIds;
    mapping(uint => uint[]) internal s_candidateToResume;
    uint internal s_resumeCounter = 0;

    function addResume(
        string memory _data,
        uint _candidate,
        string memory _title,
        string memory _createAt
    ) public virtual {
        uint _id = s_resumeCounter;
        s_resumeIds.push(_id);
        s_candidateToResume[_candidate].push(_id);
        s_resumes[_id] = AppResume(_id, _data, _candidate, _title, _createAt);
        s_resumeCounter++;
    }

    function updateResume(
        uint _id,
        string memory _data,
        string memory _title,
        string memory _createAt
    ) public {
        s_resumes[_id].data = _data;
        s_resumes[_id].title = _title;
        s_resumes[_id].createAt = _createAt;
    }

    function deleteResume(uint _id) public {
        s_resumeIds.removeElement(_id);
        uint candidateId = s_resumes[_id].candidate;
        s_candidateToResume[candidateId].removeElement(_id);
        delete s_resumes[_id];
    }

    function getResume(uint _id) public view returns (AppResume memory) {
        return s_resumes[_id];
    }

    function getReNewestsume() public view returns (AppResume memory) {
        return s_resumes[s_resumeIds.length - 1];
    }

    function getResumes(
        uint[] memory _ids
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
        uint _id
    ) public view returns (AppResume[] memory) {
        uint[] memory ids = s_candidateToResume[_id];
        return getResumes(ids);
    }
}
