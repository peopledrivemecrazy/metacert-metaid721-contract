// SPDX-License-Identifier: Unlicense

pragma solidity >=0.8.2 <0.9.0;

import "./libs/Ownable.sol";
import "./libs/MetaID721.sol";

abstract contract Security {
    modifier onlySender() {
        require(tx.origin == msg.sender, "The caller is another contract");
        _;
    }
}

contract MetaID is MetaID721, Security, Ownable {
    constructor() MetaID721("MetaID", "MID") {}

    mapping(address => bool) public hasId;

    function mintId(address _address) external onlyOwner {
        require(!hasId[_address], "The address has MetaID");
        uint256 currentToken = totalSupply + 1;
        _mint(_address, currentToken);
        hasId[_address] = true;
    }

    function setBaseTokenURI(string memory baseURI) external onlyOwner {
        _setBaseTokenURI(baseURI);
    }
}
