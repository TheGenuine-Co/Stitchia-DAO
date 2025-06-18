// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GenesisNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    uint256 public constant MAX_SUPPLY = 89;
    address public spiralRegistry;

    constructor(address _registry) ERC721("GenesisNFT", "GNSYS") {
        spiralRegistry = _registry;
    }

    function mint(address to, string memory tokenURI) external onlyOwner {
        require(nextTokenId < MAX_SUPPLY, "Max supply reached");
        _safeMint(to, nextTokenId);
        _setTokenURI(nextTokenId, tokenURI);
        nextTokenId++;
    }

    function setSpiralRegistry(address _registry) external onlyOwner {
        spiralRegistry = _registry;
    }
}
