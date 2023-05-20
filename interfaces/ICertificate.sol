// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface ICertificate {
    struct AppCertificate {
        uint id;
        uint index;
        string name;
        uint verifiedAt;
        address owner;
        bool exist;
    }

    function isOwnerOfCertificate(
        address _candidateAddress,
        uint _id
    ) external view returns (bool);

    function getCertificate(
        uint _id
    ) external view returns (AppCertificate memory);

    function addCertificate(
        string memory _name,
        uint _verifiedAt,
        address _candidateAddress
    ) external;

    function updateCertificate(
        uint _id,
        string memory _name,
        uint _verifiedAt
    ) external;

    function deleteCertificate(uint _id) external;
}
