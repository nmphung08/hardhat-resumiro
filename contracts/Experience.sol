// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";

contract Experience {
    struct AppExperience {
        string id;
        string position;
        string start;
        string finish;
        string companyId;
        string userId;
    }

    using StringArray for string[];
    mapping(string => AppExperience) internal s_experiences;
    string[] internal s_experienceIds;
    mapping(string => string[]) internal s_companyToExperience;
    mapping(string => string[]) internal s_userToExperience;

    function addExperience(
        string memory _id,
        string memory _position,
        string memory _start,
        string memory _finish,
        string memory _companyId,
        string memory _userId
    ) public {
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
    }

    function updateExperience(
        string memory _id,
        string memory _position,
        string memory _start,
        string memory _finish
    ) public {
        s_experiences[_id].position = _position;
        s_experiences[_id].start = _start;
        s_experiences[_id].finish = _finish;
    }

    function deleteExperience(string memory _id) public {
        string memory companyId = s_experiences[_id].companyId;
        string memory userId = s_experiences[_id].userId;
        s_experienceIds.removeElement(_id);
        s_companyToExperience[companyId].removeElement(_id);
        s_userToExperience[userId].removeElement(_id);
        delete s_experiences[_id];
    }

    function getExperience(
        string memory _id
    ) public view returns (AppExperience memory) {
        return s_experiences[_id];
    }

    function getExperiences(
        string[] memory _ids
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
        string memory _id
    ) public view returns (AppExperience[] memory) {
        string[] memory ids = s_companyToExperience[_id];
        return getExperiences(ids);
    }

    function getExperiencesThruUser(
        string memory _id
    ) public view returns (AppExperience[] memory) {
        string[] memory ids = s_userToExperience[_id];
        return getExperiences(ids);
    }
}
