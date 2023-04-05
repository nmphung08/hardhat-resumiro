// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./library/UintArray.sol";

contract Company {
    struct AppCompany {
        uint id;
        uint ownerId;
        string name;
        string logo;
        string background;
        string about;
        string scale;
        string website;
        uint locationId;
        string addr;
        string introduction;
    }

    using UintArray for uint[];
    uint[] internal s_compIds;
    mapping(uint => AppCompany) internal s_companies;
    mapping(uint => uint[]) internal s_locationToCompany;
    uint internal s_companyCounter = 0;

    function addCompany(
        uint _ownerId,
        string memory _name,
        string memory _logo,
        string memory _background,
        string memory _about,
        string memory _scale,
        string memory _website,
        uint _locationId,
        string memory _addr,
        string memory _introduction
    ) public {
        uint _id = s_companyCounter;
        s_compIds.push(_id);
        s_locationToCompany[_locationId].push(_id);
        s_companies[_id] = AppCompany(
            _id,
            _ownerId,
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
        s_companyCounter++;
    }

    function updateCompany(
        uint _id,
        string memory _name,
        string memory _logo,
        string memory _background,
        string memory _about,
        string memory _scale,
        string memory _website,
        uint _locationId,
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

    function deleteCompany(uint _id) public {
        s_compIds.removeElement(_id);
        uint locationId = s_companies[_id].locationId;
        s_locationToCompany[locationId].removeElement(_id);
        delete s_companies[_id];
    }

    function getCompany(uint _id) public view returns (AppCompany memory) {
        return s_companies[_id];
    }

    function getNewestCompany() public view returns (AppCompany memory) {
        return s_companies[s_compIds.length - 1];
    }

    function getCompanies(
        uint[] memory _ids
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
        uint _id
    ) public view returns (AppCompany[] memory) {
        uint[] memory ids = s_locationToCompany[_id];
        return getCompanies(ids);
    }
}
