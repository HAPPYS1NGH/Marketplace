// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Product} from "../static/Product.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";
import {ProductNFT} from "../helpers/ProductNFT.sol";

contract Marketplace {
    address public owner;
    ProductNFT public productNFT;
    mapping(uint256 => Product) public products;

    using Counters for Counters.Counter;

    Counters.Counter private _productCounterId;

    mapping(address => int256) public userCredibility;

    event ProductListed(uint256 indexed productId, address indexed seller);
    event ProductSold(uint256 indexed productId, address indexed buyer);
    event TransactionFailed(uint256 indexed productId, address indexed buyer);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
        productNFT = new ProductNFT();
    }

    function listProduct(string memory _name, string memory _description, uint256 _price, string memory uri) external {
        require(_price > 0, "Price must be greater than 0");
        uint256 tokenId = _productCounterId.current();
        _productCounterId.increment();
        products[tokenId] = Product(tokenId, msg.sender, _name, _description, _price, address(0), false, false, false);
        productNFT.safeMint(msg.sender, uri);
        emit ProductListed(tokenId, msg.sender);
    }

    function purchaseProduct(uint256 _productId) external payable {
        Product storage product = products[_productId];
        require(product.seller != address(0), "Product does not exist");
        require(!product.isSold, "Product is already sold");
        require(msg.value >= product.price, "Insufficient funds");

        // Update product status
        product.isSold = true;
        product.buyer = msg.sender;

        emit ProductSold(_productId, msg.sender);
    }

    function completeTransaction(uint256 _productId) external {
        Product storage product = products[_productId];
        require(product.seller != address(0), "Product does not exist");
        require(product.isSold, "Product is not sold");
        require(product.seller != msg.sender, "Seller cannot complete transaction");

        // Update product status
        product.isComplete = true;

        // Update user credibility
        userCredibility[product.seller]++;

        (bool success,) = product.seller.call{value: product.price}("");
        if (!success) {
            revert("Transfer failed");
        }

        // emit TransactionCompleted(_productId, msg.sender);
    }

    function reportFailedTransaction(uint256 _productId) external {
        Product storage product = products[_productId];
        require(product.seller != address(0), "Product does not exist");
        require(product.isSold, "Product is not sold");
        require(product.buyer == msg.sender, "Only Buyer can report failed transaction");
        product.scam = true;
        // Decrease buyer's credibility
        // userCredibility[msg.sender]--;
        emit TransactionFailed(_productId, msg.sender);
    }

    function resolveFailedTransaction(uint256 _productId, bool isScam) public {
        require(products[_productId].scam, "Product is not a scam");
        require(userCredibility[msg.sender] > 10, " You are not allowed to resolve this transaction");
        if (isScam) {
            userCredibility[products[_productId].seller]--;
            (bool success,) = products[_productId].buyer.call{value: products[_productId].price}("");
            productNFT.burn(_productId);
            if (!success) {
                revert("Transfer failed");
            }
        } else {
            userCredibility[products[_productId].buyer]--;
            (bool success,) = products[_productId].seller.call{value: products[_productId].price}("");
            if (!success) {
                revert("Transfer failed");
            }
        }
        userCredibility[msg.sender]++;
    }

    function getUserCredibility(address _user) external view returns (int256) {
        return userCredibility[_user];
    }
}
