// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./abstract-contract/Ownable.sol";
import "../interfaces/IUser.sol";
import "../interfaces/ICompany.sol";
import "../interfaces/ICertificate.sol";
import "../interfaces/IExperience.sol";
import "../interfaces/IJob.sol";
import "../interfaces/IResume.sol";
import "../interfaces/ISkill.sol";

contract Resumiro {
    /**
     * @custom:resumiro
     * */
    IUser user;
    ICompany company;
    ICertificate certificate;
    IExperience experience;
    IJob job;
    IResume resume;
    ISkill skill;
    address owner;

    constructor(
        address _userAddress,
        address _companyAddress,
        address _certAddress,
        address _expAddress,
        address _jobAddress,
        address _resumeAddress,
        address _skillAddress
    ) {
        user = IUser(_userAddress);
        company = ICompany(_companyAddress);
        certificate = ICertificate(_certAddress);
        experience = IExperience(_expAddress);
        job = IJob(_jobAddress);
        resume = IResume(_resumeAddress);
        skill = ISkill(_skillAddress);
        owner = tx.origin;
    }

    modifier onlyAdmin() {
        if (tx.origin != owner) {
            revert("ONLY FOR ADMIN!");
        }
        _;
    }

    function setUserContract(address _userAddress) external onlyAdmin {
        user = IUser(_userAddress);
    }

    function setCompanyContract(address _companyAddress) external onlyAdmin {
        company = ICompany(_companyAddress);
    }

    function setCertificateContract(address _certAddress) external onlyAdmin {
        certificate = ICertificate(_certAddress);
    }

    function setExperienceContract(address _expAddress) external onlyAdmin {
        experience = IExperience(_expAddress);
    }

    function setJobContract(address _jobAddress) external onlyAdmin {
        job = IJob(_jobAddress);
    }

    function setResumeContract(address _resumeAddress) external onlyAdmin {
        resume = IResume(_resumeAddress);
    }

    function setSkillContract(address _skillAddress) external onlyAdmin {
        skill = ISkill(_skillAddress);
    }

    function setContracts(
        address _userAddress,
        address _companyAddress,
        address _certAddress,
        address _expAddress,
        address _jobAddress,
        address _resumeAddress,
        address _skillAddress
    ) external onlyAdmin {
        user = IUser(_userAddress);
        company = ICompany(_companyAddress);
        certificate = ICertificate(_certAddress);
        experience = IExperience(_expAddress);
        job = IJob(_jobAddress);
        resume = IResume(_resumeAddress);
        skill = ISkill(_skillAddress);
    }

    /**
     * @custom:user-contract
     * */
    function isExisted(address _userAddress) external view returns (bool) {
        return user.isExisted(_userAddress);
    }

    function hasType(address _user, uint _type) external view returns (bool) {
        return user.hasType(_user, _type);
    }

    function getUser(
        address _userAddress
    ) external view returns (IUser.AppUser memory) {
        return user.getUser(_userAddress);
    }

    function getAllUser() external view returns (IUser.AppUser[] memory) {
        return user.getAllUser();
    }

    function getAllCandidates() external view returns (address[] memory) {
        return user.getAllCandidates();
    }

    function getAllRecruiters() external view returns (address[] memory) {
        return user.getAllRecruiters();
    }

    function getAllAdminCompany() external view returns (address[] memory) {
        return user.getAllAdminCompany();
    }

    function addUser(address _userAddress, uint _type) external {
        user.addUser(_userAddress, _type);
    }

    function deleteUser(address _userAddress) external {
        user.deleteUser(_userAddress);
    }

    /**
     * @custom:company-contract
     * */
    function isCreator(uint _id, address caller) external view returns (bool) {
        return company.isCreator(_id, caller);
    }

    function isExistedCompanyUser(
        address _userAddress,
        uint _companyId
    ) external view returns (bool) {
        return company.isExistedCompanyUser(_userAddress, _companyId);
    }

    function isExistedCompany(uint _id) external view returns (bool) {
        return company.isExistedCompany(_id);
    }

    function getCompany(
        uint _id
    ) external view returns (ICompany.AppCompany memory) {
        return company.getCompany(_id);
    }

    function getAllCompanies()
        external
        view
        returns (ICompany.AppCompany[] memory)
    {
        return company.getAllCompanies();
    }

    function addCompany(
        string memory _name,
        string memory _website,
        string memory _location,
        string memory _addr // address _adminAddress
    ) external {
        company.addCompany(_name, _website, _location, _addr);

        // company.connectCompanyRecruiter(
        //     _adminAddress,
        //     company.getLatestCompanyId()
        // );
    }

    function updateCompany(
        uint _id,
        string memory _name,
        string memory _website,
        string memory _location,
        string memory _addr
    ) external {
        company.updateCompany(_id, _name, _website, _location, _addr);
    }

    function deleteCompany(uint _id) external {
        company.deleteCompany(_id);
    }

    function connectCompanyUser(
        address _userAddress,
        uint _companyId
    ) external {
        company.connectCompanyUser(_userAddress, _companyId);
    }

    function disconnectCompanyUser(
        address _userAddress,
        uint _companyId
    ) external {
        company.disconnectCompanyUser(_userAddress, _companyId);
    }

    function getAllCompaniesConnectedUser(
        address _userAddress
    ) external view returns (ICompany.AppCompany[] memory) {
        return company.getAllCompaniesConnectedUser(_userAddress);
    }

    function getAllUsersConnectedCompany(
        uint _companyId
    ) external view returns (IUser.AppUser[] memory) {
        return company.getAllUsersConnectedCompany(_companyId);
    }

    /**
     * @custom:certificate-contract
     * */
    function isOwnerOfCertificate(
        address _candidateAddress,
        uint _id
    ) external view returns (bool) {
        return certificate.isOwnerOfCertificate(_candidateAddress, _id);
    }

    // function isVerifierOfCertificate(
    //     address _verifierAddress,
    //     uint _id
    // ) external view returns (bool) {
    //     return certificate.isVerifierOfCertificate(_verifierAddress, _id);
    // }

    function addCertificate(
        string memory _name,
        uint _expireAt,
        string memory _certificateAddress,
        address _candidateAddress,
        // address _verifierAddress,
        uint _companyId
    ) external {
        certificate.addCertificate(
            _name,
            _expireAt,
            _certificateAddress,
            _candidateAddress,
            // _verifierAddress,
            _companyId
        );
    }

    function updateCertificate(
        uint _id,
        string memory _name,
        uint _expiredAt
    )
        external
    /* string memory _certificateAddress,
        address _verifierAddress,
        uint _companyId */
    {
        certificate.updateCertificate(
            _id,
            _name,
            _expiredAt
            /* _certificateAddress,
            _verifierAddress,
            _companyId */
        );
    }

    function changeCertificateStatus(
        uint _id,
        uint _status /* ,
        uint _verifiedAt */
    ) external {
        certificate.changeCertificateStatus(_id, _status);
    }

    function deleteCertificate(uint _id) external {
        certificate.deleteCertificate(_id);
    }

    function getCertificate(
        uint _id
    )
        external
        view
        returns (
            // uint _id
            ICertificate.AppCertificate memory
        )
    {
        return certificate.getCertificate(_id);
    }

    function getAllCertificates()
        external
        view
        returns (ICertificate.AppCertificate[] memory)
    {
        return certificate.getAllCertificates();
    }

    // function getCertificateVerifier(
    //     address _verifierAddress
    // ) external view returns (ICertificate.AppCertificate[] memory) {
    //     return certificate.getCertificateVerifier(_verifierAddress);
    // }

    function getCertificateCandidate(
        address _candidateAddress
    ) external view returns (ICertificate.AppCertificate[] memory) {
        return certificate.getCertificateCandidate(_candidateAddress);
    }

    /**
     * @custom:experience-contract
     * */
    function addExperience(
        string memory _position,
        string memory _start,
        string memory _finish,
        string memory _source,
        uint _companyId
    ) external {
        experience.addExperience(
            _position,
            _start,
            _finish,
            _source,
            _companyId,
            tx.origin
        );
    }

    function updateExperience(
        uint _id,
        string memory _position,
        string memory _start,
        string memory _finish,
        uint _companyId
    ) external {
        experience.updateExperience(
            _id,
            _position,
            _start,
            _finish,
            _companyId
        );
    }

    function deleteExperience(uint _id) external {
        experience.deleteExperience(_id);
    }

    function changeExpStatus(
        uint _id,
        uint _status,
        uint _verifiedAt
    ) external {
        experience.changeExpStatus(_id, _status, _verifiedAt);
    }

    function getExperience(
        uint _id
    ) external view returns (IExperience.AppExperience memory) {
        return experience.getExperience(_id);
    }

    function getAllExperiences()
        external
        view
        returns (IExperience.AppExperience[] memory)
    {
        return experience.getAllExperiences();
    }

    function getAllExperiencesOf(
        address _userAddress
    ) external view returns (IExperience.AppExperience[] memory) {
        return experience.getAllExperiencesOf(_userAddress);
    }

    /**
     * @custom:resume-contract
     * */
    function isOwnerOfResume(
        address _candidateAddress,
        uint _id
    ) external view returns (bool) {
        return resume.isOwnerOfResume(_candidateAddress, _id);
    }

    function getResume(
        uint _id
    ) external view returns (IResume.AppResume memory) {
        return resume.getResume(_id);
    }

    function getAllResumes()
        external
        view
        returns (IResume.AppResume[] memory)
    {
        return resume.getAllResumes();
    }

    function getAllResumesOf(
        address _candidateAddress
    ) external view returns (IResume.AppResume[] memory) {
        return resume.getAllResumesOf(_candidateAddress);
    }

    function addResume(
        string memory _data,
        address _candidateAddress,
        string memory _title,
        uint _createAt
    ) external {
        resume.addResume(_data, _candidateAddress, _title, _createAt);
    }

    // function updateResume(
    //     uint _id,
    //     string memory _data,
    //     uint256 _updateAt
    // ) external {
    //     resume.updateResume(_id, _data, _updateAt);
    // }

    function deleteResume(uint _id) external {
        resume.deleteResume(_id);
    }

    function togglePublic(uint _id, string memory _data) external {
        resume.togglePublic(_id, _data);
    }

    function isExistedResumeRecruiter(
        address _recruiterAddress,
        uint _resumeId
    ) external view returns (bool) {
        return resume.isExistedResumeRecruiter(_recruiterAddress, _resumeId);
    }

    function getAllApprovedResumesOf(
        address _recruiterAddress
    ) external view returns (IResume.AppResume[] memory) {
        return resume.getAllApprovedResumesOf(_recruiterAddress);
    }

    function getAllApprovedRecruitersOf(
        uint _resumeId
    ) external view returns (address[] memory) {
        return resume.getAllApprovedRecruitersOf(_resumeId);
    }

    function connectResumeRecruiter(
        address _recruiterAddress,
        uint _resumeId
    ) external {
        resume.connectResumeRecruiter(_recruiterAddress, _resumeId);
    }

    function disconnectResumeRecruiter(
        address _recruiterAddress,
        uint _resumeId
    ) external {
        resume.disconnectResumeRecruiter(_recruiterAddress, _resumeId);
    }

    /**
     * @custom:job-contract
     * */
    function isExistedJob(uint _jobId) external view returns (bool) {
        return job.isExistedJob(_jobId);
    }

    function isOwnerOfJob(
        address _recruiterAddress,
        uint _jobId
    ) external view returns (bool) {
        return job.isOwnerOfJob(_recruiterAddress, _jobId);
    }

    function getJob(uint _id) external view returns (IJob.AppJob memory) {
        return job.getJob(_id);
    }

    function getAllJobs() external view returns (IJob.AppJob[] memory) {
        return job.getAllJobs();
    }

    function getAllJobsOf(
        address _recruiterAddress
    ) external view returns (IJob.AppJob[] memory) {
        return job.getAllJobsOf(_recruiterAddress);
    }

    function addJob(IJob.AppJob memory _job, uint[] memory _skillIds) external {
        job.addJob(_job);
        skill.connectJobSkill(_skillIds, job.getLatestJobId());
    }

    function updateJob(
        // uint _id,
        // string memory _title,
        // string memory _location,
        // string memory _jobType,
        // uint _experience,
        // string memory _requirements,
        // string memory _benefits,
        // uint _updateAt,
        // uint _companyId,
        // uint _salary,
        // string memory _field
        IJob.AppJob memory _job,
        uint[] memory _skillIds
    ) external {
        // job.updateJob(
        //     _id,
        //     _title,
        //     _location,
        //     _jobType,
        //     _experience,
        //     _requirements,
        //     _benefits,
        //     _updateAt,
        //     _companyId,
        //     _salary,
        //     _field
        // );
        job.updateJob(_job);
        if (_skillIds.length > 1) {
            skill.connectJobSkill(_skillIds, _job.id);
        }
    }

    function deleteJob(uint _id) external {
        job.deleteJob(_id);
    }

    function connectJobCandidate(
        address _candidateAddress,
        uint _jobId
    ) external {
        job.connectJobCandidate(_candidateAddress, _jobId);
    }

    function disconnectJobCandidate(
        address _candidateAddress,
        uint _jobId
    ) external {
        job.disconnectJobCandidate(_candidateAddress, _jobId);
    }

    function getAllAppliedJobsOf(
        address _candidate
    ) external view returns (IJob.AppJob[] memory) {
        return job.getAllAppliedJobsOf(_candidate);
    }

    function getAllAppliedCandidatesOf(
        uint _jobId
    ) external view returns (address[] memory) {
        return job.getAllAppliedCandidatesOf(_jobId);
    }

    /**
     * @custom:skill-contract
     * */
    function addSkill(string memory _name) external {
        skill.addSkill(_name);
    }

    function deleteSkill(uint _id) external {
        skill.deleteSkill(_id);
    }

    function getAllSkill() external view returns (ISkill.AppSkill[] memory) {
        return skill.getAllSkill();
    }

    function connectCandidateSkill(
        address _candidate,
        uint[] memory _skills
    ) external {
        skill.connectCandidateSkill(_candidate, _skills);
    }

    function disconnectCandidateSkill(
        address _candidate,
        uint[] memory _skills
    ) external {
        skill.disconnectCandidateSkill(_candidate, _skills);
    }

    function getAllSkillsOfCandidate(
        address _candidate
    ) external view returns (ISkill.AppSkill[] memory) {
        return skill.getAllSkillsOfCandidate(_candidate);
    }

    function connectJobSkill(uint[] memory _skills, uint _job) external {
        skill.connectJobSkill(_skills, _job);
    }

    function disconnectJobSkill(uint[] memory _skills, uint _job) external {
        skill.disconnectJobSkill(_skills, _job);
    }

    function getAllSkillsOfJob(
        uint _jobId
    ) external view returns (ISkill.AppSkill[] memory) {
        return skill.getAllSkillsOfJob(_jobId);
    }
}
