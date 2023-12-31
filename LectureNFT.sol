// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LectureNFT is ERC721, Ownable {
    using Strings for uint256;
    using Address for address;


    uint256 MAX_SUPPLY = 100;
    bool isSaleActive;
    uint256 totalSupply;
    mapping(uint256 => uint256) tokenMetadataNo;

    constructor() ERC721("LectureNFT", "LECTURE") {}
    
    function _baseURI() internal view override returns (string memory) {
        return "ipfs://QmZPXWV125CraDzAwoojj8uX8KTjUkaeyznao6LHs7wMb1";
    }
    
    function setSale(bool active) external onlyOwner {
        isSaleActive = active;
    }

    function mintPlanet(uint256 count) external payable {
        require(isSaleActive, "not on sale");
        require(msg.value >= 1000000000000000 * count);
        require(count <= 10, "mint maximum 10 nfts at once");

        for (uint i= 0; i < count; i ++) {
            require(totalSupply < MAX_SUPPLY, "max supply exceeded");
            tokenMetadataNo[totalSupply] =
            1 +
            (uint256(blockhash(block.number)) % 8);
            _safeMint(msg.sender, totalSupply++);
        }
    }

    function tokenURI(uint256 tokenId)
     public view virtual override returns(string memory)
     {
        _requireMinted(tokenId);

        string memory baseURI = _baseURI();
        return string(
            abi.encodePacked(baseURI, tokenMetadataNo[tokenId].toString())
        );
     }  

     function withdraw() external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
     }  
}