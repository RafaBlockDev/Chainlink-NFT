// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interface/AggregatorV3Interface.sol";

contract MyCollection is ERC721, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private tokenId;

    AggregatorV3Interface internal priceFeed;

    uint256 public totalSupply;
    uint256 public mintPriceUSD;
    string public initBaseURI;

    constructor(
        string memory _initBaseURI, 
        uint256 _totalSupply) ERC721("My Collection", "MC") {
        priceFeed = AggregatorV3Interface(
            0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada
        );
        initBaseURI = _initBaseURI;
        totalSupply = _totalSupply;
        mintPriceUSD = 10;
    }

    function mint(address _to) external payable returns(uint256) {
        tokenId.increment();
        uint256 _tokenId = tokenId.current();
        require(_tokenId < totalSupply, "You cannot mint more than totalSupply");
        uint256 mintPrice = getTotalPrice();
        require(msg.value >= mintPrice, "value not enough");

        _safeMint(_to, _tokenId);
        return _tokenId;
    }

    function getLatestMaticUsdPrice() public view returns(int256) {
        // return USD *10**18
        (
            ,
            /*uint80 roundID*/
            int256 price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }

    function getMintPriceWei() public view returns (uint256) {
        uint256 matic = uint256(getLatestMaticUsdPrice());
        return (mintPriceUSD * 10**26) / matic;
    }

    function getTotalPrice() public view returns (uint256) {
        return getMintPriceWei() +  (getMintPriceWei() * 10) / 100;
    }

}
