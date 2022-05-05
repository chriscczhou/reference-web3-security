# Web3 security notes
Personal notes about Web3 on a security point of view

**ToDo**
- Creare un progetto funzionante in solidity
- Creare un progetto funzionante in Vyper
- Creare un progetto NFT
- Completare le sezioni delle note > Pubblicare una volta che ho finito di trascrivere le note prese in precedenza

**Index**
- [Resources](#Resources)
- [Introduction](#Introduction)
- Development
- Security
- [Vulnerabilities](https://github.com/seeu-inspace/reference-smart-contracts/blob/main/notes/vulns.md)
  - Human errors
  - Batch Overflow
  - Reentrancy Vulnerabilities
  - Authorization issues
  - Use of components with known vulnerabilities
- [Tools](#tools)

## Resources

### Solidity

- https://cryptozombies.io/
- https://www.youtube.com/channel/UCJWh7F3AFyQ_x01VKzr9eyA/videos
- https://github.com/ethereumbook/ethereumbook
- https://www.youtube.com/watch?v=HR679xTt8tg

### Smart Contract Security
- https://consensys.github.io/smart-contract-best-practices/
- https://github.com/ethereumbook/ethereumbook/blob/develop/09smart-contracts-security.asciidfoc
- https://www.youtube.com/playlist?list=PLdJRkA9gCKOONBSlcifqLig_ZTyG_YLqz
- https://github.com/OpenZeppelin/openzeppelin-contracts
- https://arxiv.org/pdf/2008.04761.pdf
- https://ethereum.org/en/developers/docs/smart-contracts/security/
- https://consensys.github.io/smart-contract-best-practices/

### Blockchain Penetration Testing
- https://dasp.co/
- https://blog.positive.com/predicting-random-numbers-in-ethereum-smart-contracts-e5358c6b8620
- https://www.youtube.com/playlist?list=PLCwnLq3tOElpIi6Gci36PnvrrS8ljBHkq
- https://www.youtube.com/watch?v=P8LXLoTUJ5g
- https://www.youtube.com/watch?v=WIEessi3ntk
- https://www.youtube.com/watch?v=bTPouSkrhIM
- https://www.youtube.com/watch?v=BZXv3kUygNU
- https://published-prd.lanyonevents.com/published/rsaus19/sessionsFiles/14118/HT-F02_Advanced-Smart-Contract-Hacking-FINAL.pdf > https://www.youtube.com/watch?v=IOUnhCTw6tE
- https://medium.com/@JusDev1988/reentrancy-attack-on-a-smart-contract-677eae1300f2
- https://github.com/smartdec/classification
- https://www.shielder.com/blog/2022/04/a-sneak-peek-into-smart-contracts-reversing-and-emulation/
- https://medium.com/immunefi/hacking-the-blockchain-an-ultimate-guide-4f34b33c6e8b

### Laboratories
- https://www.damnvulnerabledefi.xyz/
- https://gitlab.com/badbounty/dvcw
- https://ethernaut.openzeppelin.com/
- https://ctf.paradigm.xyz/
- https://github.com/tinchoabbate/defcon28-talk-challenge
- https://github.com/blockthreat/blocksec-ctfs

### Exploitation examples
- https://github.com/openzeppelin/exploit-uniswap
- https://github.com/tinchoabbate/function-clashing-poc
- https://blog.openzeppelin.com/backdooring-gnosis-safe-multisig-wallets/
- https://blog.openzeppelin.com/security-audits/

### Bug Bounty
- https://immunefi.medium.com/
- https://medium.com/immunefi/how-robert-forster-of-armor-finds-big-bugs-36656ab7b82c

## Introduction

The **Blockchain** is a set of technologies in which the ledger is structured as a chain of blocks containing transactions and consensus distributed on all nodes of the network. All nodes can participate in the validation process of transactions to be included in the ledger.

There are two types of operations that are carried out to create a cryptocurrency:
- **Mining (Proof-of-Work)** Validation of transactions through the resolution of mathematical problems by miners who use hardware and software dedicated to these operations. Whoever solves the problem first wins the right to add a new block of transactions and a reward;
- **Staking (Proof-of-Staking)** consists of users who lock their tokens in a node called a validator. The validators take turns checking the transactions on the network. If they perform well, they receive a prize distributed among all the participants of the validator, otherwise, they receive a penalty.

**Ethereum** is a blockchain that has popularized an incredible innovation: smart contracts, which are a program or collection of code and data that reside and function in a specific address on the network. Thanks to this factor, it is defined as a "programmable blockchain".

A token can be created with a smart contract. Most of them reside in the ERC20 category, which is fungible tokens. Other tokens are ERC-721 and ERC-1155, aka NFTs.

A **decentralized application**, also known as **DApp**, differs from other applications in that, instead of relying on a server, it uses blockchain technology. To fully interact with a DApp you need a wallet.
DApps are developed both with a user-friendly interface, such as a web, mobile or even desktop app, and with a smart contract on the blockchain. The fact that there is a user-friendly interface means that the "old vulnerabilities" can still be found. An example: If a DApp has a web interface, maybe an [XSS](https://owasp.org/www-community/attacks/xss/) on it can be found and exploited.

The source code of the Smart Contracts is often written in **Solidity**, an object-oriented programming language. Another widely used programming language, but less than Solidity, is **Vyper**, very similar to Python.

Most of the time the smart contract code is found public in a github such as `github.com/org/project/contracts/*.sol` or you can get it from Etherscan, for example by going to the contract address (such as that of the DAI token), in the Contract tab you will find the code https://etherscan.io/address/0x6b175474e89094c44da98b954eedeac495271d0f#code and contract ABI> un json which indicates how the functions of the smart contract are called.
In any case, the source is almost always public. If it's not public, you can use an EVM bytecode decompiler such as https://ethervm.io/decompiler, just enter the contract address here.

## Tools

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
