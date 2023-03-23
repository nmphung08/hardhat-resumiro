// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library/StringArray.sol";

contract Job {
    struct AppJob {
        string id;
        string title;
        string locationId;
        string position;
        string experience;
        string requirements;
        string benefits;
        string createAt;
        string updateAt;
        string recruiterId;
        string companyId;
        string salary;
        string jobTypeId;
    }

    using StringArray for string[];
    string[] internal s_jobIds;
    mapping(string => AppJob) internal s_jobs;
    mapping(string => string[]) internal s_locationToJob;
    mapping(string => string[]) internal s_recruiterToJob;
    mapping(string => string[]) internal s_companyToJob;
    mapping(string => string[]) internal s_typeToJob;

    function addJob(
        string memory _id,
        string memory _title,
        string memory _locationId,
        string memory _position,
        string memory _experience,
        string memory _requirements,
        string memory _benefits,
        string memory _createAt,
        string memory _updateAt,
        string memory _recruiterId,
        string memory _companyId,
        string memory _salary,
        string memory _jobTypeId
    ) public virtual {
        s_jobIds.push(_id);
        s_locationToJob[_locationId].push(_id);
        s_recruiterToJob[_recruiterId].push(_id);
        s_companyToJob[_companyId].push(_id);
        s_typeToJob[_jobTypeId].push(_id);
        s_jobs[_id] = AppJob(
            _id,
            _title,
            _locationId,
            _position,
            _experience,
            _requirements,
            _benefits,
            _createAt,
            _updateAt,
            _recruiterId,
            _companyId,
            _salary,
            _jobTypeId
        );
    }

    function updateJob(
        string memory _id,
        string memory _title,
        string memory _position,
        string memory _experience,
        string memory _requirements,
        string memory _benefits,
        string memory _createAt,
        string memory _updateAt,
        string memory _salary
    ) public {
        s_jobs[_id].title = _title;
        s_jobs[_id].position = _position;
        s_jobs[_id].experience = _experience;
        s_jobs[_id].requirements = _requirements;
        s_jobs[_id].benefits = _benefits;
        s_jobs[_id].createAt = _createAt;
        s_jobs[_id].updateAt = _updateAt;
        s_jobs[_id].salary = _salary;
    }

    function deleteJob(string memory _id) public {
        AppJob memory job = s_jobs[_id];
        s_jobIds.removeElement(_id);
        s_locationToJob[job.locationId].removeElement(_id);
        s_recruiterToJob[job.recruiterId].removeElement(_id);
        s_companyToJob[job.companyId].removeElement(_id);
        s_typeToJob[job.jobTypeId].removeElement(_id);
        delete s_jobs[_id];
    }

    function getJob(string memory _id) public view returns (AppJob memory) {
        return s_jobs[_id];
    }

    function getJobs(
        string[] memory _ids
    ) public view returns (AppJob[] memory) {
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
        string memory _id
    ) public view returns (AppJob[] memory) {
        string[] memory ids = s_locationToJob[_id];
        return getJobs(ids);
    }

    function getJobsThruRecruiter(
        string memory _id
    ) public view returns (AppJob[] memory) {
        string[] memory ids = s_recruiterToJob[_id];
        return getJobs(ids);
    }

    function getJobsThruCompany(
        string memory _id
    ) public view returns (AppJob[] memory) {
        string[] memory ids = s_companyToJob[_id];
        return getJobs(ids);
    }

    function getJobsThruType(
        string memory _id
    ) public view returns (AppJob[] memory) {
        string[] memory ids = s_typeToJob[_id];
        return getJobs(ids);
    }
}
