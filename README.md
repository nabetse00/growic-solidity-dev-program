# Solidity Developer Program October [Eth Miami]

Repo for program tasks

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

[github file](/README.md)

#### Comments

- not clear if constructor part is a require or just setting owner value.
- not clear what to do with register function. Maybe writing register(address studentID, args ...) is better.
- "Make use of a custom error if wish to" should be in a optional requirement part.