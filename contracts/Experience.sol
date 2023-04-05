// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

contract Experience {
    struct AppExperience {
        uint id;
        string position;
        string start;
        string finish;
        uint companyId;
        uint userId;
    }

    using UintArray for uint[];
    mapping(uint => AppExperience) internal s_experiences;
    uint[] internal s_experienceIds;
    mapping(uint => uint[]) internal s_companyToExperience;
    mapping(uint => uint[]) internal s_userToExperience;
    uint internal s_experienceCounter = 0;

    function addExperience(
        string memory _position,
        string memory _start,
        string memory _finish,
        uint _companyId,
        uint _userId
    ) public {
        uint _id = s_experienceCounter;
        s_experienceIds.push(_id);
        s_companyToExperience[_companyId].push(_id);
        s_userToExperience[_userId].push(_id);
        s_experiences[_id] = AppExperience(
            _id,
            _position,
            _start,
            _finish,
            _companyId,
            _userId
        );
        s_experienceCounter++;
    }

    function updateExperience(
        uint _id,
        string memory _position,
        string memory _start,
        string memory _finish,
        uint _companyId
    ) public {
        s_experiences[_id].position = _position;
        s_experiences[_id].start = _start;
        s_experiences[_id].finish = _finish;
        s_experiences[_id].companyId = _companyId;
    }

    function deleteExperience(uint _id) public {
        uint companyId = s_experiences[_id].companyId;
        uint userId = s_experiences[_id].userId;
        s_experienceIds.removeElement(_id);
        s_companyToExperience[companyId].removeElement(_id);
        s_userToExperience[userId].removeElement(_id);
        delete s_experiences[_id];
    }

    function getExperience(
        uint _id
    ) public view returns (AppExperience memory) {
        return s_experiences[_id];
    }

    function getNewestExperience() public view returns (AppExperience memory) {
        return s_experiences[s_experienceIds.length - 1];
    }

    function getExperiences(
        uint[] memory _ids
    ) public view returns (AppExperience[] memory) {
        AppExperience[] memory exps = new AppExperience[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            exps[i] = s_experiences[_ids[i]];
        }
        return exps;
    }

    function getAllExperiences() public view returns (AppExperience[] memory) {
        AppExperience[] memory exps = new AppExperience[](
            s_experienceIds.length
        );
        for (uint i = 0; i < s_experienceIds.length; i++) {
            exps[i] = s_experiences[s_experienceIds[i]];
        }
        return exps;
    }

    function getExperiencesThruCompany(
        uint _id
    ) public view returns (AppExperience[] memory) {
        uint[] memory ids = s_companyToExperience[_id];
        return getExperiences(ids);
    }

    function getExperiencesThruUser(
        uint _id
    ) public view returns (AppExperience[] memory) {
        uint[] memory ids = s_userToExperience[_id];
        return getExperiences(ids);
    }
}
