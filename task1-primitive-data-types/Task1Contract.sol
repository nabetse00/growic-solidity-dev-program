pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

// custom errors

/// Already Registered student error
/// @param addr studentID as eth address
/// @param owner owner address
error AlreadyRegistered(address addr, address owner);

/// Contract
contract Task1Contract {
    struct Student {
        address studentID;
        uint256 percentage;
        uint256 total_marks;
        // more ?
    }

    address public owner; //should be private ....

    // maps addr to student info
    mapping(address => Student) addr_to_student;

    // get fct
    function getStudentFromAddr(address _addr)
        private
        view
        returns (Student memory)
    {
        return addr_to_student[_addr];
    }

    // set fct
    function setStudentFromAddr(address _addr, Student memory _student)
        private
    {
        addr_to_student[_addr] = _student;
    }

    // remove fct
    function removeStudentFromAddr(address _addr) private {
        delete addr_to_student[_addr];
    }

    // view student
    function getStudentDetails(address studentID)
        public
        view
        returns (Student memory)
    {
        return getStudentFromAddr(studentID);
    }

    function register(
        address _studentID,
        uint256 _percentage,
        uint256 _total_marks
    ) public onlyOwner cannotRegisterTwice(_studentID) {
        Student memory _my_student = Student(
            _studentID,
            _percentage,
            _total_marks
        );
        setStudentFromAddr(_studentID, _my_student);
    }

    // modifier onlyOwner
    modifier onlyOwner() {
        require(msg.sender == owner, "Sender isn't the owner");
        _;
    }

    // modifier Make sure that student cannot register twice
    modifier cannotRegisterTwice(address _addr) {
        if (getStudentFromAddr(_addr).studentID != address(0)) {
            revert AlreadyRegistered({addr: _addr, owner: owner});
        }
        console.log("not duplicated register");
        _;
    }

    constructor() payable {
        console.log("Construtor from %s", msg.sender);
        // ensure owner is sender addr modified by transfer Ownership
        owner = msg.sender;
        console.log("constructor DONE");
    }

    // deploy addr should be directly the owner
    // function is here just to acomodate scaffold-eth
    function transferOwnership(address _addr) public onlyOwner {
        console.log("Changing Owner from %s to %s", owner, _addr);
        owner = _addr;
        console.log("DONE");
    }

    // to support receiving ETH by default
    receive() external payable {}

    fallback() external payable {}
}