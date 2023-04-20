// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import ".//library/StringArray.sol";
import "../interfaces/IUser.sol";

contract Documents {
    
//   address private owner;
  Document[] private documents;
  mapping (address => Count) private counts;
  enum DocStatus {Pending, Verified, Rejected}
 
  struct Document {
    address requester;
    address verifier;
    string name;
    string description;
    string docAddress;
    DocStatus status;
  }
  
  struct Count {
    uint verified;
    uint rejected;
    uint total;
  }

      IUser user;

    constructor(address _userContract) {
        user = IUser(_userContract);
    }

  event DocumentAdded (address user);
  event DocumentVerified (address user);

  modifier docAddressExists(string memory _docAddress) 
  {
    bool found = false;
    for (uint i=0; i<documents.length; i++) {
      if (StringArray.equal(documents[i].docAddress, _docAddress)) {
          found = true;
          break; 
      }
    }
    require(!found);
    _;
  }

//   constructor() 
//   public 
//   {
//     owner = msg.sender;
//   }

  function addDocument(address _verifier, string memory _name, string memory _description, string memory _docAddress) 
  public 
  payable
  docAddressExists(_docAddress)
  {
    emit DocumentAdded(msg.sender);
    
    documents.push(
      Document({
        name: _name,
        requester: msg.sender,
        verifier: _verifier,
        description: _description,
        docAddress: _docAddress,
        status: DocStatus.Pending
      })
    );
    
    counts[msg.sender].total = counts[msg.sender].total + 1;
    counts[_verifier].total = counts[_verifier].total + 1;
  }

  function getDocument(string memory docAddress) 
  public 
  view 
  returns (string memory name, address requester, address verifier, string memory description, DocStatus status) {
    for (uint i=0; i<documents.length; i++) {
      if(StringArray.equal(documents[i].docAddress, docAddress)){
        requester = documents[i].requester;
        verifier = documents[i].verifier;
        name = documents[i].name;
        description = documents[i].description;
        status = documents[i].status;
        break;
      }
    }
    return (name, requester, verifier, description, status);
  }
  
  function getVerifierDocuments(address _verifier, uint lIndex) 
  public 
  view 
  returns (string memory name, address requester, string memory description, string memory docAddress, DocStatus status, uint index) {
    for (uint i=lIndex; i<documents.length; i++) {
      if(documents[i].verifier == _verifier){
        requester = documents[i].requester;
        name = documents[i].name;
        description = documents[i].description;
        docAddress = documents[i].docAddress;
        status = documents[i].status;
        index = i;
        break;
      }
    }
    return (name, requester, description, docAddress, status, index);
  }
   
  function getRequesterDocuments(address _requester, uint lIndex) 
  public 
  view 
  returns (string memory name, address verifier, string memory description, string memory docAddress, DocStatus status, uint index) {
    for (uint i=lIndex; i<documents.length; i++) {
      if(documents[i].requester == _requester){
        verifier = documents[i].verifier;
        name = documents[i].name;
        description = documents[i].description;
        docAddress = documents[i].docAddress;
        status = documents[i].status;
        index = i;
        break;
      }
    }
    return (name, verifier, description, docAddress, status, index);
  }
    
  function verifyDocument(string memory docAddress, DocStatus status) 
  public 
  payable
  {
    for (uint i=0; i<documents.length; i++) {
      if(StringArray.equal(documents[i].docAddress, docAddress) && documents[i].verifier == msg.sender && documents[i].status == DocStatus.Pending){
        emit DocumentVerified(msg.sender);
        if(status == DocStatus.Rejected){
            counts[documents[i].requester].rejected = counts[documents[i].requester].rejected + 1;
            counts[documents[i].verifier].rejected = counts[documents[i].verifier].rejected + 1;
        }
        if(status == DocStatus.Verified){
            counts[documents[i].requester].verified = counts[documents[i].requester].rejected + 1;
            counts[documents[i].verifier].verified = counts[documents[i].verifier].verified + 1;
        }
        documents[i].status = status;
        break;
      }
    }
  }

  function getCounts (address account) 
  public 
  view
  returns(uint verified, uint rejected, uint total) 
  {
    return (counts[account].verified, counts[account].rejected, counts[account].total);
  }
}