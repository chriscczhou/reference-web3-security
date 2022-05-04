# Smart Contracts notes
Personal notes about Smart Contract development, especially on a security point of view

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
- Vulnerabilities
- [Tools](https://github.com/seeu-inspace/reference-smart-contracts/blob/main/notes/tools.md)

## Resources

List of various resources to learn

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
