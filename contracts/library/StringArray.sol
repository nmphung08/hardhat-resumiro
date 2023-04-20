// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library StringArray {
    function remove(string[] storage _arr, uint _i) internal {
        string memory temp = _arr[_arr.length - 1];
        _arr[_arr.length - 1] = _arr[_i];
        _arr[_i] = temp;
        _arr.pop();
    }

    function removeElement(string[] storage _arr, string memory _e) internal {
        for (uint i = 0; i < _arr.length; i++) {
            if (keccak256(bytes(_arr[i])) == keccak256(bytes(_e))) {
                remove(_arr, i);
                break;
            }
        }
    }

    function isElementExisted(string[] storage _arr, string memory _e) internal view returns (bool) {
        for (uint i = 0; i < _arr.length; i++) {
            if (keccak256(bytes(_arr[i])) == keccak256(bytes(_e))) {
                return true;
            }
            return false;
        }
    }

    function isElementExistedMemory(string[] memory _arr, string memory _e) internal pure returns (bool) {
        for (uint i = 0; i < _arr.length; i++) {
            if (keccak256(bytes(_arr[i])) == keccak256(bytes(_e))) {
                return true;
            }
            return false;
        }
    }

    function compare(string memory _a, string memory _b) public pure returns (int) {
      bytes memory a = bytes(_a);
      bytes memory b = bytes(_b);
      uint minLength = a.length;
      if (b.length < minLength) minLength = b.length;
      //@todo unroll the loop into increments of 32 and do full 32 byte comparisons
      for (uint i = 0; i < minLength; i ++)
        if (a[i] < b[i])
          return -1;
        else if (a[i] > b[i])
          return 1;
      if (a.length < b.length)
        return -1;
      else if (a.length > b.length)
        return 1;
      else
        return 0;
  }
  /// @dev Compares two strings and returns true iff they are equal.
  function equal(string memory _a, string memory _b) public pure returns (bool) {
      return compare(_a, _b) == 0;
  }
  /// @dev Finds the index of the first occurrence of _needle in _haystack
  function indexOf(string memory _haystack, string memory _needle) public pure returns (int)
  {
    bytes memory h = bytes(_haystack);
    bytes memory n = bytes(_needle);
    if(h.length < 1 || n.length < 1 || (n.length > h.length)) 
      return -1;
    // since we have to be able to return -1 (if the char isn't found or input error), 
    // this function must return an "int" type with a max length of (2^128 - 1)
    else if(h.length > (2**128 -1)) 
      return -1;                                  
    else
    {
      uint subindex = 0;
      for (uint i = 0; i < h.length; i ++)
      {
        if (h[i] == n[0]) // found the first char of b
        {
          subindex = 1;
          // search until the chars don't match or until we reach the end of a or b
          while(subindex < n.length && (i + subindex) < h.length && h[i + subindex] == n[subindex]) 
          {
            subindex++;
          }   
          if(subindex == n.length)
            return int(i);
        }
      }
      return -1;
    }   
  }
}
