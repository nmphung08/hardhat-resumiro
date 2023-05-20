// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../interfaces/ICompany.sol";
import "../interfaces/IUser.sol";
import "../interfaces/IJob.sol";
import "./library/UintArray.sol";

contract Job is IJob {
    //=============================ATTRIBUTES==========================================
    uint[] jobIds;
    uint jobCounter = 1;
    mapping(uint => AppJob) internal jobs;
    mapping(address => mapping(uint => bool)) internal candidateApplyJob;
    mapping(uint => address) internal recruiterOwnJob;
    ICompany internal company;
    IUser internal user;

    constructor(address _userContract, address _companyContract) {
        user = IUser(_userContract);
        company = ICompany(_companyContract);
    }

    //=============================EVENTS==========================================
    // event AddJob(
    //     uint id,
    //     string title,
    //     string location,
    //     string job_type,
    //     uint experience,
    //     string requirements,
    //     string benefits,
    //     uint create_at,
    //     uint update_at,
    //     uint companyId,
    //     uint salary,
    //     string field,
    //     address owner_address
    // );
    // event UpdateJob(
    //     uint id,
    //     string title,
    //     string location,
    //     string job_type,
    //     uint experience,
    //     string requirements,
    //     string benefits,
    //     uint create_at,
    //     uint update_at,
    //     uint companyId,
    //     uint salary,
    //     string field,
    //     address owner_address
    // );
    // event DeleteJob(
    //     uint id,
    //     string title,
    //     string location,
    //     string job_type,
    //     uint experience,
    //     string requirements,
    //     string benefits,
    //     uint create_at,
    //     uint update_at,
    //     uint companyId,
    //     uint salary,
    //     string field,
    //     address owner_address
    // );
    event AddJob(AppJob job);
    event UpdateJob(AppJob job);
    event DeleteJob(AppJob job);
    event ApplyJob(
        address indexed candidate_address,
        address indexed recruiter_address,
        uint job_id,
        bool isApplied
    );
    event DisapplyJob(
        address indexed candidate_address,
        address indexed recruiter_address,
        uint job_id,
        bool isApplied
    );

    //=============================ERRORS==========================================
    error Job__NotExisted(uint id);
    error Job__AlreadyExisted(uint id);

    error Recruiter_Company__NotIn(address recruiter_address, uint company_id);

    error Recruiter_Job__NotOwned(address recruiter_address, uint id);

    error Candidate__NotExisted(address user_address);
    error Recruiter__NotExisted(address user_address);

    error Candidate_Job__NotApplied(address candidate_address, uint id);
    error Candidate_Job__AlreadyApplied(address candidate_address, uint id);

    //=============================METHODS==========================================
    //======================JOBS==========================
    function _isOwnerOfJob(
        address _recruiterAddress,
        uint _jobId
    ) internal view returns (bool) {
        return recruiterOwnJob[_jobId] == _recruiterAddress;
    }

    function _getJob(uint _id) internal view returns (AppJob memory) {
        return jobs[_id];
    }

    function _getAllJobs() internal view returns (AppJob[] memory) {
        AppJob[] memory arrJob = new AppJob[](jobIds.length);

        for (uint i = 0; i < jobIds.length; i++) {
            arrJob[i] = jobs[jobIds[i]];
        }

        return arrJob;
    }

    function _getAllJobsOf(
        address _recruiterAddress
    ) internal view returns (AppJob[] memory) {
        AppJob[] memory arrJob = new AppJob[](jobIds.length);

        for (uint i = 0; i < jobIds.length; i++) {
            if (jobs[jobIds[i]].owner == _recruiterAddress) {
                arrJob[i] = jobs[jobIds[i]];
            }
        }

        return arrJob;
    }

    // only recruiter -> later⏳
    // param _recruiterAddress must equal msg.sender -> later⏳
    // job id must not existed -> done✅
    // just for recruiter in user contract -> done✅
    // recruiter must connected with company id -> done✅
    function _addJob(
        // string memory _title,
        // string memory _location,
        // string memory _jobType,
        // uint _experience,
        // string memory _requirements,
        // string memory _benefits,
        // uint _createAt,
        // uint _updateAt,
        // uint _companyId,
        // uint _salary,
        // string memory _field,
        // address _recruiterAddress
        AppJob memory _job
    ) internal {
        uint _id = jobCounter;
        jobCounter++;
        if (jobs[_id].exist) {
            revert Job__AlreadyExisted({id: _id});
        }
        if (!(user.isExisted(_job.owner) && user.hasType(_job.owner, 1) || user.hasType(_job.owner, 2))) {
            revert Recruiter__NotExisted({user_address: _job.owner});
        }
        if (!company.isExistedCompanyRecruiter(_job.owner, _job.companyId)) {
            revert Recruiter_Company__NotIn({
                recruiter_address: _job.owner,
                company_id: _job.companyId
            });
        }

        jobs[_id] = AppJob(
            jobIds.length,
            _id,
            _job.title,
            _job.location,
            _job.jobType,
            _job.experience,
            _job.requirements,
            _job.benefits,
            _job.createAt,
            _job.updateAt,
            _job.companyId,
            _job.salary,
            _job.field,
            true,
            _job.owner
        );
        jobIds.push(_id);

        // AppJob memory job = _getJob(_id);
        recruiterOwnJob[_id] = _job.owner;
        // address owner = recruiterOwnJob[_id];

        emit AddJob(
            // _id,
            // _job.title,
            // _job.location,
            // _job.jobType,
            // _job.experience,
            // _job.requirements,
            // _job.benefits,
            // _job.createAt,
            // _job.updateAt,
            // _job.companyId,
            // _job.salary,
            // _job.field,
            // _job.owner
            _job
        );
    }

    // only recruiter -> later⏳
    // job id must existed -> done✅
    // only owner of job -> later⏳
    // recruiter must connected with update company -> later⏳
    function _updateJob(
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
        AppJob memory _job
    ) internal {
        if (!jobs[_job.id].exist) {
            revert Job__NotExisted({id: _job.id});
        }

        // if (!isOwnerOfJob(msg.sender, _id)) {
        //     revert Recruiter_Job__NotOwned({
        //         recruiter_address: msg.sender,
        //         id: _id
        //     });
        // }

        // if (!company.isExistedCompanyRecruiter(msg.sender, _companyId)) {
        //     revert Recruiter_Company__NotIn({
        //         recruiter_address: msg.sender,
        //         company_id: _companyId
        //     });
        // }

        jobs[_job.id].title = _job.title;
        jobs[_job.id].location = _job.location;
        jobs[_job.id].jobType = _job.jobType;
        jobs[_job.id].experience = _job.experience;
        jobs[_job.id].requirements = _job.requirements;
        jobs[_job.id].benefits = _job.benefits;
        jobs[_job.id].updateAt = _job.updateAt;
        jobs[_job.id].companyId = _job.companyId;
        jobs[_job.id].salary = _job.salary;
        jobs[_job.id].field = _job.field;

        // AppJob memory job = _getJob(_job.id);
        // address owner = recruiterOwnJob[_job.id];
        emit UpdateJob(
            // _job.id,
            // _job.title,
            // _job.location,
            // _job.jobType,
            // _job.experience,
            // _job.requirements,
            // _job.benefits,
            // _job.createAt,
            // _job.updateAt,
            // _job.companyId,
            // _job.salary,
            // _job.field,
            // _job.owner
            _job
        );
    }

    // only recruiter -> later⏳
    // job id must existed -> done✅
    // only owner of job -> later⏳
    function _deleteJob(uint _id) internal {
        if (!jobs[_id].exist) {
            revert Job__NotExisted({id: _id});
        }

        // if (!isOwnerOfJob(msg.sender, _id)) {
        //     revert Recruiter_Job__NotOwned({
        //         recruiter_address: msg.sender,
        //         id: _id
        //     });
        // }

        AppJob memory job = _getJob(_id);
        // address ownerOfJob = recruiterOwnJob[_id];

        jobs[jobIds[jobIds.length - 1]].index = jobs[_id].index;
        UintArray.remove(jobIds, jobs[_id].index);

        delete jobs[_id];
        delete recruiterOwnJob[_id];

        emit DeleteJob(
            // _id,
            // job.title,
            // job.location,
            // job.jobType,
            // job.experience,
            // job.requirements,
            // job.benefits,
            // job.createAt,
            // job.updateAt,
            // job.companyId,
            // job.salary,
            // job.field,
            // ownerOfJob
            job
        );
    }

    //======================JOB-CANDIDATE==========================
    // only candidate -> later⏳
    // param _candidateAddress must equal msg.sender -> later⏳
    // candidate have skills to apply for the job -> later⏳ -> hard🔥
    // job must existed -> done✅
    // just candidate in user contract apply -> done✅
    // candidate have not applied this job yet -> done✅
    function _connectJobCandidate(
        address _candidateAddress,
        uint _jobId
    ) internal {
        if (!jobs[_jobId].exist) {
            revert Job__NotExisted({id: _jobId});
        }
        if (
            !(user.isExisted(_candidateAddress) &&
                user.hasType(_candidateAddress, 0))
        ) {
            revert Candidate__NotExisted({user_address: _candidateAddress});
        }
        if (candidateApplyJob[_candidateAddress][_jobId]) {
            revert Candidate_Job__AlreadyApplied({
                candidate_address: _candidateAddress,
                id: _jobId
            });
        }

        require(jobs[_jobId].exist, "Job-Applicant: id not existed");
        require(
            !candidateApplyJob[_candidateAddress][_jobId],
            "Job-Applicant: Candidate already applied this job"
        );

        candidateApplyJob[_candidateAddress][_jobId] = true;
        address owner = recruiterOwnJob[_jobId];
        bool isApplied = candidateApplyJob[_candidateAddress][_jobId];

        emit ApplyJob(_candidateAddress, owner, _jobId, isApplied);
    }

    // only candidate -> later⏳
    // param _candidateAddress must equal msg.sender -> later⏳
    // job must existed -> done✅
    // just candidate in user contract disapply -> done✅
    // candidate have applied this job -> done✅
    function _disconnectJobCandidate(
        address _candidateAddress,
        uint _jobId
    ) internal {
        if (!jobs[_jobId].exist) {
            revert Job__NotExisted({id: _jobId});
        }
        if (
            !(user.isExisted(_candidateAddress) &&
                user.hasType(_candidateAddress, 0))
        ) {
            revert Candidate__NotExisted({user_address: _candidateAddress});
        }
        if (!candidateApplyJob[_candidateAddress][_jobId]) {
            revert Candidate_Job__NotApplied({
                candidate_address: _candidateAddress,
                id: _jobId
            });
        }

        candidateApplyJob[_candidateAddress][_jobId] = false;
        address owner = recruiterOwnJob[_jobId];
        bool isApplied = candidateApplyJob[_candidateAddress][_jobId];

        emit DisapplyJob(_candidateAddress, owner, _jobId, isApplied);
    }

    function _getAllAppliedJobsOf(
        address _candidate
    ) internal view returns (AppJob[] memory) {
        AppJob[] memory arrJob = new AppJob[](jobIds.length);

        for (uint i = 0; i < arrJob.length; i++) {
            if (candidateApplyJob[_candidate][jobIds[i]]) {
                arrJob[i] = jobs[jobIds[i]];
            }
        }

        return arrJob;
    }

    function _getAllAppliedCandidatesOf(
        uint _jobId
    ) internal view returns (IUser.AppUser[] memory) {
        IUser.AppUser[] memory arrCandidate = user.getAllCandidates();
        IUser.AppUser[] memory arrAppliedCandidate = new IUser.AppUser[](
            arrCandidate.length
        );

        for (uint i = 0; i < arrCandidate.length; i++) {
            if (candidateApplyJob[arrCandidate[i].accountAddress][_jobId]) {
                arrAppliedCandidate[i] = arrCandidate[i];
            }
        }

        return arrAppliedCandidate;
    }

    //======================FOR INTERFACE==========================
    function isExistedJob(uint _jobId) external view returns (bool) {
        return jobs[_jobId].exist;
    }

    function isOwnerOfJob(
        address _recruiterAddress,
        uint _jobId
    ) external view returns (bool) {
        return _isOwnerOfJob(_recruiterAddress, _jobId);
    }

    function getJob(uint _id) external view returns (AppJob memory) {
        return _getJob(_id);
    }

    function getAllJobs() external view returns (AppJob[] memory) {
        return _getAllJobs();
    }

    function getAllJobsOf(
        address _recruiterAddress
    ) external view returns (AppJob[] memory) {
        return _getAllJobsOf(_recruiterAddress);
    }

    function getLatestJobId() external view returns (uint) {
        return jobCounter - 1;
    }

    function addJob(
        // string memory _title,
        // string memory _location,
        // string memory _jobType,
        // uint _experience,
        // string memory _requirements,
        // string memory _benefits,
        // uint _createAt,
        // uint _updateAt,
        // uint _companyId,
        // uint _salary,
        // string memory _field,
        // address _recruiterAddress
        AppJob memory _job
    ) external {
        _addJob(
            // _title,
            // _location,
            // _jobType,
            // _experience,
            // _requirements,
            // _benefits,
            // _createAt,
            // _updateAt,
            // _companyId,
            // _salary,
            // _field,
            // _recruiterAddress
            _job
        );
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
        AppJob memory _job
    ) external {
        _updateJob(
            // _id,
            // _title,
            // _location,
            // _jobType,
            // _experience,
            // _requirements,
            // _benefits,
            // _updateAt,
            // _companyId,
            // _salary,
            // _field
            _job
        );
    }

    function deleteJob(uint _id) external {
        _deleteJob(_id);
    }

    function connectJobCandidate(
        address _candidateAddress,
        uint _jobId
    ) external {
        _connectJobCandidate(_candidateAddress, _jobId);
    }

    function disconnectJobCandidate(
        address _candidateAddress,
        uint _jobId
    ) external {
        return _disconnectJobCandidate(_candidateAddress, _jobId);
    }

    function getAllAppliedJobsOf(
        address _candidate
    ) external view returns (AppJob[] memory) {
        return _getAllAppliedJobsOf(_candidate);
    }

    function getAllAppliedCandidatesOf(
        uint _jobId
    ) external view returns (IUser.AppUser[] memory) {
        return _getAllAppliedCandidatesOf(_jobId);
    }

    //======================INTERFACES==========================
    function setUserInterface(address _contract) public {
        user = IUser(_contract);
    }

    function setCompanyInterface(address _contract) public {
        company = ICompany(_contract);
    }
}
