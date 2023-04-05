// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library/StringArray.sol";
import "./User.sol";

// Candidate Relation
import "./Candidate.sol";
import "./Experience.sol";
import "./Certificate.sol";
import "./Candidate_Skill.sol";

// Recruiter Relation
import "./Recruiter.sol";

// Company Relation
import "./Company.sol";
import "./Location.sol";
import "./Company_Recruiter.sol";

// Resume Relation
import "./Resume.sol";
import "./Resume_Recruiter.sol";

// Job Relation
import "./Job.sol";
import "./JobType.sol";
import "./Job_Candidate.sol";
import "./Job_Skill.sol";

// Skill Relation
import "./Skill.sol";

// Field Relation
import "./Field.sol";

contract Resumiro is
    User,
    Candidate,
    Experience,
    Certificate,
    Candidate_SKill,
    Recruiter,
    Company,
    Location,
    Company_Recruiter,
    Resume,
    Resume_Recruiter,
    Job,
    JobType,
    Job_Candidate,
    Job_Skill,
    Skill,
    Field
{
    /**
     * @custom:resumiro
     * */
    /**
     * @custom:user-contract
     * */
    /**
     * @custom:candidate-contract
     * */
    /**
     * @custom:recruiter-contract
     * */
    /**
     * @custom:resume-contract
     * */
    /**
     *  @custom:job-contract
     * */
    /**
     * @custom:skill-contract
     * */
}

