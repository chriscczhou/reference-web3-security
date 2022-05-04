# Tools

### Metamask

Metamask is an application available as an extension for browsers such as Firefox and Google Chrome or even as a mobile app.

It allows you to create a wallet for cryptocurrencies. It can be very useful to use a decentralized application.

To install Metamask go here, and follow the instructions> https://metamask.io/

To connect to a decentralized app (or DApp) the process is often the same for all applications. An example is UniSwap: unlock the Metamask application, press the Connect Wallet button and select Metamask.

![UniSwap](https://raw.githubusercontent.com/seeu-inspace/reference-smart-contracts/main/notes/Immagine%202022-05-04%20211419.png?token=GHSAT0AAAAAABT7ATKXKOW2HXNDHLVQBB6QYTS2H2Q)

### Etherscan.io

Etherscan.io is the primary reference tool for exploring the Ethereum blockchain.

In a page of a Contract: 
- In Contract Overview you can see the balance in the contract and the balance of Ethereum;
- In More Info we can see the address of the wallet that created the contract and with which transaction. Lastly, the token tracker;
- Below you can see the transactions with method (=> what was done in that transaction), also divided by the various ERC20 tokens and Analytics;
- Another tab is "Contract", where you can see the code of the smart contract, ABI and EVM Bytecode

For other types of addresses (wallet and token tracker) there aren't other relevant details.

### remix.ethereum.org

An IDE that provides a compiler, debugger, and various test accounts with some $ETH for each. This is very useful for testing functions without impacting the real Smart Contract target of the tests.

### Infura.io

A very useful tool used by most decentralized apps for backend development of apps on Ethereum. It allows you to easily interact with a node on Ethereum or with IPFS. The most useful tool is especially Infura API.

Once registered in https://infuria.io, go to https://infuria.io/dashboard, click 'Create New Project' at the top right. Once created, you will find yourself in the project settings. In 'Keys' you will see the endpoints to connect to a node on the Ethereum network.

### Ganache

To have a local test node you can use a program called ganache. To install it: `npm install -g ganache-cli`. To run it: `ganache-cli`

### web3.js

web3.js is very useful for interacting with a smart contract and its APIs. Install it by using the command `npm install web3`.

To use it and interact with a contract, use the following commands:
- `node`;
- `const Web3 = require('web3')`;
- `const URL = "http://localhost:8545"`. This is the URL where the contract is deployed, insert the url from Infura.io or Ganache;
- `const web3 = new Web3(URL)`;
- `accounts = web3.eth.getAccounts();`
- `var account`;
- `accounts.then((v) => {(this.account = v[1])})`;
- `const address = "<CONTRACT_ADDRESS>"`. Copy and paste the Contract Address;
- `const abi = <ABI>`. Copy and paste the ABI of the Smart Contract;
- `const contract = new web3.eth.Contract(abi, address)`.

Now you will be able to call the functions from web3.js
