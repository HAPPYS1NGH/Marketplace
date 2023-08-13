## Antique Marketplace Documentation

### Introduction

Welcome to the Antique Marketplace documentation. This guide provides an overview of the project, its components, and how to interact with the smart contracts.

### Overview

The Antique Marketplace is a decentralized platform for trading antique items securely and transparently. Built on the Ethereum blockchain using Solidity smart contracts, it integrates identity verification, dispute resolution, and NFT-based ownership for a seamless trading experience.


### Vision

The Antique Marketplace project aims to revolutionize the antique trade industry by providing a secure, efficient, and trust-driven platform for enthusiasts to discover, trade, and own valuable antiques. Through innovative technologies and user-centric features, the project enhances the antique trading experience and fosters a vibrant community of collectors and sellers.


### Smart Contracts

1. **Marketplace.sol**: The core contract that manages product listings, purchases, transactions, and user credibility. It integrates with external identity verification and dispute resolution mechanisms.

2. **Product.sol**: A struct defining the properties of each antique product, including its ID, seller, name, description, price, buyer, transaction status, and scam detection.

3. **ProductNFT.sol**: An ERC-721 token contract that represents ownership of antique products as NFTs. It handles minting, transferring, and burning NFTs.

### Features

1. **Identity Verification:** The project integrates with WorldCoin ID to verify users' identities, adding an extra layer of trust to the marketplace. Verified users can engage in transactions with confidence.

2. **Secure NFT Storage:** Product information is stored off-chain using nft.storage, reducing gas costs and ensuring the authenticity of NFTs representing antique items.

3. **Dispute Resolution:** Huddle01 is utilized for video conferencing-based dispute resolution. A mediator reviews evidence and makes fair decisions to resolve disputes between parties.

4. **User Credibility:** The system employs a user credibility mechanism that assigns and updates credibility points based on successful transactions and actions within the marketplace.


### Functionality

- **Listing Products**: Sellers can list antique products, providing details such as name, description, price, and a URI for NFT metadata.

- **Purchasing**: Buyers can purchase listed products using Ether. The product status is updated, and ownership is transferred upon successful purchase.

- **Transaction Completion**: After a successful purchase, the seller can complete the transaction, updating the status and increasing their credibility score.

- **Dispute Resolution**: If a transaction is disputed, mediators can intervene to resolve issues. This involves assessing evidence and making decisions that affect credibility scores.

### Usage

1. Deploy the `Marketplace.sol` contract on the Optimism layer-2 scaling solution.

2. Deploy the `ProductNFT.sol` contract for managing NFTs representing antique products.

3. Use external tools like WorldCoin ID for identity verification and Huddle01 for dispute resolution.

### Example Interaction

1. A seller lists an antique product using the `listProduct` function, providing details and minting an NFT.

2. A buyer purchases the product using Ether.

3. The buyer or seller completes the transaction using the `completeTransaction` function.

4. In case of disputes, mediators resolve issues and update credibility scores.

### Deployment
The smart contracts are deployed on the Optimism layer-2 scaling solution, utilizing Ethereum's capabilities while minimizing transaction costs and latency.

### Conclusion

The Antique Marketplace offers a secure and innovative way to trade antique items, utilizing blockchain technology, identity verification, and NFTs. By fostering trust and transparency, it transforms the world of antique trading.
Certainly, here's a basic structure for documenting your project:
