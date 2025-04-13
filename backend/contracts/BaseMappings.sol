// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./BaseStructs.sol";

/**
 * @title BaseMappings
 * @dev Mappings and relationships
 */
contract BaseMappings is BaseStructs {
    // Capsules by ID
    mapping(uint256 => Capsule) internal capsules;

    // Tracks if a capsule has been claimed
    mapping(uint256 => bool) internal claimedCapsules;

    // Tracks claims made by users
    mapping(address => Claim[]) internal userClaims;

    // Governance proposals by ID
    mapping(uint256 => Proposal) internal proposals;

    // Track if an address has voted on a proposal
    mapping(uint256 => mapping(address => bool)) internal hasVoted;
}