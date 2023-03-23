// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library/StringArray.sol";

contract Candidate {
    struct AppCandidate {
        string id;
        string avatar;
        string background;
        string addressWallet;
        string fullName;
        string email;
        string phone;
        string about;
    }

    using StringArray for string[];
    string[] internal s_CandidateIds;
    mapping(string => AppCandidate) internal s_candidates;

    function addCandidate(
        string memory _id,
        string memory _avatar,
        string memory _background,
        string memory _addressWallet,
        string memory _fullName,
        string memory _email,
        string memory _phone,
        string memory _about
    ) public {
        s_candidates[_id] = AppCandidate(
            _id,
            _avatar,
            _background,
            _addressWallet,
            _fullName,
            _email,
            _phone,
            _about
        );
        s_CandidateIds.push(_id);
    }

    function updateCandidate(
        string memory _id,
        string memory _avatar,
        string memory _background,
        string memory _addressWallet,
        string memory _fullName,
        string memory _email,
        string memory _phone,
        string memory _about
    ) public {
        s_candidates[_id].avatar = _avatar;
        s_candidates[_id].background = _background;
        s_candidates[_id].addressWallet = _addressWallet;
        s_candidates[_id].fullName = _fullName;
        s_candidates[_id].email = _email;
        s_candidates[_id].phone = _phone;
        s_candidates[_id].about = _about;
    }

    function deleteCandidate(string memory _id) public {
        s_CandidateIds.removeElement(_id);
        delete s_candidates[_id];
    }

    function getCandidate(
        string memory _id
    ) public view returns (AppCandidate memory) {
        return s_candidates[_id];
    }

    function getCandidates(
        string[] memory _ids
    ) public view returns (AppCandidate[] memory) {
        AppCandidate[] memory candidates = new AppCandidate[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            candidates[i] = s_candidates[_ids[i]];
        }
        return candidates;
    }

    function getAllCandidates() public view returns (AppCandidate[] memory) {
        AppCandidate[] memory candidates = new AppCandidate[](
            s_CandidateIds.length
        );
        for (uint i = 0; i < s_CandidateIds.length; i++) {
            candidates[i] = (s_candidates[s_CandidateIds[i]]);
        }
        return candidates;
    }
}
