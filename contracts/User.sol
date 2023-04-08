// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// error User__AlreadyExisted();
// error User__NotExisted();

contract User {
    enum UserType {
        RECRUITER,
        CANDIDATE
    }

    struct AppUser {
        uint id;
        UserType userType;
        bool exist;
    }

    mapping(address => uint) public s_userIds;
    mapping(uint => AppUser) public s_users;
    uint internal s_userCounter = 0;

    function addUser(address _userAddress, uint _type) public virtual {
        // (bool b, ) = isExisted(_userAddress);
        // if (b) revert User__AlreadyExisted();
        uint _id = s_userCounter;
        s_userIds[_userAddress] = _id;
        s_users[_id] = AppUser(_id, UserType(_type), true);
        s_userCounter++;
    }

    function deleteUser(address _userAddress) public virtual {
        // (bool b, ) = isExisted(_userAddress);
        // if (!b) revert User__NotExisted();

        uint id = s_userIds[_userAddress];
        delete s_users[id];
        delete s_userIds[_userAddress];
    }

    function isExisted(
        address _userAddress
    ) public view returns (bool, AppUser memory) {
        uint id = s_userIds[_userAddress];
        AppUser memory user = s_users[id];
        if (user.exist) {
            return (true, s_users[id]);
        } else {
            return (false, AppUser(0, UserType(0), false));
        }
    }
}
