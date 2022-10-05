pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

/// custom errors

/// User Doesnt Exist custom error
error UserDoesntExist();

/// Contract
contract YourContract {

    //owmer
    address payable owner;

    /// User struct
    struct User {
        string name;
        uint256 age; //unint256 for age come on! uint8 => 255 years old is enought
        // in blockchain storage is money ...
    }

    /// maps addr to user
    mapping(address => User) usersMap;
    
    // get
    function getUser(address _addr) private view returns (User memory) {
        
        if( usersMap[_addr].age == 0 ){ 
            // age easier  to check than name since its a string
            console.log("User doesn t exist");
            revert UserDoesntExist();
        }
        User memory _user = usersMap[_addr];
        console.log("User Found: {name: %s, age: %s} for address: %s", _user.name, _user.age, _addr);
        return _user;
    }

    // set
    function setUser(address _addr, User memory _user) private {
        usersMap[_addr] = _user;
        console.log("Added user: {name: %s, age: %s} for address: %s", _user.name, _user.age, _addr);
    }
    
    // delete
    function deleteUser(address _addr) private {
        delete usersMap[_addr];
        console.log("Delete user at address %s", _addr);
    }


    /// maps addr to balance 
    mapping(address => uint256) balance;

    // get     
    function getBalance(address _addr) private view returns (uint){
        uint256 _amount = balance[_addr];
        console.log("addr %s balance %s ", _addr, _amount);
        return _amount;
    }

    // set 
    function setBalance(address _addr, uint256 _amount) private {
        balance[_addr] = _amount;
        console.log("Balance set to %s for addr %s", _amount, _addr);
    }

    // delete
    function deleteBalance(address _addr) private {
        delete balance[_addr];
        console.log("Deleted %s", _addr);
    }

    /// required functions 

    function setUserDetails(string calldata _name, uint256 _age) public {
        User memory _user = User(_name, _age);
        setUser(msg.sender, _user);
    }

    function getUserDetail() public view returns (User memory) {
        // remove view property to be able to send from scafold ui
        return getUser(msg.sender);
    }

    function deposit(uint256 _amount) public {
        getUserDetail(); // reverts if user doesnt exist
        // you have to be a registered user in order to deposit
        return setBalance(msg.sender, _amount + getBalance(msg.sender) );
    }

    function checkBalance() public  view returns (uint256) { 
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