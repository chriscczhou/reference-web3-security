// SPDX-License-Identifier: MIT
// an example of a smart contract (sc) for a lottery system written in solidity

pragma solidity ^0.8.11;

contract Lottery {

    address public owner; // owner address
    address payable[] public players; // list of players, payable > means that can receive ether

    // this will save the address that deployed the sc as the owner
    constructor() {
        owner = msg.sender;
    }

    // this modifier will allow us to implement onlyOwner for a function
    // meaning that only the owner of the smart contract can call it
    modifier OnlyOwner(){
        require(msg.sender == owner);
        _;
    }

    // in the context of a function, the address is the one that called that function
    // so it's different from the constructor
    function enter() public payable {

        require (msg.value > .01 ether); // this enforce the user to pay .01 ether to join the lottery

        players.push(payable(msg.sender)); // it insert the address of the players into the array
                                           // it need to be casted payble since the address may not be payable
        
    }

    function getRandomNumber() public view returns (uint){
        
    }

    // this function kill the smart contract
    //it withdrawals all the funds of the sc and makes it unusable
    function kill() public OnlyOwner{
		selfdestruct(msg.sender);
    }

}