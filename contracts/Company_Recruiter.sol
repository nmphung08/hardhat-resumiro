// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

contract Company_Recruiter {
    using UintArray for uint[];
    mapping(uint => uint[]) internal s_companyToRecruiter;
    mapping(uint => uint[]) internal s_recruiterToCompany;

    function connectCompanyRecruiter(
        uint _recruiterId,
        uint _companyId
    ) public {
        s_recruiterToCompany[_recruiterId].push(_companyId);
        s_companyToRecruiter[_companyId].push(_recruiterId);
    }

    function disconnectCompanyRecruiter(
        uint _recruiterId,
        uint _companyId
    ) public {
        s_recruiterToCompany[_recruiterId].removeElement(_companyId);
        s_companyToRecruiter[_companyId].removeElement(_recruiterId);
    }

    function isExistedCompanyRecruiter(
        uint _recruiterId,
        uint _companyId
    ) public view returns (bool) {
        return s_recruiterToCompany[_recruiterId].isElementExisted(_companyId);
    }

    function getRecruitersThruCompany(
        uint _id
    ) public view returns (uint[] memory) {
        return s_companyToRecruiter[_id];
    }

    function getCompaniesThruRecruiter(
        uint _id
    ) public view returns (uint[] memory) {
        return s_recruiterToCompany[_id];
    }
}
