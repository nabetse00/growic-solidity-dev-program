pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

/// custom errors

/// User Doesnt Exist custom error
error UserDoesntExist();

/// Error not Owner
error NotOwner(address owner, address sender);

/// Error no Funds
error UserHasNoFunds(address userAddress);

/// Error cannot add funds
error UserCannotAddFunds(address userAddress);

/// Error AmountToSmall
error AmountToSmall();

/// Contract
contract YourContract {
    /// Owmer address
    address payable owner;
    /// Owner funds
    uint256 public ownerFunds = 0;
    /// Owner fee
    uint8 public Fee = 10;

    /// User struct
    struct User {
        string name;
        uint256 age; //unint256 for age come on! uint8 => 255 years old is enought
        // in blockchain storage is money ...
        bool canAddFunds;
    }

    /// maps addr to user
    mapping(address => User) usersMap;

    /// maps addr to balance
    mapping(address => uint256) balance;

    /// required functions
    function withdraw(address _addr) public OnlyOwner UserHasFunds(_addr) {
        ownerFunds = ownerFunds + balance[_addr];
        balance[_addr] = 0;
    }

    function addFunds(uint256 _amount)
        public
        UserCanAddFunds
        UserHasFunds(msg.sender)
        AmoutValid(_amount)
    {
        balance[msg.sender] = balance[msg.sender] + _amount - Fee;
        ownerFunds = ownerFunds + Fee;
    }

    function setUserDetails(string calldata _name, uint256 _age) public {
        usersMap[msg.sender] = User(_name, _age, false);
        emit ProfileUpdated(msg.sender);
    }

    function getUserDetail() public view returns (User memory) {
        // remove view property to be able to send from scafold ui
        console.log(
            "Adddress %s is {name: %s, age: %s}",
            msg.sender,
            usersMap[msg.sender].name,
            usersMap[msg.sender].age
        );
        return usersMap[msg.sender];
    }

    function deposit(uint256 _amount) public AmoutValid(_amount) {
        User memory _user = getUserDetail();
        // reverts if user doesnt exist
        // you have to be a registered user in order to deposit
        if (bytes(_user.name).length == 0) {
            revert UserDoesntExist();
        }

        balance[msg.sender] = balance[msg.sender] + _amount - Fee;
        //unlock addFunds
        usersMap[msg.sender].canAddFunds = true;
        emit FundsDeposited(msg.sender, _amount - Fee);
    }

    function checkBalance() public view returns (uint256) {
        // remove view property to be able to send from scafold ui
        console.log("Adddress %s has %s", msg.sender, balance[msg.sender]);
        return balance[msg.sender];
    }

    /// required Events
    event ProfileUpdated(address user);
    event FundsDeposited(address user, uint256 amount);

    constructor() payable {
        // original owner is contract creator
        owner = payable(msg.sender);
    }

    // modifiers
    modifier OnlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner({owner: owner, sender: msg.sender});
        }
        _;
    }

    modifier UserHasFunds(address _addr) {
        if (balance[_addr] == 0) {
            revert UserHasNoFunds({userAddress: _addr});
        }
        _;
    }

    modifier UserCanAddFunds() {
        if (!usersMap[msg.sender].canAddFunds) {
            revert UserCannotAddFunds({userAddress: msg.sender});
        }
        _;
    }

    modifier AmoutValid(uint256 _amount) {
        if (_amount < Fee) {
            revert AmountToSmall();
        }
        _;
    }

    // tranfer OwnerShip

    function transferOwnership(address _newOwner) public OnlyOwner {
        owner = payable(_newOwner);
    }

    // to support receiving ETH by default
    receive() external payable {}

    fallback() external payable {}
}
