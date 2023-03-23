// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/StringArray.sol";

contract Company {
    struct AppCompany {
        string id;
        string owner;
        string name;
        string logo;
        string background;
        string about;
        string scale;
        string website;
        string locationId;
        string addr;
        string introduction;
    }

    using StringArray for string[];
    string[] internal s_compIds;
    mapping(string => AppCompany) internal s_companies;
    mapping(string => string[]) internal s_locationToCompany;

    function addCompany(
        string memory _id,
        string memory _owner,
        string memory _name,
        string memory _logo,
        string memory _background,
        string memory _about,
        string memory _scale,
        string memory _website,
        string memory _locationId,
        string memory _addr,
        string memory _introduction
    ) public {
        s_compIds.push(_id);
        s_locationToCompany[_locationId].push(_id);
        s_companies[_id] = AppCompany(
            _id,
            _owner,
            _name,
            _logo,
            _background,
            _about,
            _scale,
            _website,
            _locationId,
            _addr,
            _introduction
        );
    }

    function updateCompany(
        string memory _id,
        string memory _name,
        string memory _logo,
        string memory _background,
        string memory _about,
        string memory _scale,
        string memory _website,
        string memory _locationId,
        string memory _addr,
        string memory _introduction
    ) public {
        s_companies[_id].name = _name;
        s_companies[_id].logo = _logo;
        s_companies[_id].background = _background;
        s_companies[_id].background = _background;
        s_companies[_id].about = _about;
        s_companies[_id].scale = _scale;
        s_companies[_id].website = _website;
        s_companies[_id].locationId = _locationId;
        s_companies[_id].addr = _addr;
        s_companies[_id].introduction = _introduction;
    }

    function deleteCompany(string memory _id) public {
        s_compIds.removeElement(_id);
        string memory locationId = s_companies[_id].locationId;
        s_locationToCompany[locationId].removeElement(_id);
        delete s_companies[_id];
    }

    function getCompany(
        string memory _id
    ) public view returns (AppCompany memory) {
        return s_companies[_id];
    }

    function getCompanies(
        string[] memory _ids
    ) public view returns (AppCompany[] memory) {
        AppCompany[] memory companies = new AppCompany[](_ids.length);
        for (uint i = 0; i < _ids.length; i++) {
            companies[i] = s_companies[_ids[i]];
        }
        return companies;
    }

    function getAllCompanies() public view returns (AppCompany[] memory) {
        AppCompany[] memory companies = new AppCompany[](s_compIds.length);
        for (uint i = 0; i < s_compIds.length; i++) {
            companies[i] = s_companies[s_compIds[i]];
        }
        return companies;
    }

    function getCompaniesThruLocation(
        string memory _id
    ) public view returns (AppCompany[] memory) {
        string[] memory ids = s_locationToCompany[_id];
        return getCompanies(ids);
    }
}
