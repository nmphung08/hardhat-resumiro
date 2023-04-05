// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./library/UintArray.sol";

contract Field {
    struct AppField {
        uint id;
        string name;
        string description;
    }

    using UintArray for uint[];
    uint[] internal s_fieldIds;
    mapping(uint => AppField) internal s_fields;
    uint internal s_fieldCounter = 0;

    function addField(string memory _name, string memory _description) public {
        uint _id = s_fieldCounter;
        s_fieldIds.push(_id);
        s_fields[_id] = AppField(_id, _name, _description);
        s_fieldCounter++;
    }

    function updateField(
        uint _id,
        string memory _name,
        string memory _description
    ) public {
        s_fields[_id].name = _name;
        s_fields[_id].description = _description;
    }

    function deleteField(uint _id) public {
        s_fieldIds.removeElement(_id);
        delete s_fields[_id];
    }

    function getField(uint _id) public view returns (AppField memory) {
        return s_fields[_id];
    }

    function getFields(
        uint[] memory _ids
    ) public view returns (AppField[] memory) {
        AppField[] memory Fields = new AppField[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            Fields[i] = s_fields[_ids[i]];
        }
        return Fields;
    }

    function getAllFields() public view returns (AppField[] memory) {
        AppField[] memory Fields = new AppField[](s_fieldIds.length);
        for (uint i = 0; i < s_fieldIds.length; i++) {
            Fields[i] = s_fields[s_fieldIds[i]];
        }
        return Fields;
    }
}
