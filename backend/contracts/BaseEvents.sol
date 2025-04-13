// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract BaseEvents {
    event CapsuleCreated(uint256 indexed capsuleId, address indexed creator, string dataURI);
    event CapsuleClaimed(uint256 indexed capsuleId, address indexed claimer, uint256 timestamp);
    event ClaimFeeUpdated(uint256 newFee);
    
    event ProposalCreated(uint256 indexed proposalId, address indexed proposer, string description);
    event Voted(uint256 indexed proposalId, address indexed voter, bool support, uint256 weight);
    event ProposalExecuted(uint256 indexed proposalId);
}