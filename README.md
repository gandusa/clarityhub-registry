ClarityHub-Registry Smart Contract

A decentralized on-chain registry for Clarity smart contracts on the Stacks blockchain. This contract allows developers to register, update, and query Clarity-based smart contracts in a transparent, trustless manner.

---

 Project Overview

The **ClarityHub-Registry** provides a decentralized solution for managing Clarity smart contract metadata on Stacks. It serves as a public directory where contract owners can register their deployed contracts, update information, and allow others to discover them easily.

---

 Contract Features

- **Register Contracts:**  
  Register deployed smart contracts with name, description, and contract address.

- **Update Contracts:**  
  Allow contract owners to update their contract metadata at any time.

- **Query Contracts:**  
  Publicly accessible contract data via read-only functions.

- **Remove Contracts:**  
  Contract owners can delete their registry entries.

- **Ownership Enforcement:**  
  Only the address that registered the contract can modify or delete it.

---

 Functions

 Public Functions

| Function | Description |
| -------- | ----------- |
| `register-contract (name, description, contract-address)` | Register a new contract |
| `update-contract (name, description)` | Update metadata of registered contract |
| `remove-contract ()` | Remove registered contract |
| `get-contract-info (owner)` | Query contract info for a registered address |

---

 Deployment

1. Install [Clarinet](https://docs.hiro.so/clarinet/get-started) if you haven't.
2. Clone this repository.
3. Deploy the smart contract locally using:
    ```bash
    clarinet console
    ```
4. Interact with the contract using Clarinet console commands or your own Stacks wallet.

---

