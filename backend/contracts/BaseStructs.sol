// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract BaseStructs {
    struct Capsule {
        uint256 id;
        address owner;
        string dataURI;
        bool claimed;
    }

    struct Claim {
        uint256 capsuleId;
        address claimer;
        uint256 timestamp;
    }

    struct Proposal {
        uint256 id;
        address proposer;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 createdAt;
        bool executed;
    }
}