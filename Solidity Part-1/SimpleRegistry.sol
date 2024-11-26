// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract SimpleRegistry {
    // State variable to store the owner's address
    address public owner;
    //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

    // Struct to store user information
    struct User {
        string name;
        uint age;
    }

    // Array to hold all registered users
    User[] public users;

    // Event to signal a new user registration
    event UserRegistered(string name, uint age);

    // Function to set the contract owner (only once)
    function setOwner() public {
        require(owner == address(0), "Owner is already set."); // Only allow setting the owner once
        owner = msg.sender;
    }

    // Public function to add a new user
    function registerUser(string memory _name, uint _age) public {
        // Create a new User struct and add it to the users array
        users.push(User(_name, _age));

        // Emit the UserRegistered event
        emit UserRegistered(_name, _age);
    }

    // Public view function to get the total number of users
    function getUserCount() public view returns (uint) {
        return users.length;
    }

    // Private helper function to check if the sender is the owner
    function isOwner() private view returns (bool) {
        return msg.sender == owner;
        //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 == owner
    }

    //  0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

    // Public function to clear the users array (only the owner can call this)
    function clearUsers() public {
        require(isOwner(), "Only the owner can clear the users list.");
        delete users; // Clears the array
    }
}
