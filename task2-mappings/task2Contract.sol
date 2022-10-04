pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

// custom errors

/// Contract
contract YourContract {

    //owmer
    address payable owner;

    // maps addr to balance 
    mapping(address => uint256) balance;

    //get     
    function getBalance(address _addr) private view returns (uint){
        uint256 _amount = balance[_addr];
        console.log("addr %s balance %s ", _addr, _amount);
        return _amount;
    }

    //set 
    function setBalance(address _addr, uint256 _amount) private {
        balance[_addr] = _amount;
        console.log("Balance set to %s for addr %s", _amount, _addr);
    }

    //delete
    function deleteBalance(address _addr) private {
        delete balance[_addr];
        console.log("Deleted %s", _addr);
    }

    // required functions 
    function deposit(uint256 _amount) public {
        return setBalance(msg.sender, _amount + getBalance(msg.sender) );
    }

    function checkBalance() public view returns (uint256) { 
        // remove view property to be able to send from scafold ui
        return getBalance(msg.sender);
    }


    constructor() payable {
        // original owner is contract creator
        owner =  payable(msg.sender);
    }


    // to support receiving ETH by default
    receive() external payable {}

    fallback() external payable {}
}