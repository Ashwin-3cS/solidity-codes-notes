// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Sandwich {
    uint internal sandwichesEaten = 0;

    //2

    function eat() internal {
        sandwichesEaten++;
    }
}

contract BLT is Sandwich {
    uint private baconSandwichesEaten = 0;

    //2

    function eatWithBacon() public returns (string memory) {
        baconSandwichesEaten++;
        // We can call this here because it's internal
        eat();
    }

    function getBaconAmount() public view returns (uint256) {
        return baconSandwichesEaten;
    }

    function getSandwichAmount() public view returns (uint256) {
        return sandwichesEaten;
    }
}
