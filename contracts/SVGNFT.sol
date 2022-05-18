//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "Brechtpd/base64@1.1.0/base64.sol";

contract SVGNFT is ERC721URIStorage {
    uint256 tokenCounter;
    event CreatedSVGNFT(uint256 indexed tokenId, string tokenURI);

    constructor() ERC721("SVG NFT", "SVGNFT") {
        tokenCounter = 0;
    }

    function create(string memory svg) public {
        _safeMint(msg.sender, tokenCounter);
        //svg uri?
        string memory imgURI = svgToImageURI(svg);
        //image uri?
        string memory tokenURI = formatTokenURI(imgURI);
        _setTokenURI(tokenCounter, tokenURI);
        emit CreatedSVGNFT(tokenCounter, tokenURI);
        tokenCounter = tokenCounter + 1;
    }

    function svgToImageURI(string memory svg)
        public
        pure
        returns (string memory)
    {
        string memory baseURL = "data:image/svg+xml;base64,";
        // svg code will now be converted into a large random string
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        string memory imageURI = string(
            abi.encodePacked(baseURL, svgBase64Encoded)
        );
        return imageURI;
    }

    function formatTokenURI(string memory imageURI)
        public
        pure
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                "SVG NFT",
                                '", "description":"An NFT based on SVG!", "attributes":"", "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
