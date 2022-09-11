// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.7;
pragma solidity ^0.7.0;

contract Auction {
    struct Item {
        address itemOwner;
        uint startingPrice;
        uint currentPrice;
        string name;
        uint startAunction;
        uint endAuction;
        bool sold;
    }

    mapping(uint => Item) public items;
    Item[] public itemsArray;
    uint ID;
    uint[] id;

    modifier isBiddingOver(uint _id) {
        Item memory item = items[_id];
     require(item.endAuction >= block.timestamp, "Bidding time is over");
        _;
    }

    function addItemToBid(string memory _name, uint256  _startingPrice, uint duration) public  {
        Item storage item = items[ID];
        item.itemOwner = msg.sender;
        item.name= _name;
        item.startingPrice = _startingPrice;
        item.currentPrice = _startingPrice;
        item.startAunction = block.timestamp;
        item.endAuction = block.timestamp + duration;
        itemsArray.push(item);
        uint _id = ID;
        id.push(_id);
        ID++;
    }
    
    function bidForItem (uint _id) public payable isBiddingOver(_id) {
        Item storage item = items[_id];
        require(!item.sold, "Item has been sold");
        require(item.itemOwner != msg.sender, "Item owner cannot bid");
        require(msg.value >= item.startingPrice && msg.value >= item.currentPrice , "Item is priced higher that what you are offering");
        item.currentPrice = msg.value;
    }

    function withdraw (uint _id) public {
        Item memory item = items[_id];
        require(item.itemOwner == msg.sender, "You are not the owner");
        require(block.timestamp >= item.endAuction, "Bidding time is over");
        soldStatus(_id);
        payable(item.itemOwner).transfer(item.currentPrice);
    }

    function soldStatus (uint _id) public  returns (bool) {
        Item storage item = items[_id];
        return item.sold = !item.sold;

    }

    function getAllAuctionItems() public view returns(Item[] memory _itemsArray){
        uint[] memory all = id;
        _itemsArray = new Item[](all.length);

        for(uint i; i < all.length; i++){
            _itemsArray[i] = items[all[i]];
        }
    }

   
}