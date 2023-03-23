// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library/StringArray.sol";

contract Recruiter {
    struct AppRecruiter {
        string id;
        string owned;
        string avatar;
        string background;
        string addressWallet;
        string fullName;
        string email;
        string phone;
        string position;
    }

    using StringArray for string[];
    string[] internal s_recruiterIds;
    mapping(string => AppRecruiter) internal s_recruiters;

    function addRecruiter(
        string memory _id,
        string memory _owned,
        string memory _avatar,
        string memory _background,
        string memory _addressWallet,
        string memory _fullName,
        string memory _email,
        string memory _phone,
        string memory _position
    ) public {
        s_recruiterIds.push(_id);
        s_recruiters[_id] = AppRecruiter(
            _id,
            _owned,
            _avatar,
            _background,
            _addressWallet,
            _fullName,
            _email,
            _phone,
            _position
        );
    }

    function updateRecruiter(
        string memory _id,
        string memory _owned,
        string memory _avatar,
        string memory _background,
        string memory _addressWallet,
        string memory _fullName,
        string memory _email,
        string memory _phone,
        string memory _position
    ) public {
        s_recruiters[_id].owned = _owned;
        s_recruiters[_id].avatar = _avatar;
        s_recruiters[_id].background = _background;
        s_recruiters[_id].addressWallet = _addressWallet;
        s_recruiters[_id].fullName = _fullName;
        s_recruiters[_id].email = _email;
        s_recruiters[_id].phone = _phone;
        s_recruiters[_id].position = _position;
    }

    function deleteRecruiter(string memory _id) public {
        s_recruiterIds.removeElement(_id);
        delete s_recruiters[_id];
    }

    function getRecruiter(
        string memory _id
    ) public view returns (AppRecruiter memory) {
        return s_recruiters[_id];
    }

    function getRecruiters(
        string[] memory _ids
    ) public view returns (AppRecruiter[] memory) {
        AppRecruiter[] memory recruiters = new AppRecruiter[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            recruiters[i] = s_recruiters[_ids[i]];
        }
        return recruiters;
    }

    function getAllRecruiters() public view returns (AppRecruiter[] memory) {
        AppRecruiter[] memory recruiters = new AppRecruiter[](
            s_recruiterIds.length
        );
        for (uint i = 0; i < s_recruiterIds.length; i++) {
            recruiters[i] = s_recruiters[s_recruiterIds[i]];
        }
        return recruiters;
    }
}
