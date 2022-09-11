// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
// import "@openzeppelin/contracts/ownership/Ownable.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    bytes32 public root;

    constructor(bytes32 _root) ERC721("ADEX", "TBN") {
      root = _root;
    }

    function mintNft(address to, string memory tokenURI, bytes32[] memory proof, bytes32 leaf)
        public  
        returns (uint256)
    {
      require(keccak256(abi.encodePacked(msg.sender)) == leaf, "Not the correct address")
require(isValid(proof, leaf), "Not a whitelisted address);

        uint256 newItemId = _tokenIds.current();
        _mint(to, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }

    function isValid(bytes32[] memory proof, bytes32 leaf) public view returns(bool) {
      return MerkelProof.verify(proof, root, leaf)
    }
}