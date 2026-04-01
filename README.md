# Decentralized Escrow (Multisig-based)

A professional-grade implementation of a trustless escrow service. This repository facilitates secure trade between two parties by locking funds in a smart contract that requires a majority of signatures (e.g., Buyer + Seller, or Buyer + Arbiter) to release.

## Core Features
* **Threshold Signatures:** Flexible $M$ of $N$ logic (e.g., 2-of-3).
* **Arbiter Role:** A neutral third party can resolve disputes if the Buyer and Seller disagree.
* **Timeout Protection:** Automated refund logic if the transaction is abandoned for too long.
* **Flat Structure:** Single-directory layout for the Escrow contract and the signature verification utility.

## Workflow
1. **Deposit:** Buyer locks 10 ETH in the Escrow.
2. **Delivery:** Seller provides the service/product.
3. **Release:** - Option A: Buyer and Seller both sign (Happy Path).
   - Option B: Arbiter and Seller sign (Resolved Dispute).
   - Option C: Arbiter and Buyer sign (Refund Case).

## Setup
1. `npm install`
2. Deploy `MultisigEscrow.sol` with the addresses of the Buyer, Seller, and Arbiter.
