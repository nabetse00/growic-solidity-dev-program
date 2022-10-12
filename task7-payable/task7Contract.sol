pragma solidity >=0.8.4 <0.9.0;

//SPDX-License-Identifier: MIT

/**
    Custom errors
*/

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
contract Task7Contract {
    /// Owmer address
    address payable owner;

    /// Owner funds are now 
    /// inside this contract balance

    /// Contract Fee 10 wei
    uint8 public constant Fee = 10;

    /// User struct
    struct User {
        string name;
        uint8 age;
        bool canAddFunds;
    }

    /// maps addr to user
    mapping(address => User) usersMap;

    /// maps addr to balance
    mapping(address => uint256) balance;

    /// required functions
    function withdraw(address _addr) public OnlyOwner UserHasFunds(_addr) {
        uint256 _amount = balance[_addr];
        balance[_addr] = 0;
        payable(owner).transfer(_amount);
    }

    function addFunds()
        public
        payable
        UserCanAddFunds
        UserHasFunds(msg.sender)
        AmoutValid(msg.value)
    {
        balance[msg.sender] = balance[msg.sender] + msg.value - Fee;
    }

    function setUserDetails(string calldata _name, uint8 _age) public {
        usersMap[msg.sender] = User(_name, _age, false);
        emit ProfileUpdated(msg.sender);
    }

    function getUserDetail() public view returns (User memory) {
        return usersMap[msg.sender];
    }

    function deposit() public payable AmoutValid(msg.value) {
        User memory _user = getUserDetail();
        if (bytes(_user.name).length == 0) {
            revert UserDoesntExist();
        }
        balance[msg.sender] = balance[msg.sender] + msg.value - Fee;
        usersMap[msg.sender].canAddFunds = true;
        emit FundsDeposited(msg.sender, msg.value - Fee);
    }

    function checkBalance() public view returns (uint256) {
        return balance[msg.sender];
    }

    /// required Events
    event ProfileUpdated(address user);
    event FundsDeposited(address user, uint256 amount);

    constructor() payable {
        owner = payable(msg.sender);
    }

    /// modifiers

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

    // to support receiving ETH by default
    receive() external payable {}

    fallback() external payable {}
}
