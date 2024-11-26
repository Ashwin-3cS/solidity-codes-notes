# Lesson 1:

`contract HelloWorld {

}`

- A `contract` is the fundamental building block of Ethereum applications — all variables and functions belong to a contract, and this will be the starting point of all your projects.

`pragma solidity >=0.5.0 <0.6.0;`

- Compiler version

`// SPDX-License-Identifier: MIT`

- Set of Rules that the code is gonna follow is provided by this license for this language.

# State Variables

**_State variables_** are permanently stored in contract storage. This means they're written to the Ethereum blockchain. Think of them like writing to a DB.

`##### Example:

```
contract Example {
  // This will be stored permanently in the blockchain
  uint myUnsignedInteger = 100;
}
```

In this example contract, we created a `uint` called `myUnsignedInteger` and set it equal to 100.

- Unsigned => positive values
- Signed => both positive and negative values

- **`uint8`**: Stores only small positive integers, ranging from `0` to `255` (8 bits).
- **`uint32`**: Stores larger positive integers, ranging from `0` to `4,294,967,295` (32 bits).
- **`uint256`**: Stores the largest range of positive integers, from `0` to a gigantic number (`2^256 - 1`).

# Math operators in solidity

- Addition: `x + y`
- Subtraction: `x - y`,
- Multiplication: `x * y`
- Division: `x / y`
- Modulus / remainder: `x % y` *(for example, `13 % 5` is `3`, because if you divide 13 into 5, 3 is the remainder)*

Solidity also supports an **_exponential operator_** (i.e. "x to the power of y", x^y):

```
uint x = 5 ** 2; // equal to 5^2 = 25
```

# Structs

```
struct Person {
	uint age;
	string name;
}
```

- Structs allow you to create more complicated data types that have multiple properties.

# Arrays

When you want a collection of something, you can use an **_array_**. There are two types of arrays in Solidity: **_fixed_** arrays and **_dynamic_** arrays:

```
// Array with a fixed length of 2 elements:
uint[2] fixedArray;
// another fixed Array, can contain 5 strings:
string[5] stringArray;
// a dynamic Array - has no fixed size, can keep growing:
uint[] dynamicArray;

```

- You can also create an array of **_structs_**. Using the previous chapter's `Person` struct:

```
Person[] public people; //dynamic Array, we can keep adding to it
```

# Public Function

You can declare an array as `public`, and Solidity will automatically create a **_getter_** method for it. The syntax looks like:

```
Person[] public people;
```

Other contracts would then be able to read from, but not write to, this array. So this is a useful pattern for storing public data in your contract.

# Function Declaration

```
function eatHamburgers(string memory _name, uint _amount) public {

}
//Note the visibility.
```

# Working with struct and arrays

### Creating New Structs

```
struct Person {
  uint age;
  string name;
}

Person[] public people;
```

Now we're going to learn how to create new `Persons` and add them to our `people` array.

```
// create a New Person:
Person anyVar = Person(172, "ashwin");

// Add that person to the Array:
people.push(anyVar);
```

We can also combine these together and do them in one line of code to keep things clean:

```
people.push(Person(16, "Vitalik"));
```

Note that `array.push()` adds something to the **end** of the array, so the elements are in the order we added them. See the following example:

```
uint[] numbers;
numbers.push(5);
numbers.push(10);
numbers.push(15);
// The `numbers` array is now equal to [5, 10, 15]
```

# Private / Public Functions

In Solidity, functions are `public` by default. This means anyone (or any other contract) can call your contract's function and execute its code.

Obviously this isn't always desirable, and can make your contract vulnerable to attacks. Thus it's good practice to mark your functions as `private` by default, and then only make `public` the functions you want to expose to the world.

Let's look at how to declare a private function:

```
uint[] numbers;

function _addToArray(uint _number) private {
  numbers.push(_number);
}
```

This means only other functions within our contract will be able to call this function and add to the `numbers` array.

As you can see, we use the keyword `private` after the function name. And as with function parameters, it's convention to start private function names with an underscore (`_`).

## Return Values

To return a value from a function, the declaration looks like this:

```
string greeting = "What's up dog";

function sayHello() public returns (string memory) {
  return greeting;
}
```

In Solidity, the function declaration contains the type of the return value (in this case `string`).

## Function modifiers

The above function doesn't actually change state in Solidity — e.g. it doesn't change any values or write anything.

So in this case we could declare it as a **_view_** function, meaning it's only viewing the data but not modifying it:

```
function sayHello() public view returns (string memory) {
```

Solidity also contains **_pure_** functions, which means you're not even accessing any data in the app. Consider the following:

```
function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}
```

This function doesn't even read from the state of the app — its return value depends only on its function parameters. So in this case we would declare the function as **_pure_**.

- Take a example of calculator for pure function
- But for view you read the state of the blockchain

### 1. **Gas Fee**

- **Definition**: The fee paid by users to compensate miners or validators for the computational resources required to process and execute a transaction or operation on the blockchain.
- **Scope**: Refers specifically to the cost of computation and storage.
- **Units**: Measured in **gas units** and priced in the blockchain’s native cryptocurrency (e.g., Ether for Ethereum).
- **Purpose**: Encourages efficient use of blockchain resources and prevents spam.
- **Formula**: Gas Fee=Gas Units Used×Gas Price\text{Gas Fee} = \text{Gas Units Used} \times \text{Gas Price}Gas Fee=Gas Units Used×Gas Price
  - **Gas Units Used**: Amount of computational effort required for a transaction.
  - **Gas Price**: The price the user is willing to pay per unit of gas (e.g., in gwei).

**Example**:

- A smart contract operation may require `21,000` gas units.
- If the gas price is `10 gwei`, the gas fee = 21,000×10 gwei21,000 \times 10 \text{ gwei}21,000×10 gwei.

---

### 2. **Transaction Fee**

- **Definition**: The total fee paid for sending a transaction on the blockchain, which typically includes the gas fee.
- **Scope**: A broader term encompassing all fees associated with a transaction.
- **Units**: Typically denominated in the blockchain's native cryptocurrency.
- **Purpose**: Incentivizes validators to include the transaction in a block.
- **Formula**: Transaction Fee=Gas Fee+Other Fees (if applicable)\text{Transaction Fee} = \text{Gas Fee} + \text{Other Fees (if applicable)}Transaction Fee=Gas Fee+Other Fees (if applicable)
  - In most cases, the **transaction fee** is equivalent to the **gas fee** unless additional fees are specified (e.g., for priority inclusion).

**Example**:

- If a user sets a tip for miners or validators (common in Ethereum post-EIP-1559), the transaction fee could include this additional incentive.

## Typecasting

Sometimes you need to convert between data types. Take the following example:

```
uint8 a = 5;
uint b = 6;
// throws an error because a * b returns a uint, not uint8:
uint8 c = a * b;
// we have to typecast b as a uint8 to make it work:
uint8 c = a * uint8(b);
```

In the above, `a * b` returns a `uint`, but we were trying to store it as a `uint8`, which could cause potential problems. By casting it as a `uint8`, it works and the compiler won't throw an error.

# Events

**_Events_** are a way for your contract to communicate that something happened on the blockchain to your app front-end, which can be 'listening' for certain events and take action when they happen.

Example:

```
// declare the event
event IntegersAdded(uint x, uint y, uint result);

function add(uint _x, uint _y) public returns (uint) {
  uint result = _x + _y;
  // fire an event to let the app know the function was called:
  emit IntegersAdded(_x, _y, result);
  return result;
}
```

Your app front-end could then listen for the event. A JavaScript implementation would look something like:

```
YourContract.IntegersAdded(function(error, result) {
  // do something with the result
})
```

`delete` is an **operator**, not a method. It is used to **reset a variable to its default value**.
