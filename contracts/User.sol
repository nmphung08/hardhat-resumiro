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
        string id;
        UserType userType;
        bool exist;
    }

    mapping(address => string) internal s_userIds;
    mapping(string => AppUser) internal s_users;

    function addUser(
        address _userAddress,
        string memory _id,
        uint _type
    ) public {
        // (bool b, ) = isExisted(_userAddress);
        // if (b) revert User__AlreadyExisted();
        s_userIds[_userAddress] = _id;
        s_users[_id] = AppUser(_id, UserType(_type), true);
    }

    function deleteUser(address _userAddress) public {
        // (bool b, ) = isExisted(_userAddress);
        // if (!b) revert User__NotExisted();

        string memory id = s_userIds[_userAddress];
        delete s_users[id];
        delete s_userIds[_userAddress];
    }


    function isExisted(
        address _userAddress
    ) public view returns (bool, AppUser memory) {
        string memory id = s_userIds[_userAddress];
        AppUser memory user = s_users[id];
        if (user.exist) {
            return (true, s_users[id]);
        } else {
            return (false, AppUser("", UserType(0), false));
        }
    }

}
