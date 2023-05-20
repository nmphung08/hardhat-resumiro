// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../interfaces/IExperience.sol";
import "../interfaces/ICompany.sol";
import "../interfaces/IUser.sol";
import "./library/UintArray.sol";

contract Experience is IExperience {
    //=============================ATTRIBUTES==========================================
    uint[] experienceIds;
    uint experienceCounter = 1;
    mapping(uint => AppExperience) experiences;
    mapping(address => mapping(uint => bool)) experienceOfUser;
    ICompany company;
    IUser user;

    constructor(address _userContract, address _companyContract) {
        user = IUser(_userContract);
        company = ICompany(_companyContract);
    }

    //=============================EVENTS=====================================
    event AddExperience(
        uint id,
        string position,
        string start,
        string finish,
        uint company_id,
        address indexed user_address
    );
    event UpdateExperience(
        uint id,
        string position,
        string start,
        string finish,
        uint company_id,
        address indexed user_address
    );
    event DeleteExperience(
        uint id,
        string position,
        string start,
        string finish,
        uint company_id,
        address indexed user_address
    );

    //=============================ERRORS==========================================
    error Experience__AlreadyExisted(uint experience_id, address user_address);
    error Experience__NotExisted(uint experience_id, address user_address);

    error Company__NotExisted(uint experience_id, uint company_id);
    error User__NotExisted(address user_address);

    error Experience_User__AlreadyConnected(
        uint experience_id,
        address user_address
    );
    error Experience_User__NotConnected(
        uint experience_id,
        address user_address
    );

    //=============================METHODS==========================================
    //=================EXPERIENCES========================
    // only user -> later⏳
    // param _user must equal msg.sender -> later⏳
    // experience id must not existed -> done✅
    // company must existed -> done✅
    // just for user -> done✅
    // experience have not been connected with user yet -> done✅
    function _addExperience(
        string memory _position,
        string memory _start,
        string memory _finish,
        uint _companyId,
        address _user
    ) internal {
        uint _id = experienceCounter;
        experienceCounter++;
        if (experiences[_id].exist) {
            revert Experience__AlreadyExisted({
                experience_id: _id,
                user_address: _user
            });
        }
        if (!company.isExistedCompany(_companyId)) {
            revert Company__NotExisted({
                experience_id: _id,
                company_id: _companyId
            });
        }
        if (!user.isExisted(_user)) {
            revert User__NotExisted({user_address: _user});
        }
        if (experienceOfUser[_user][_id]) {
            revert Experience_User__AlreadyConnected({
                experience_id: _id,
                user_address: _user
            });
        }

        experiences[_id] = AppExperience(
            experienceIds.length,
            _id,
            _position,
            _start,
            _finish,
            _companyId,
            true,
            _user
        );
        experienceOfUser[_user][_id] = true;
        experienceIds.push(_id);

        AppExperience memory exp = experiences[_id];

        emit AddExperience(
            _id,
            exp.position,
            exp.start,
            exp.finish,
            exp.companyId,
            _user
        );
    }

    // only user -> later⏳
    // experience id must existed -> done✅
    // company must existed -> done✅
    // just for user -> done✅
    function _updateExperience(
        uint _id,
        string memory _position,
        string memory _start,
        string memory _finish,
        uint _companyId,
        address _user
    ) internal {
        if (!experiences[_id].exist) {
            revert Experience__NotExisted({
                experience_id: _id,
                user_address: _user
            });
        }
        if (!company.isExistedCompany(_companyId)) {
            revert Company__NotExisted({
                experience_id: _id,
                company_id: _companyId
            });
        }
        if (!user.isExisted(_user)) {
            revert User__NotExisted({user_address: _user});
        }

        experiences[_id].position = _position;
        experiences[_id].start = _start;
        experiences[_id].finish = _finish;
        experiences[_id].companyId = _companyId;

        AppExperience memory exp = experiences[_id];

        emit UpdateExperience(
            _id,
            exp.position,
            exp.start,
            exp.finish,
            exp.companyId,
            _user
        );
    }

    // only user -> later⏳
    // param _user must equal msg.sender -> later⏳
    // experience id must existed -> done✅
    // just for user -> done✅
    // experience have been connected with user yet -> done✅
    function _deleteExperience(uint _id, address _user) internal {
        if (!experiences[_id].exist) {
            revert Experience__NotExisted({
                experience_id: _id,
                user_address: _user
            });
        }
        if (!user.isExisted(_user)) {
            revert User__NotExisted({user_address: _user});
        }
        if (!experienceOfUser[_user][_id]) {
            revert Experience_User__NotConnected({
                experience_id: _id,
                user_address: _user
            });
        }

        AppExperience memory exp = experiences[_id];

        uint lastIndex = experienceIds.length - 1;
        experiences[experienceIds[lastIndex]].index = experiences[_id].index;
        UintArray.remove(experienceIds, experiences[_id].index);

        delete experiences[_id];
        delete experienceOfUser[_user][_id];

        emit AddExperience(
            _id,
            exp.position,
            exp.start,
            exp.finish,
            exp.companyId,
            _user
        );
    }

    function _getExperience(
        uint _id
    ) internal view returns (AppExperience memory) {
        return experiences[_id];
    }

    function _getAllExperiences()
        internal
        view
        returns (AppExperience[] memory)
    {
        AppExperience[] memory arrExp = new AppExperience[](
            experienceIds.length
        );

        for (uint i = 0; i < arrExp.length; i++) {
            arrExp[i] = experiences[experienceIds[i]];
        }

        return arrExp;
    }

    function _getAllExperiencesOf(
        address _userAddress
    ) internal view returns (AppExperience[] memory) {
        AppExperience[] memory arrExp = new AppExperience[](
            experienceIds.length
        );

        for (uint i = 0; i < arrExp.length; i++) {
            if (experienceOfUser[_userAddress][experienceIds[i]]) {
                arrExp[i] = experiences[experienceIds[i]];
            }
        }

        return arrExp;
    }

    //======================FOR INTERFACE==========================
    function addExperience(
        string memory _position,
        string memory _start,
        string memory _finish,
        uint _companyId,
        address _user
    ) external {
        _addExperience(_position, _start, _finish, _companyId, _user);
    }

    function updateExperience(
        uint _id,
        string memory _position,
        string memory _start,
        string memory _finish,
        uint _companyId,
        address _user
    ) external {
        _updateExperience(_id, _position, _start, _finish, _companyId, _user);
    }

    function deleteExperience(uint _id, address _user) external {
        _deleteExperience(_id, _user);
    }

    function getExperience(
        uint _id
    ) external view returns (AppExperience memory) {
        return _getExperience(_id);
    }

    function getAllExperiences()
        external
        view
        returns (AppExperience[] memory)
    {
        return _getAllExperiences();
    }

    function getAllExperiencesOf(
        address _userAddress
    ) external view returns (AppExperience[] memory) {
        return _getAllExperiencesOf(_userAddress);
    }

    //======================INTERFACES==========================
    function setUserInterface(address _contract) public {
        user = IUser(_contract);
    }

    function setCompanyInterface(address _contract) public {
        company = ICompany(_contract);
    }
}
