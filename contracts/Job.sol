// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library/UintArray.sol";

contract Job {
    struct AppJob {
        uint id;
        string title;
        uint locationId;
        uint jobTypeId;
        uint experience;
        string requirements;
        string benefits;
        string createAt;
        string updateAt;
        uint recruiterId;
        uint companyId;
        uint salary;
        uint fieldId;
    }

    using UintArray for uint[];
    uint[] internal s_jobIds;
    mapping(uint => AppJob) internal s_jobs;
    mapping(uint => uint[]) internal s_locationToJob;
    mapping(uint => uint[]) internal s_recruiterToJob;
    mapping(uint => uint[]) internal s_companyToJob;
    mapping(uint => uint[]) internal s_typeToJob;
    uint internal s_jobCounter = 0;

    function addJob(AppJob memory _job) public {
        uint _id = s_jobCounter;
        s_jobIds.push(_id);
        s_locationToJob[_job.locationId].push(_id);
        s_recruiterToJob[_job.recruiterId].push(_id);
        s_companyToJob[_job.companyId].push(_id);
        s_typeToJob[_job.fieldId].push(_id);
        s_jobs[_id] = AppJob(
            _id,
            _job.title,
            _job.locationId,
            _job.jobTypeId,
            _job.experience,
            _job.requirements,
            _job.benefits,
            _job.createAt,
            _job.updateAt,
            _job.recruiterId,
            _job.companyId,
            _job.salary,
            _job.fieldId
        );
        s_jobCounter++;
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
    ) public {
        s_jobs[_id].title = _title;
        s_jobs[_id].jobTypeId = _jobTypeId;
        s_jobs[_id].experience = _experience;
        s_jobs[_id].requirements = _requirements;
        s_jobs[_id].benefits = _benefits;
        s_jobs[_id].createAt = _createAt;
        s_jobs[_id].updateAt = _updateAt;
        s_jobs[_id].salary = _salary;
    }

    function deleteJob(uint _id) public {
        AppJob memory job = s_jobs[_id];
        s_jobIds.removeElement(_id);
        s_locationToJob[job.locationId].removeElement(_id);
        s_recruiterToJob[job.recruiterId].removeElement(_id);
        s_companyToJob[job.companyId].removeElement(_id);
        s_typeToJob[job.fieldId].removeElement(_id);
        delete s_jobs[_id];
    }

    function getJob(uint _id) public view returns (AppJob memory) {
        return s_jobs[_id];
    }

    function getNewestJob() public view returns (AppJob memory) {
        return s_jobs[s_jobIds.length - 1];
    }

    function getJobs(uint[] memory _ids) public view returns (AppJob[] memory) {
        AppJob[] memory jobs = new AppJob[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            jobs[i] = s_jobs[_ids[i]];
        }
        return jobs;
    }

    function getAllJobs() public view returns (AppJob[] memory) {
        AppJob[] memory jobs = new AppJob[](s_jobIds.length);
        for (uint i = 0; i < s_jobIds.length; i++) {
            jobs[i] = s_jobs[s_jobIds[i]];
        }
        return jobs;
    }

    function getJobsThruLocation(
        uint _id
    ) public view returns (AppJob[] memory) {
        uint[] memory ids = s_locationToJob[_id];
        return getJobs(ids);
    }

    function getJobsThruRecruiter(
        uint _id
    ) public view returns (AppJob[] memory) {
        uint[] memory ids = s_recruiterToJob[_id];
        return getJobs(ids);
    }

    function getJobsThruCompany(
        uint _id
    ) public view returns (AppJob[] memory) {
        uint[] memory ids = s_companyToJob[_id];
        return getJobs(ids);
    }

    function getJobsThruType(uint _id) public view returns (AppJob[] memory) {
        uint[] memory ids = s_typeToJob[_id];
        return getJobs(ids);
    }

    function getJobIds() public view returns (uint[] memory) {
        return s_jobIds;
    }
}
