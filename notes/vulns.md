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
