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
    uint256 ownerFunds = 0;
    /// Owner fee
    uint8 Fee = 10;

    /// User struct
    struct User {
        string name;
        uint256 age; //unint256 for age come on! uint8 => 255 years old is enought
        // in blockchain storage is money ...
        bool canAddFunds;
    }

    /// maps addr to user
    mapping(address => User) usersMap;

    // get
    function getUser(address _addr) private view returns (User memory) {
        if (usersMap[_addr].age == 0) {
            // age easier  to check than name since its a string
            console.log("User doesn t exist");
            revert UserDoesntExist();
        }
        User memory _user = usersMap[_addr];
        console.log(
            "User Found: {name: %s, age: %s} for address: %s",
            _user.name,
            _user.age,
            _addr
        );
        console.log("Can add funds: %s", _user.canAddFunds);
        return _user;
    }

    // set
    function setUser(address _addr, User memory _user) private {
        usersMap[_addr] = _user;
        console.log(
            "Added user: {name: %s, age: %s, addFundsLock: %s }",
            _user.name,
            _user.age,
            _user.canAddFunds
        );
        // console.log accepts 4 parameters max
        console.log("User address is %s", _addr);
    }

    // delete
    function deleteUser(address _addr) private {
        delete usersMap[_addr];
        console.log("Delete user at address %s", _addr);
    }

    /// maps addr to balance
    mapping(address => uint256) balance;

    // get
    function getBalance(address _addr) private view returns (uint) {
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

    function withdraw(address _addr) public OnlyOwner UserHasFunds(_addr) {
        ownerFunds = ownerFunds + balance[_addr];
        setBalance(_addr, 0);
    }

    function addFunds(uint256 _amount)
        public
        UserCanAddFunds
        UserHasFunds(msg.sender)
        AmoutValid(_amount)
    {
        setBalance(msg.sender, getBalance(msg.sender) + _amount - Fee);
        ownerFunds = ownerFunds + Fee;
    }

    function setUserDetails(string calldata _name, uint256 _age) public {
        User memory _user = User(_name, _age, false);
        setUser(msg.sender, _user);
    }

    function getUserDetail() public view returns (User memory) {
        // remove view property to be able to send from scafold ui
        return getUser(msg.sender);
    }

    function deposit(uint256 _amount) public AmoutValid(_amount) {
        getUserDetail(); // reverts if user doesnt exist
        // you have to be a registered user in order to deposit
        setBalance(msg.sender, _amount + getBalance(msg.sender) - Fee);
        //unlock addFunds
        usersMap[msg.sender].canAddFunds = true;
    }

    function checkBalance() public view returns (uint256) {
        // remove view property to be able to send from scafold ui
        return getBalance(msg.sender);
    }

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
