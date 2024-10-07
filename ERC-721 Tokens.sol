// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract HaikuNFT is ERC721 {
    using Counters for Counters.Counter;

    struct Haiku {
        address author;
        string line1;
        string line2;
        string line3;
    }

    Haiku[] public haikus;
    mapping(address => uint256[]) public sharedHaikus;
    Counters.Counter public counter;

    mapping(string => bool) private usedLines;

    error HaikuNotUnique();
    error NotYourHaiku(uint256 haikuId);
    error NoHaikusShared();

    constructor() ERC721("HaikuNFT", "HAIKU") {
        counter.increment();
    }

    function mintHaiku(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) external {
        if (usedLines[_line1] || usedLines[_line2] || usedLines[_line3]) {
            revert HaikuNotUnique();
        }

        uint256 newHaikuId = counter.current();
        _safeMint(msg.sender, newHaikuId);

        haikus.push(
            Haiku({
                author: msg.sender,
                line1: _line1,
                line2: _line2,
                line3: _line3
            })
        );

        usedLines[_line1] = true;
        usedLines[_line2] = true;
        usedLines[_line3] = true;

        counter.increment();
    }

    function shareHaiku(uint256 _haikuId, address _to) public {
        if (ownerOf(_haikuId) != msg.sender) {
            revert NotYourHaiku(_haikuId);
        }

        sharedHaikus[_to].push(_haikuId);
    }

    function getMySharedHaikus() public view returns (Haiku[] memory) {
        uint256[] memory sharedIds = sharedHaikus[msg.sender];

        if (sharedIds.length == 0) {
            revert NoHaikusShared();
        }

        Haiku[] memory mySharedHaikus = new Haiku[](sharedIds.length);

        for (uint256 i = 0; i < sharedIds.length; i++) {
            mySharedHaikus[i] = haikus[sharedIds[i] - 1];
        }

        return mySharedHaikus;
    }
}
