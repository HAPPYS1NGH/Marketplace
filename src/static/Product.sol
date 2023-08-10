// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

struct Product {
    uint256 id;
    address seller;
    string name;
    string description;
    uint256 price;
    address buyer;
    bool isSold;
    bool isComplete;
    bool scam;
}
