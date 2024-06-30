# Store Management System 

This contract implements a simple store management system where the store owner (deployer of the contract) can add products, update product prices, and sell products. It includes functions with conditions checked using require, assert, and revert statements.

## Description

The Shop contract is a basic implementation of a product management system on the Ethereum blockchain. It includes the following functionalities:

Adding products to the store.
Updating product prices.
Buying products from the store.
A mapping to keep track of products' names, prices, and existence status.

## Contract Details

The `eth-avax_1st_assignment` smart-contract is written in Solidity and includes the following key components:

### State Variables

-`address public owner`: Stores the address of the contract owner (store owner).
-`mapping(address => string) public products`: A mapping to store product names by their address.
-`mapping(address => bool) public productExists`: A mapping to check if a product is registered.
-`mapping(address => uint) public productPrices`: A mapping to store product prices.

### Events

- `event ProductAdded(address indexed product, string name, uint price)`: Emitted when a new product is added.
-`event ProductPriceUpdated(address indexed product, uint price)`: Emitted when a product price is updated.
-`event ProductBought(address indexed product, uint quantity, address buyer)`: Emitted when a product is bought.

### Constructor

```solidity
constructor() {
    owner = msg.sender;
}
```

### Functions

#### Add Product

The `addProduct` function allows the store owner to add a new product by providing its address, name, and price:

```solidity
function addProduct(address _product, string memory _name, uint _price) public onlyOwner {
    require(!productExists[_product], "Product already exists in the store");
    require(bytes(_name).length > 0, "Invalid product name");

    products[_product] = _name;
    productPrices[_product] = _price;
    productExists[_product] = true;
    emit ProductAdded(_product, _name, _price);
}
```
### Update Product Price

The `updateProductPrice` function allows the store owner to update the price of a registered product:

```solidity

function updateProductPrice(address _product, uint _price) public onlyOwner {
    require(productExists[_product], "Product not registered");

    productPrices[_product] = _price;
    assert(productPrices[_product] == _price);
    emit ProductPriceUpdated(_product, _price);
}
```
### Buy Product

The `buyProduct` function allows users to buy a product by providing its address and quantity. The function uses the revert statement to handle insufficient balance errors:

```solidity
error InsufficientBalance(uint balance, uint requiredAmount);

function buyProduct(address _product, uint _quantity) external payable {
    require(productExists[_product], "Product not registered");
    uint totalCost = productPrices[_product] * _quantity;
    if (msg.value < totalCost) {
        revert InsufficientBalance({balance: msg.value, requiredAmount: totalCost});
    }

    payable(owner).transfer(msg.value);
    emit ProductBought(_product, _quantity, msg.sender);
}
```

## Deployment

To deploy the `eth-avax_1st_assignment` smart-contract, you can use Remix IDE.

### Using Remix

1. Open [Remix](https://remix.ethereum.org/).
2. In the Contracts folder, create a new file and paste the contract code into the editor.
3. Compile the contract using Ctrl+S.
4. Deploy the contract to the desired Ethereum network.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

## Authors

Pratik Mishra

## Contributing

Contributions are welcome! Feel free to submit changes or improvements.

---

This README provides a comprehensive guide to understanding, deploying, and using the `eth-avax_1st_assignment` smart contract.
