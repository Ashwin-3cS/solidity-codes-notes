// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExampleContract {
    address public owner;
    uint256 public balance;

    constructor() {
        // Set the owner to the account deploying the contract
        owner = msg.sender;
        //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 => owner
        //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    }

    //internal
    // Function to deposit funds
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balance += msg.value; //balance ++
    }

    // Function to withdraw funds
    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        require(amount <= balance, "Insufficient balance");
        balance -= amount;

        // Transfer the amount to the owner
        payable(owner).transfer(amount);
    }

    // Function to check contract's balance
    function getBalance() private view returns (uint256) {
        return address(this).balance;
    }
}
