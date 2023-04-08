// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library/StringArray.sol";
import "./User.sol";

// // Candidate Relation
import "./Candidate.sol";
// import "./Experience.sol";
// import "./Certificate.sol";
// import "./Candidate_Skill.sol";

// // Recruiter Relation
// import "./Recruiter.sol";

// // Company Relation
// import "./Company.sol";
// import "./Location.sol";
// import "./Company_Recruiter.sol";

// // Resume Relation
// import "./Resume.sol";
// import "./Resume_Recruiter.sol";

// // Job Relation
// import "./Job.sol";
// import "./JobType.sol";
// import "./Job_Candidate.sol";
// import "./Job_Skill.sol";

// // Skill Relation
// import "./Skill.sol";

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
    // Candidate_SKill,
    // Recruiter,
    // Company,
    // Location,
    // Company_Recruiter,
    // Resume,
    // Resume_Recruiter,
    // Job,
    // JobType,
    // Job_Candidate,
    // Job_Skill,
    // Skill,
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
    event AddUser(address indexed userAddress, UserType userType);
    event DeleteUser(address indexed userAddress, UserType userType);

    // Override addUser function
    function addUser(
        address _userAddress,
        uint _type
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        (bool existed, ) = isExisted(_userAddress);
        require(!existed, "User: Address user is existed");
        super.addUser(_userAddress, _type);

        _setRole(_userAddress, CANDIDATE_ROLE);
        emit AddUser(_userAddress, UserType(_type));
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

        emit DeleteUser(_userAddress, user.userType);
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
    event DeleteCandidate(uint id);
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

        emit AddCandidate(
            _id,
            _avatar,
            _background,
            _addressWallet,
            _fullName,
            _email,
            _phone,
            _about
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

        emit UpdateCandidate(
            _id,
            _avatar,
            _background,
            _addressWallet,
            _fullName,
            _email,
            _phone,
            _about
        );
    }

    function deleteCandidate(
        uint _id
    ) public override onlyRole(msg.sender, ADMIN_ROLE) {
        super.deleteCandidate(_id);

        emit DeleteCandidate(_id);
    }

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
