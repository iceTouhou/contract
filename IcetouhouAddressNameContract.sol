// SPDX-License-Identifier: ICETOUHOU-code
pragma solidity ^0.8.0;

contract IcetouhouAddressNameContract {
    
    mapping (address => string) public addressesNames;
    
    event SetName(address operator, string name);
    
    function setName(string memory name) public returns(string memory){
        addressesNames[msg.sender] = name;
        emit SetName(msg.sender,name);
        return addressesNames[msg.sender];
    }
    
    function getName() public view returns (string memory){
        return addressesNames[msg.sender];
    }
    
    function getNameByAddress(address target) public view returns (string memory) {
        return addressesNames[target];
    } 
}
