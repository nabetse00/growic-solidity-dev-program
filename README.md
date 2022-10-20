# Solidity Developer Program October [Eth Miami]

Repo for program tasks and quizs

## Quizs

### Quiz 1
- Primitive Data Types
- Result 100%
### Quiz 1 comments
- Some previous knowledge is needed
- Original document do not explains diferences between storage/memory/calldata
- global variables should be listed

### Quiz 2
- Mapping
- Result 100%
### Quiz 2 comments
- Some previous knowledge is needed
- Original document doesn't explain mapping limitations
- Question 5 (The key type for a mapping needs to be a built in value type (string or bytes))
   can be miss leading (other types are allowed beside srtring or bytes ... )

### Quiz 3
- Structs
- Result 100%

### Quiz 3 comments
- easy
- Some previous knowledge is needed
- Diferences between record/data not in original doc

### Quiz 4
- Modifiers
- Result 100%

### Quiz 4 comments
- Easy
- All info in doc

### Quiz 5
- Events
- Result 100%

### Quiz 5 comments
- Not all info in Events doc
- ~~ Question 5 is wrong ? ~~ corrected by now

### Quiz 6
- Inheritance
- Result 100%

### Quiz 6 comments
- Easy
- All info in doc

### Quiz 7
- Payable
- Result 100%

### Quiz 7 comments
- Easy
- All info in doc

### Quiz 8
- Fallback
- Result 100%

### Quiz 8 comments
- All info in doc



## Tasks 

### Task 1: Primitive Data Types

#### Description
Perform the task and share the link to your github in the field below.

#### Instructions
Create a smart contract for registering the details of a student with their StudentID(Ethereum Address) and to get the details based on their Student ID and they can be added only by the contract deployed address. Also, check whether the studentID data already exists. Also, have a function to view the Details of student based on their studentID including percentage and Total Marks.

State variables:

- [x]   Make owner a state variable with value type address and make it public
- [x]  Have a mapping of address to students, you can give the mapping any name of your choice
- [x]  Have a constructor that ensures that owner is equal to the msg.sender
- [x]  Make use of a custom error if wish to
- [x]  Have a modifier called onlyOwner and require that msg.sender = owner
- [x]  Have a struct to contain details of students
- [x]  Make sure that student cannot register twice
- [x]  Have a function to get student details and it accepts one argument
- [x]  Have a function to register students and it should be onlyOwner
- [x]  function register(address studentID) then add all the rest details of the s [] tudent from your struct to the argument of this function
- [x]  function getStudentDetails(address studentID)

#### Answer

[task 1 contract](/task1-primitive-data-types/Task1Contract.sol)

#### Comments

- not clear if constructor part is a require or just setting owner value.
- not clear what to do with register function. Maybe writing register(address studentID, args ...) is better.
- "Make use of a custom error if wish to" should be in a optional requirement part.

### task 2: Mappings

#### Description
Perform the task and share the link to your github in the field below.

#### Instructions
Create a smart contract that saves user balance. The contract should have the functions:

- [x] deposit (uint256 amount) this function accepts one argument and it saves the amount a user is depositing into a mapping,
- [x] checkBalance() this function searches for the user balance inside the balance mapping and returns the balance of whoever is calling the contract.

#### Answer
[task 2 contract](./task2-mappings/task2Contract.sol)

#### Comments
- Maybe be more explicit. Explain that the address for function must be sender address.

### task 3:  Structs

#### Description
You must complete the task from the 'Mapping' topic before you begin this one.
Perform the task and share the link to your github in the field below.

#### Instructions
This task extends the functionality of the previous contract by allowing users to save their additional info into the smart contract as a KYC measure.

The contract should now contain the following:

- [x] setUserDetails(string calldata name, uint256 age) this function accepts 2 arguments that represent the details of the user calling the smart contract and it saves them into a defined struct,
- [x] getUserDetail() this function retrieves and returns the details saved for the user calling the contract.


#### Answer
[task 3 contract](./task3-structs/task3Contract.sol)

### Task 4: Modifiers

#### Description
You must complete the tasks from the 'Mapping' and 'Structs' topics before you begin this assignment.
Perform the task and share the link to your github in the field below.

#### Instructions
This task extends the functionality of the previous task. Create a deposit function that allows anybody to send funds. Store the user and the amount in a mapping as the previous task.

- [x] Add a withdraw function and create a modifier that only allows the owner of the contract to withdraw the funds.
- [x] Add an addFund function and create a modifier that only allows users that have deposited using the deposit function, to increase their balance on the mapping. The function should accept the amount to be added and update the mapping to have the new balance
- Hint: if their balance is zero on the mapping, it should revert
- Hint: theMapping[userId] = theMapping[userId] + _amount;

- [x] Create a modifier that accepts a value(uint256 _amount):
- [x] Create a private constant variable called Fee
- [x] In the modifier check if the value(_amount) it accepts is less than the Fee, revert with a custom error AmountToSmall()
- [x] Add it to the addFund function
- Hint: addFund(uint256 _amount)..........

#### Answer
[task 4 constract](./task4-modifiers/task4Contract.sol)

### Task 5 

#### Description
You must complete the tasks from the previous topics before you begin this assignment.
Perform the task and share the link to your github in the field below.

#### Instructions
Extend the previous task to use blockchain events. The contact should emit the following events when a user deposits and updates their profile information respectively:

- [x] FundsDeposited(address user, uin256 amount)
- [x] ProfileUpdated(address user)

#### Answer
[task 5 contract](./task5-events/task5Contract.sol)

### Task 6 Inheritance

#### Description
You must complete the tasks from the previous topics before you begin this assignment.
Perform the task and share the link to your github in the field below.

#### Instructions
A simple use case for inheritance is to launch an ERC20 token using the OpenZepellin ERC20 implementation. 
Try to launch your custom ERC20 on any test network and then send me the address to the contract!

[x] import OpenZepellin ERC20
[x] deploy to test network

#### Answer
[task 6 contract](./task6-Inheritance/task6Contract.sol)
[etherscan url](https://goerli.etherscan.io/tx/0xed78f17ccd66e02e9d2ebf7a0e8741bedfeccdd9e2926f5ae1a41799e8d6bc2a)

### Task 7 Payable

#### Description
You must complete the tasks from the previous topics before you begin this assignment.
Perform the task and share the link to your github in the field below.

#### Instructions
In this task, we will re-write the deposit function from the ‘Mappings’ topic. We will allow users to send real ETH deposits to our smart contract by adding a payable function. Function deposit will be re-written to accept no arguments but receive real ETH deposits and still save and update user balance.

- [x] deposit() accepts ETH through the payable modifier and updates user balance accordingly

#### Answer
[task 7 contract](./task7-payable/task7Contract.sol)

### Task 8 Fallback

#### Description
You must complete the tasks from the previous topics before you begin this assignment.
Perform the task and share the link to your github in the field below.

#### Instructions
To ensure that our smart contract can receive ETH sent to it via transfers, we will create a fallback or receive payable function. The task is to create the fallback function and make sure when a user transfers ETH to the smart contract, the transaction does not get reverted

#### Answer

[task 8 contract](./task8-fallback/task8Contract.sol)