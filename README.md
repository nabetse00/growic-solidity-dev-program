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
-  Structs
- Result 100%

### Quiz 3 comments
- easy
- Some previous knowledge is needed
- Diferences between record/data not in original doc




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


[task 3 contract](./task3-structs/task3Contract.sol)