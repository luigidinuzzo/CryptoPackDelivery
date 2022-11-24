// SPDX-License-Identifier: UNIBO
pragma solidity ^0.8.0;

import "./safemath.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";


contract PackFactory is ERC721, Ownable {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    event NewPack(uint packId, address receiver);

    struct Coordinate {
        uint lat;
        uint long;
    }

    struct Pack {
        uint256 pCode; //codice pacco progressivo. Ogni nuovo pacco è pcode + 1
        address sender;
        address receiver;
        bool delivered; //true consegnato, false in transito
    }

    Pack[] public container;

    uint256 seed = 0;

    mapping (uint => address) public packToSender;
    mapping (uint => address) public packToReceiver;
    mapping (address => uint) public senderPackCount;
    mapping (address => uint) public receiverPackCount;
    mapping (address => Coordinate) public coordinateFromReceiver;
    mapping (uint => bool) public isDeliveredMap;
    mapping(address => uint256) public mintedPerWallet;
    mapping(uint256 => address) public tokenIdPerWallet;

    using Strings for uint256;

    uint public constant MAX_TOKENS = 10000;
    uint private constant TOKENS_RESERVED = 5;
    uint public price = 0;
    uint256 public constant MAX_MINT_PER_TX = 10;

    uint256 public tokenIds;
    bool public isSaleActive;
    uint256 public totalSupply;
    string public baseUri;


    constructor() ERC721("NFT Pack", "NFTP") {
        baseUri = "ipfs://xxxxxxxxxxxxxxxxxxxxxxxxxxxxx/";
    }

    function createPack(address _receiver, uint256 _numTokens, uint _lat, uint _long) external onlyOwner {
        Coordinate memory cord;
        cord.lat = _lat;
        cord.long = _long;
        coordinateFromReceiver[_receiver] = cord;
        for(uint256 i = 1; i <= _numTokens; ++i) {
            seed = seed.add(1);
            container.push(Pack(seed, msg.sender, _receiver, false));
            uint id = container.length - 1;
            packToSender[id] = msg.sender;
            packToReceiver[id] = _receiver;
            senderPackCount[msg.sender] = senderPackCount[msg.sender].add(1);
            receiverPackCount[_receiver] = receiverPackCount[_receiver].add(1);
            emit NewPack(id, _receiver);
            mint(1, _receiver);
        }
    }

    // Public Functions
    function mint(uint256 _numTokens, address _receiver) public payable {
        require(isSaleActive, "The sale is paused.");
        require(_numTokens <= MAX_MINT_PER_TX, "You cannot mint that many in one transaction.");
        require(mintedPerWallet[msg.sender] + _numTokens <= MAX_MINT_PER_TX, "You cannot mint that many total.");
        uint256 curTotalSupply = totalSupply;
        require(curTotalSupply + _numTokens <= MAX_TOKENS, "Exceeds total supply.");
        require(_numTokens * price <= msg.value, "Insufficient funds.");

        for(uint256 i = 1; i <= _numTokens; ++i) {
            _safeMint(msg.sender, curTotalSupply + i);
        }
        mintedPerWallet[_receiver] += _numTokens;
        tokenIds++;
        tokenIdPerWallet[tokenIds] = msg.sender;
        totalSupply += _numTokens;
    }

    // Owner-only functions
    function flipSaleState() external onlyOwner {
        isSaleActive = !isSaleActive;
    }

    function setBaseUri(string memory _baseUri) external onlyOwner {
        baseUri = _baseUri;
    }

    function setPrice(uint256 _price) external onlyOwner {
        price = _price;
    }

    function getMintedPerWallet(address _address) external view returns (uint256) {
        return mintedPerWallet[_address];
    }

}
