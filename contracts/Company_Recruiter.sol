// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";


contract Company_Recruiter {
    using StringArray for string[];
    mapping(string => string[]) internal s_companyToRecruiter;
    mapping(string => string[]) internal s_recruiterToCompany;

    function connectCompanyRecruiter(
        string memory _recruiterId,
        string memory _companyId
    ) public {
        s_recruiterToCompany[_recruiterId].push(_companyId);
        s_companyToRecruiter[_companyId].push(_recruiterId);
    }


    function disconnectCompanyRecruiter(
        string memory _recruiterId,
        string memory _companyId
    ) public {
        s_recruiterToCompany[_recruiterId].removeElement(_companyId);
        s_companyToRecruiter[_companyId].removeElement(_recruiterId);
    }

    function isExistedCompanyRecruiter(
        string memory _recruiterId,
        string memory _companyId
    ) public view returns (bool) {
        return s_recruiterToCompany[_recruiterId].isElementExisted(_companyId);
    }

    function getRecruitersThruCompany(
        string memory _id
    ) public view returns (string[] memory) {
        return s_companyToRecruiter[_id];
    }

    function getCompaniesThruRecruiter(
        string memory _id
    ) public view returns (string[] memory) {
        return s_recruiterToCompany[_id];
    }
}

