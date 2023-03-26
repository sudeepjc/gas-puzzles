// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.15;

contract OptimizedVote {
    struct Voter {
        uint8 vote;
        bool voted;
    }

    struct Proposal {
        // Sudeep: rearranged order here
        uint8 voteCount;
        bool ended;
        bytes32 name;
    }

    mapping(address => Voter) public voters;

    Proposal[] proposals;

    function createProposal(bytes32 _name) external {
        proposals.push(Proposal({voteCount: 0, name: _name, ended: false}));
    }

    function vote(uint8 _proposal) external {
        require(!voters[msg.sender].voted, 'already voted');
        voters[msg.sender].vote = _proposal;
        voters[msg.sender].voted = true;

        unchecked {
            proposals[_proposal].voteCount += 1;
        }
    }

    function getVoteCount(uint8 _proposal) external view returns (uint8) {
        return proposals[_proposal].voteCount;
    }
}

/*
Compiled 1 Solidity file successfully

  Vote
    Payable
      ✔ The functions MUST remain non-payable
    Gas target
           Current gas use:   136375
           The gas target is: 136508
      ✔ The functions MUST meet the expected gas efficiency (52ms)
    Business logic
      ✔ The functions MUST perform as expected (117ms)
*/
