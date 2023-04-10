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
import "./Recruiter.sol";

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
    Recruiter,
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
    /**
     *  @custom:job-contract
     * */
    /**
     * @custom:skill-contract
     * */
}
