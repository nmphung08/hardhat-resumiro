// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract User {
    enum UserType {
        CANDIDATE,
        RECRUITER,
        VERIFIER
    }

    struct AppUser {
        UserType userType;
        bool exist;
    }

    address[] verifiers;

    //=============================ATTRIBUTES==========================================
    mapping(address => AppUser) users;

    //=============================EVENTS==========================================
    event AddUser(address indexed user_address, UserType user_type, bool exist);
    event DeleteUser(address indexed user_address, UserType user_type);

    //=============================ERRORS==========================================
    error AlreadyExistedUser(address user_address, UserType user_type);
    error NotExistedUser(address user_address);

    //=============================METHODS==========================================
    function getUser(
        address _userAddress
    ) public view returns (AppUser memory) {
        return users[_userAddress];
    }

    // only admin -> later⏳
    // user must not existed -> done✅
    function addUser(address _userAddress, uint _type) public virtual {
        if (users[_userAddress].exist) {
            revert AlreadyExistedUser({
                user_address: _userAddress,
                user_type: UserType(_type)
            });
        }

        users[_userAddress] = AppUser(UserType(_type), true);

        if (_type == 2) {
            verifiers.push(_userAddress);
        }

        AppUser memory user = getUser(_userAddress);

        emit AddUser(_userAddress, user.userType, user.exist);
    }

    // only admin -> later⏳
    // user must existed -> done✅
    function deleteUser(address _userAddress) public virtual {
        if (!users[_userAddress].exist) {
            revert NotExistedUser({user_address: _userAddress});
        }

        AppUser memory deletedUser = getUser(_userAddress);

        if (deletedUser.userType == UserType(2)) {
            for (uint i = 0; i < verifiers.length; i ++) {
                if (verifiers[i] == _userAddress) {
                    delete verifiers[i];
                    break;
                }
            }
        }

        delete users[_userAddress];

        emit DeleteUser(_userAddress, deletedUser.userType);
    }

    function getVerifiers() public view returns (address [] memory) {
        return verifiers;
    }

    //=============================FOR INTERFACE==========================================
    function isExisted(address _userAddress) external view returns (bool) {
        return users[_userAddress].exist;
    }

    function hasType(address _user, uint _type) external view returns (bool) {
        return users[_user].userType == UserType(_type);
    }
}
