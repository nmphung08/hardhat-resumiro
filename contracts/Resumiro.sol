// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library/StringArray.sol";
import "./User.sol";

// // Candidate Relation
import "./Candidate.sol";
// import "./Experience.sol";
// import "./Certificate.sol";
import "./Candidate_Skill.sol";

// // Recruiter Relation
import "./Recruiter.sol";

// // Company Relation
import "./Company.sol";
// import "./Location.sol";
import "./Company_Recruiter.sol";

// // Resume Relation
import "./Resume.sol";
import "./Resume_Recruiter.sol";

// // Job Relation
import "./Job.sol";
// import "./JobType.sol";
import "./Job_Candidate.sol";
import "./Job_Skill.sol";

// // Skill Relation
import "./Skill.sol";

// // Field Relation
// import "./Field.sol";

// Abstract
import "./abstract-contract/AccessControl.sol";
import "./abstract-contract/Ownable.sol";

contract Resumiro is
    User,
    Candidate,
    // Experience,
    // Certificate,
    Candidate_SKill,
    Recruiter,
    Company,
    // Location,
    Company_Recruiter,
    Resume,
    Resume_Recruiter,
    Job,
    // JobType,
    Job_Candidate,
    Job_Skill,
    Skill,
    // Field,
    AccessControl,
    Ownable
{
    /**
     * @custom:resumiro
     * */
    constructor() {
        _setRole(owner(), ADMIN_ROLE);
    }

    /**
     * @custom:user-contract
     * */
    event AddUser(uint id, address indexed userAddress, UserType userType);
    event DeleteUser(uint id, address indexed userAddress, UserType userType);

    // Override addUser function
    function addUser(
        address _userAddress,
        uint _type
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        (bool existed, ) = isExisted(_userAddress);

        require(!existed, "User: Address user is existed");
        super.addUser(_userAddress, _type);

        AppUser memory newestUser = super.getUser(_userAddress);
        _setRole(_userAddress, CANDIDATE_ROLE);

        emit AddUser(newestUser.id, _userAddress, newestUser.userType);
    }

    // Override deleteUser function
    function deleteUser(
        address _userAddress
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        (bool existed, AppUser memory user) = isExisted(_userAddress);
        require(existed, "User: Address user is not existed");
        super.deleteUser(_userAddress);

        if (hasRole(_userAddress, CANDIDATE_ROLE)) {
            revokeRole(_userAddress, CANDIDATE_ROLE);
        }
        if (hasRole(_userAddress, RECRUITER_ROLE)) {
            revokeRole(_userAddress, RECRUITER_ROLE);
        }

        emit DeleteUser(user.id, _userAddress, user.userType);
    }

    /**
     * @custom:candidate-contract
     * */
    event AddCandidate(
        uint id,
        string avatar,
        string background,
        string address_wallet,
        string full_name,
        string email,
        string phone,
        string about
    );
    event DeleteCandidate(
        uint id,
        string avatar,
        string background,
        string address_wallet,
        string full_name,
        string email,
        string phone,
        string about
    );
    event UpdateCandidate(
        uint id,
        string avatar,
        string background,
        string address_wallet,
        string full_name,
        string email,
        string phone,
        string about
    );

    function addCandidate(
        uint _id,
        string memory _avatar,
        string memory _background,
        string memory _addressWallet,
        string memory _fullName,
        string memory _email,
        string memory _phone,
        string memory _about
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        super.addCandidate(
            _id,
            _avatar,
            _background,
            _addressWallet,
            _fullName,
            _email,
            _phone,
            _about
        );

        AppCandidate memory newestCandidate = super.getCandidate(_id);

        emit AddCandidate(
            newestCandidate.id,
            newestCandidate.avatar,
            newestCandidate.background,
            newestCandidate.addressWallet,
            newestCandidate.fullName,
            newestCandidate.email,
            newestCandidate.phone,
            newestCandidate.about
        );
    }

    function updateCandidate(
        uint _id,
        string memory _avatar,
        string memory _background,
        string memory _addressWallet,
        string memory _fullName,
        string memory _email,
        string memory _phone,
        string memory _about
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        super.updateCandidate(
            _id,
            _avatar,
            _background,
            _addressWallet,
            _fullName,
            _email,
            _phone,
            _about
        );

        AppCandidate memory updatedCandidate = super.getCandidate(_id);

        emit UpdateCandidate(
            updatedCandidate.id,
            updatedCandidate.avatar,
            updatedCandidate.background,
            updatedCandidate.addressWallet,
            updatedCandidate.fullName,
            updatedCandidate.email,
            updatedCandidate.phone,
            updatedCandidate.about
        );
    }

    function deleteCandidate(
        uint _id
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        AppCandidate memory deletedCandidate = super.getCandidate(_id);

        super.deleteCandidate(_id);

        emit DeleteCandidate(
            deletedCandidate.id,
            deletedCandidate.avatar,
            deletedCandidate.background,
            deletedCandidate.addressWallet,
            deletedCandidate.fullName,
            deletedCandidate.email,
            deletedCandidate.phone,
            deletedCandidate.about
        );
    }

    /**
     * @custom:recruiter-contract
     * */

    event AddRecruiter(
        uint id,
        uint owned,
        string avatar,
        string background,
        string address_wallet,
        string full_name,
        string email,
        string phone,
        string position
    );
    event DeleteRecruiter(
        uint id,
        uint owned,
        string avatar,
        string background,
        string address_wallet,
        string full_name,
        string email,
        string phone,
        string position
    );
    event UpdateRecruiter(
        uint id,
        string avatar,
        string background,
        string address_wallet,
        string full_name,
        string email,
        string phone,
        string position
    );

    function addRecruiter(
        uint _id,
        uint _owned,
        string memory _avatar,
        string memory _background,
        string memory _addressWallet,
        string memory _fullName,
        string memory _email,
        string memory _phone,
        string memory _position
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        super.addRecruiter(
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

        AppRecruiter memory newestRecruiter = getRecruiter(_id);

        emit AddRecruiter(
            newestRecruiter.id,
            newestRecruiter.owned,
            newestRecruiter.avatar,
            newestRecruiter.background,
            newestRecruiter.addressWallet,
            newestRecruiter.fullName,
            newestRecruiter.email,
            newestRecruiter.phone,
            newestRecruiter.position
        );
    }

    function updateRecruiter(
        uint _id,
        string memory _avatar,
        string memory _background,
        string memory _addressWallet,
        string memory _fullName,
        string memory _email,
        string memory _phone,
        string memory _position
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        super.updateRecruiter(
            _id,
            _avatar,
            _background,
            _addressWallet,
            _fullName,
            _email,
            _phone,
            _position
        );

        AppRecruiter memory updatedRecruiter = super.getRecruiter(_id);

        emit UpdateRecruiter(
            updatedRecruiter.id,
            updatedRecruiter.avatar,
            updatedRecruiter.background,
            updatedRecruiter.addressWallet,
            updatedRecruiter.fullName,
            updatedRecruiter.email,
            updatedRecruiter.phone,
            updatedRecruiter.position
        );
    }

    function deleteRecruiter(
        uint _id
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        AppRecruiter memory deletedRecruiter = super.getRecruiter(_id);

        super.deleteRecruiter(_id);

        emit DeleteRecruiter(
            deletedRecruiter.id,
            deletedRecruiter.owned,
            deletedRecruiter.avatar,
            deletedRecruiter.background,
            deletedRecruiter.addressWallet,
            deletedRecruiter.fullName,
            deletedRecruiter.email,
            deletedRecruiter.phone,
            deletedRecruiter.position
        );
    }

    /**
     * @custom:resume-contract
     * */
    event AddResume(
        string data,
        uint candidate_id,
        string title,
        string create_at
    );
    event UpdateResume(uint id, string data, string title, string create_at);
    event DeleteResume(
        uint id,
        string data,
        uint candidate_id,
        string title,
        string create_at
    );

    function addResume(
        string memory _data,
        uint _candidate,
        string memory _title,
        string memory _createAt
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        super.addResume(_data, _candidate, _title, _createAt);

        AppResume memory newestResume = super.getNewestResume();

        emit AddResume(
            newestResume.data,
            newestResume.candidate,
            newestResume.title,
            newestResume.createAt
        );
    }

    function updateResume(
        uint _id,
        string memory _data,
        string memory _title,
        string memory _createAt
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        super.updateResume(_id, _data, _title, _createAt);

        AppResume memory updatedResume = super.getResume(_id);

        emit UpdateResume(
            updatedResume.id,
            updatedResume.data,
            updatedResume.title,
            updatedResume.createAt
        );
    }

    function deleteResume(
        uint _id
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        AppResume memory deletedResume = super.getResume(_id);

        super.deleteResume(_id);

        emit DeleteResume(
            deletedResume.id,
            deletedResume.data,
            deletedResume.candidate,
            deletedResume.title,
            deletedResume.createAt
        );
    }

    /**
     * @custom:resume-recruiter-contract
     * */

    event ConnectResumeRecruiter(uint recruiter, uint resume);
    event DisconnectResumeRecruiter(uint recruiter, uint resume);

    function connectResumeRecruiter(
        uint _recruiter,
        uint _resume
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        super.connectResumeRecruiter(_recruiter, _resume);
        emit ConnectResumeRecruiter(_recruiter, _resume);
    }

    function disconnectResumeRecruiter(
        uint _recruiter,
        uint _resume
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        super.disconnectResumeRecruiter(_recruiter, _resume);
        emit DisconnectResumeRecruiter(_recruiter, _resume);
    }

    /**
     *  @custom:job-contract
     * */
    event AddJob(
        uint id,
        string title,
        uint location_id,
        uint job_type_id,
        uint experience,
        string requirements,
        string benefits,
        string create_at,
        string update_at,
        uint recruiter_id,
        uint company_id,
        uint salary,
        uint field_id
    );
    event UpdateJob(
        uint id,
        string title,
        uint job_type_id,
        uint experience,
        string requirements,
        string benefits,
        string create_at,
        string update_at,
        uint salary
    );
    event DeleteJob(
        uint id,
        string title,
        uint job_type_id,
        uint experience,
        string requirements,
        string benefits,
        string create_at,
        string update_at,
        uint salary
    );

    function addJob(
        AppJob memory _job
    ) public override onlyRole(msg.sender, RECRUITER_ROLE) {
        super.addJob(_job);

        AppJob memory newestJob = getNewestJob();

        emit AddJob(
            newestJob.id,
            newestJob.title,
            newestJob.locationId,
            newestJob.jobTypeId,
            newestJob.experience,
            newestJob.requirements,
            newestJob.benefits,
            newestJob.createAt,
            newestJob.updateAt,
            newestJob.recruiterId,
            newestJob.companyId,
            newestJob.salary,
            newestJob.fieldId
        );
    }

    function updateJob(
        uint _id,
        string memory _title,
        uint _jobTypeId,
        uint _experience,
        string memory _requirements,
        string memory _benefits,
        string memory _createAt,
        string memory _updateAt,
        uint _salary
    ) public override onlyRole(msg.sender, RECRUITER_ROLE) {
        super.updateJob(
            _id,
            _title,
            _jobTypeId,
            _experience,
            _requirements,
            _benefits,
            _createAt,
            _updateAt,
            _salary
        );

        AppJob memory updatedJob = super.getJob(_id);

        emit UpdateJob(
            updatedJob.id,
            updatedJob.title,
            updatedJob.jobTypeId,
            updatedJob.experience,
            updatedJob.requirements,
            updatedJob.benefits,
            updatedJob.createAt,
            updatedJob.updateAt,
            updatedJob.salary
        );
    }

    function deleteJob(
        uint _id
    ) public override onlyRole(msg.sender, RECRUITER_ROLE) {
        AppJob memory deletedJob = super.getJob(_id);

        super.deleteJob(_id);

        emit DeleteJob(
            deletedJob.id,
            deletedJob.title,
            deletedJob.jobTypeId,
            deletedJob.experience,
            deletedJob.requirements,
            deletedJob.benefits,
            deletedJob.createAt,
            deletedJob.updateAt,
            deletedJob.salary
        );
    }

    /**
     * @custom:job-candidate-contract
     * */
    event ConnectJobCandidate(uint candidate_id, uint job_id);
    event DisconnectJobCandidate(uint candidate_id, uint job_id);

    function connectJobCandidate(
        uint _candidate,
        uint _job
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        super.connectJobCandidate(_candidate, _job);

        emit ConnectJobCandidate(_candidate, _job);
    }

    function disconnectJobCandidate(
        uint _candidate,
        uint _job
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        super.disconnectJobCandidate(_candidate, _job);

        emit DisconnectJobCandidate(_candidate, _job);
    }

    /**
     * @custom:job-skill-contract
     * */
    event ConnectJobSkill(uint skill_id, uint job_id);
    event DisconnectJobSkill(uint skill_id, uint job_id);

    function connectJobSkill(
        uint _skill,
        uint _job
    ) public override onlyRole(msg.sender, RECRUITER_ROLE) {
        super.connectJobSkill(_skill, _job);

        emit ConnectJobCandidate(_skill, _job);
    }

    function disconnectJobSkill(
        uint _skill,
        uint _job
    ) public override onlyRole(msg.sender, RECRUITER_ROLE) {
        super.disconnectJobSkill(_skill, _job);

        emit DisconnectJobSkill(_skill, _job);
    }

    /**
     * @custom:candidate-skill-contract
     * */
    event ConnectCandidateSkill(uint skill_id, uint candidate_id);
    event DisconnectCandidateSkill(uint skill_id, uint candidate_id);

    function connectCandidateSkill(
        uint _skill,
        uint _candidate
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        super.connectJobSkill(_skill, _candidate);

        emit ConnectCandidateSkill(_skill, _candidate);
    }

    function disconnectCandidateSkill(
        uint _skill,
        uint _candidate
    ) public override onlyRole(msg.sender, CANDIDATE_ROLE) {
        super.disconnectCandidateSkill(_skill, _candidate);

        emit DisconnectCandidateSkill(_skill, _candidate);
    }

    /**
     * @custom:company-contract
     * */
    event AddCompany(
        uint id,
        uint owner_id,
        string name,
        string logo,
        string background,
        string about,
        string scale,
        string website,
        uint location_id,
        string addr,
        string introduction
    );
    event DeleteCompany(
        uint id,
        uint owner_id,
        string name,
        string logo,
        string background,
        string about,
        string scale,
        string website,
        uint location_id,
        string addr,
        string introduction
    );
    event UpdateCompany(
        uint id,
        uint owner_id,
        string name,
        string logo,
        string background,
        string about,
        string scale,
        string website,
        uint location_id,
        string addr,
        string introduction
    );

    function addCompany(
        uint _ownerId,
        string memory _name,
        string memory _logo,
        string memory _background,
        string memory _about,
        string memory _scale,
        string memory _website,
        uint _locationId,
        string memory _addr,
        string memory _introduction
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        super.addCompany(
            _ownerId,
            _name,
            _logo,
            _background,
            _about,
            _scale,
            _website,
            _locationId,
            _addr,
            _introduction
        );

        AppCompany memory newestCompany = super.getNewestCompany();

        emit AddCompany(
            newestCompany.id,
            newestCompany.ownerId,
            newestCompany.name,
            newestCompany.logo,
            newestCompany.background,
            newestCompany.about,
            newestCompany.scale,
            newestCompany.website,
            newestCompany.locationId,
            newestCompany.addr,
            newestCompany.introduction
        );
    }

    function updateCompany(
        uint _id,
        string memory _name,
        string memory _logo,
        string memory _background,
        string memory _about,
        string memory _scale,
        string memory _website,
        uint _locationId,
        string memory _addr,
        string memory _introduction
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        super.updateCompany(
            _id,
            _name,
            _logo,
            _background,
            _about,
            _scale,
            _website,
            _locationId,
            _addr,
            _introduction
        );

        AppCompany memory updatedCompany = super.getCompany(_id);

        emit UpdateCompany(
            updatedCompany.id,
            updatedCompany.ownerId,
            updatedCompany.name,
            updatedCompany.logo,
            updatedCompany.background,
            updatedCompany.about,
            updatedCompany.scale,
            updatedCompany.website,
            updatedCompany.locationId,
            updatedCompany.addr,
            updatedCompany.introduction
        );
    }

    function deleteCompany(
        uint _id
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        AppCompany memory deletedCompany = super.getCompany(_id);

        super.deleteCompany(_id);

        emit DeleteCompany(
            deletedCompany.id,
            deletedCompany.ownerId,
            deletedCompany.name,
            deletedCompany.logo,
            deletedCompany.background,
            deletedCompany.about,
            deletedCompany.scale,
            deletedCompany.website,
            deletedCompany.locationId,
            deletedCompany.addr,
            deletedCompany.introduction
        );
    }

    /**
     * @custom:company-recruiter-contract
     * */
    event ConnectCompanyRecruiter(uint recruiter_id, uint company_id);
    event DisconnectCompanyRecruiter(uint recruiter_id, uint company_id);

    function connectCompanyRecruiter(
        uint _recruiterId,
        uint _companyId
    ) public override onlyRole(msg.sender, RECRUITER_ROLE) {
        super.connectCompanyRecruiter(_recruiterId, _companyId);

        emit ConnectCompanyRecruiter(_recruiterId, _companyId);
    }

    function disconnectCompanyRecruiter(
        uint _recruiterId,
        uint _companyId
    ) public override onlyRole(msg.sender, RECRUITER_ROLE) {
        super.disconnectCompanyRecruiter(_recruiterId, _companyId);

        emit DisconnectCompanyRecruiter(_recruiterId, _companyId);
    }
}
