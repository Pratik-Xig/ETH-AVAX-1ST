// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Shop {
    address public owner;
    mapping (address=>string) public products;
    mapping (address=>bool) public productExists;
    mapping (address=>uint) public productPrices;

    event ProductAdded(address indexed product, string name, uint price);
    event ProductPriceUpdated(address indexed product, uint price);
    event ProductBought(address indexed product, uint quantity, address buyer);

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"Only owner can perform these tasks");
        _;
    }

    function addProduct(address _product, string memory _name, uint _price) public onlyOwner{
        require(productExists[_product] == false , "Product exists in da store ^_^");
        products[_product] = _name;
        productPrices[_product] = _price;
        productExists[_product] = true;
        emit ProductAdded(_product, _name, _price);
    }

    function updateProductPrice(address _product, uint _price) public onlyOwner{
        require(productExists[_product]== true, "Product aint registered :(");
        productPrices[_product] = _price;
        assert(productPrices[_product] == _price);
        emit ProductPriceUpdated(_product, _price);
    }

    error InsufficientBalance(uint balance, uint reqAmount);

    function buyProduct(address _product, uint _quantity, uint _amountuhave) external payable{
        require(productExists[_product]==true, "Product not registered");
        if (_amountuhave < productPrices[_product] * _quantity)
            revert InsufficientBalance({balance:msg.value , reqAmount: productPrices[_product] * _quantity});
        payable(owner).transfer(msg.value);
        emit ProductBought(_product, _quantity, msg.sender);
    }
}

