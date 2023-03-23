// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";

contract Certificate {
    struct AppCertificate {
        string id;
        string name;
        string verifiedAt;
        string userId;
    }

    using StringArray for string[];
    mapping(string => AppCertificate) internal s_certificates;
    string[] internal s_certificateIds;
    // one-to-many constraint
    mapping(string => string[]) internal s_userToCertificate;

    function addCertificate(
        string memory _id,
        string memory _name,
        string memory _verifiedAt,
        string memory _userId
    ) public {
        s_certificateIds.push(_id);
        s_certificates[_id] = AppCertificate(_id, _name, _verifiedAt, _userId);
        s_userToCertificate[_userId].push(_id);
    }

    function updateCertificate(
        string memory _id,
        string memory _name,
        string memory _verifiedAt
    ) public {
        s_certificates[_id].name = _name;
        s_certificates[_id].verifiedAt = _verifiedAt;
    }

    function deleteCertificate(string memory _id) public {
        s_certificateIds.removeElement(_id);
        string memory userId = s_certificates[_id].userId;
        s_userToCertificate[userId].removeElement(_id);
        delete s_certificates[_id];
    }

    function getCertificate(
        string memory _id
    ) public view returns (AppCertificate memory) {
        return s_certificates[_id];
    }

    function getCertificates(
        string[] memory _ids
    ) public view returns (AppCertificate[] memory) {
        AppCertificate[] memory certs = new AppCertificate[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            certs[i] = s_certificates[_ids[i]];
        }
        return certs;
    }

    function getAllCertificates()
        public
        view
        returns (AppCertificate[] memory)
    {
        AppCertificate[] memory certs = new AppCertificate[](
            s_certificateIds.length
        );
        for (uint i = 0; i < s_certificateIds.length; i++) {
            certs[i] = s_certificates[s_certificateIds[i]];
        }
        return certs;
    }

    function getCertificatesThruUser(
        string memory _id
    ) public view returns (AppCertificate[] memory) {
        string[] memory certIds = s_userToCertificate[_id];
        return getCertificates(certIds);
    }
}
