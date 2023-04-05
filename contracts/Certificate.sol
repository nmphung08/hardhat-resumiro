// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

contract Certificate {
    struct AppCertificate {
        uint id;
        string name;
        string verifiedAt;
        uint userId;
    }

    using UintArray for uint[];
    mapping(uint => AppCertificate) internal s_certificates;
    uint[] internal s_certificateIds;
    // one-to-many constraint
    mapping(uint => uint[]) internal s_userToCertificate;
    uint internal s_certificateCounter = 0;

    function addCertificate(
        string memory _name,
        string memory _verifiedAt,
        uint _userId
    ) public {
        uint _id = s_certificateCounter;
        s_certificateIds.push(_id);
        s_certificates[_id] = AppCertificate(_id, _name, _verifiedAt, _userId);
        s_userToCertificate[_userId].push(_id);
        s_certificateCounter++;
    }

    function updateCertificate(
        uint _id,
        string memory _name,
        string memory _verifiedAt
    ) public {
        s_certificates[_id].name = _name;
        s_certificates[_id].verifiedAt = _verifiedAt;
    }

    function deleteCertificate(uint _id) public {
        s_certificateIds.removeElement(_id);
        uint userId = s_certificates[_id].userId;
        s_userToCertificate[userId].removeElement(_id);
        delete s_certificates[_id];
    }

    function getCertificate(
        uint _id
    ) public view returns (AppCertificate memory) {
        return s_certificates[_id];
    }

    function getNewestCertificate()
        public
        view
        returns (AppCertificate memory)
    {
        return s_certificates[s_certificateIds.length - 1];
    }

    function getCertificates(
        uint[] memory _ids
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
        uint _id
    ) public view returns (AppCertificate[] memory) {
        uint[] memory certIds = s_userToCertificate[_id];
        return getCertificates(certIds);
    }
}
