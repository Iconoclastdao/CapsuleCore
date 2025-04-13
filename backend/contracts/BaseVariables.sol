// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title BaseVariables
 * @dev Contract deployed by Iconoclastdao
 * @notice Deployment timestamp: 2025-04-13 13:53:35 UTC
 * @notice This contract contains all state variables organized by category
 */
contract BaseVariables is Ownable {

    // ====== Time Constants ======
    uint256 public constant COMMITMENT_EXPIRATION = 1 days;
    uint256 public constant MIN_DELAY = 1 hours;
    uint256 public constant MAX_DELAY = 7 days;
    uint256 public votingPeriod = 1 days;
    uint256 public randomDelay = 1 hours;

    // ====== Amount Constants ======
    uint256 public constant MIN_DEPOSIT_AMOUNT = 1 * 10**18;  // 1 token
    uint256 public constant MAX_DEPOSIT_AMOUNT = 1000 * 10**18;  // 1000 tokens
    uint256 public constant QUORUM_PERCENTAGE = 51;  // 51% for majority

    // ====== Counters ======
    uint256 public nextProposalId;
    uint256 public totalDeposits;
    uint256 public activeProposals;
    uint256 public completedProposals;

    // ====== Token Related ======
    IERC20 public votingToken;
    IERC20 public rewardToken;
    IERC20 public stakeToken;

    // ====== Status Flags ======
    bool public isVotingPaused;
    bool public isDepositPaused;
    bool public isSystemPaused;

    // ====== System Addresses ======
    address public treasury;
    address public governance;
    address public oracle;
    address public validator;

    // ====== System Parameters ======
    uint256 public minVotingPower;
    uint256 public maxVotingPower;
    uint256 public proposalThreshold;
    bytes32 public currentEpochHash;

    constructor() Ownable(msg.sender) {}
}