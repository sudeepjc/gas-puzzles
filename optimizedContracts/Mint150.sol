//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/token/ERC721/IERC721.sol';
import '@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol';
import 'hardhat/console.sol';

// You may not modify this contract or the openzeppelin contracts
contract NotRareToken is ERC721 {
    mapping(address => bool) private alreadyMinted;

    uint256 private totalSupply;

    constructor() ERC721('NotRareToken', 'NRT') {}

    function mint() external {
        totalSupply++;
        _safeMint(msg.sender, totalSupply);
        alreadyMinted[msg.sender] = true;
    }
}

interface INotRareToken is IERC721 {
    function mint() external;
}

contract OptimizedAttacker {
    constructor(address victim) {
        INotRareToken nrt = INotRareToken(victim);
        address owner = nrt.ownerOf(1);
        uint256 ownerBalance = nrt.balanceOf(owner);
        uint256 targetCount;
        uint256 current;
        uint256 i;
        unchecked {
            targetCount = ownerBalance + 150;
            i = ownerBalance + 1;
            current = i;
        }

        nrt.mint(); // mint the current token and do not transfer it

        do {
            nrt.mint();
            unchecked {
                i++;
            }
            nrt.transferFrom(address(this), tx.origin, i);
        } while (i < targetCount);

        // Transfer the current token here to save gas on change of balance 0-1 and 1-0
        nrt.transferFrom(address(this), tx.origin, current);
        selfdestruct(payable(msg.sender));
    }
}

/*
npx hardhat test test/Mint150.js 
Compiled 1 Solidity file successfully


  Mint150
    Gas target
           Current gas use:   5136218
           The gas target is: 6029700
      ✔ The functions MUST meet the expected gas efficiency (17995ms)
    Business logic
      ✔ The attacker MUST mint 150 NFTs in one transaction (1500ms)


  2 passing (22s)
*/
