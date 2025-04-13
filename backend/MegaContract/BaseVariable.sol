// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title BaseVariable
 * @dev Contract deployed by Iconoclastdao
 * @notice Deployment timestamp: 2025-04-13 13:53:35 UTC
 * @notice This contract contains all state variables organized by category
 */
contract BaseVariable is Ownable {

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

    // ====== Fee Structure ======
    uint256 public depositFee;     // in basis points (1/10000)
    uint256 public withdrawalFee;  // in basis points (1/10000)
    uint256 public performanceFee; // in basis points (1/10000)
       bytes32 computedHash = leaf;
    uint256 i = 0;
    address nodeAddress;
    bool isRegistered;
    uint256 stakeAmount;
    uint256 reputationScore;
    uint256 performanceScore;
    uint256 rewardClaimed;
     uint256 poolIndex = score / 10;
     bytes32 commitment;
    uint256 timestamp;
    address proposer;
    string description;
    uint256 voteCount;
    uint256 endTimestamp;
    bool executed;
 string taskResults;
    address depositor;
    uint256 amount;
    uint256 depositTime;
    bool isWithdrawn;
    address target;
    uint256 value;
    uint256 private nextCapsuleId = 1;
    address public capsuleControllerImplementation;
    address public capsuleWalletImplementation;
    address public unifiedOracleDroneImplementation;
    address public globalHiveController;
    address public hiveCapsuleWalletImplementation;
    address public taskManagerImplementation;
    address public randomnessManagerImplementation;
    address public priceAggregatorImplementation;
    address public droneRegistry;
    address public hiveCapsuleWallet;
    uint256 balance = address(this).balance;
    uint256 id;
    uint256 votesFor;
    uint256 votesAgainst;
    uint256 endTime;
    bool aiSuggested;
    bool humanSuggested;
    uint256 public consensusThreshold;
    uint256 proposalId = nextProposalId++;
    address public aggregatorRouter;
    uint256 balanceBefore = address(this).balance;
    uint256 balanceAfter = address(this).balance;
    uint256 public consensusThresholdBps;
       uint256 public riskThreshold;
    uint256 public nextTaskId;
    uint256 taskId;
    uint256 droneId;
    string taskType;
    string parameters;
    uint256 assignedAt;
    bool completed;
    uint256 public randomness;
   
    uint256 aggregated;
    
    bool isActive;
    uint256 reputation;
    uint256 price;
  
    uint256 public oracleConsensusThreshold = 3;
    uint256 totalPrice = 0;
  
   
    address public taskManager;
    address public randomnessManager;
    address public priceAggregator;
    address public wallet;
   
    uint256 trustScore;
    uint256 performanceMetric;
    uint256 lastUpdate;
    bool active;
    uint256 private _tokenCounter;
    uint256 tokenId = _tokenCounter;
    bytes32 leaf = keccak256(abi.encodePacked(tokenId, trustScore, performanceMetric));
    bytes32 public globalMerkleRoot;
    address public deployer;
    uint256 public capsuleCounter;
    address assignedWallet;
    address oracleModule;
    address heir;
    uint256 unlockTime;
    address agent;
    uint256 public tokenCounter;
    uint256 newId = tokenCounter++;
    address capsule;
    uint256 score;
   
    string uri;
    string memoryHash;
    bool verified;
  
    uint256 public nextId;
    uint256 capsuleId = nextId++;
  
    string topic;
    string dataURI;
    address public capsuleContract;
    address beneficiary;
    uint256 unlockTimestamp;
    bool claimed;
   
    string encryptedUri;
    address allowedDecryptor;
  
    address public executor;
    address public aavePool;
    uint256 public leverageFactor;
    uint256 public maxLeverage;
    address token;
    uint256 weight;
    uint256 public totalShares;
 
    address poster;
    address assignee;
    uint256 reward;
   
   
    uint256 public taskIdCounter;
    
    uint256 dueDate;
    bool isClaimed;
    address creator;
    uint256 milestoneCount;
    bool exists;
    uint256 public nextProjectId;
    uint256 public nextTokenId;
    uint256 projectId = nextProjectId++;
    
    uint256 public swapCounter;
    address initiator;
    address counterparty;
    address tokenA;
    uint256 amountA;
    address tokenB;
    uint256 amountB;
    uint256 deadline;
    bool accepted;
    bool cancelled;
    uint256 swapId = swapCounter;
   
    string name;
    uint256 priceInWei;
   

    constructor(
        address _votingToken,
        address _treasury
    ) Ownable(msg.sender) {
        require(_votingToken != address(0), "Invalid voting token");
        require(_treasury != address(0), "Invalid treasury");
        
        // Initialize tokens
        votingToken = IERC20(_votingToken);
        treasury = _treasury;
        governance = msg.sender;
        
        // Initialize fees
        depositFee = 50;      // 0.5%
        withdrawalFee = 50;   // 0.5%
        performanceFee = 1000; // 10%
        
        // Initialize thresholds
        minVotingPower = 100 * 10**18;  // 100 tokens
        maxVotingPower = 10000 * 10**18; // 10000 tokens
        proposalThreshold = 1000 * 10**18; // 1000 tokens

        emit BaseVariableInitialized(msg.sender, block.timestamp);
    }

    // ====== Events ======
    event BaseVariableInitialized(address indexed deployer, uint256 timestamp);
    event VotingPeriodUpdated(uint256 oldPeriod, uint256 newPeriod);
    event TreasuryUpdated(address indexed oldTreasury, address indexed newTreasury);
    event FeeUpdated(string feeType, uint256 oldFee, uint256 newFee);

    // ====== Admin Functions ======
    function setVotingPeriod(uint256 _newPeriod) external onlyOwner {
        require(_newPeriod >= MIN_DELAY && _newPeriod <= MAX_DELAY, "Invalid period");
        uint256 oldPeriod = votingPeriod;
        votingPeriod = _newPeriod;
        emit VotingPeriodUpdated(oldPeriod, _newPeriod);
    }

    function setTreasury(address _newTreasury) external onlyOwner {
        require(_newTreasury != address(0), "Invalid treasury");
        address oldTreasury = treasury;
        treasury = _newTreasury;
        emit TreasuryUpdated(oldTreasury, _newTreasury);
    }

    function setDepositFee(uint256 _newFee) external onlyOwner {
        require(_newFee <= 1000, "Fee too high"); // Max 10%
        uint256 oldFee = depositFee;
        depositFee = _newFee;
        emit FeeUpdated("deposit", oldFee, _newFee);
    }

    // ====== View Functions ======
    function getSystemStatus() external view returns (
        bool votingPaused,
        bool depositPaused,
        bool systemPaused,
        uint256 currentProposals,
        uint256 totalCompleted
    ) {
        return (
            isVotingPaused,
            isDepositPaused,
            isSystemPaused,
            activeProposals,
            completedProposals
        );
    }

    function getFeeStructure() external view returns (
        uint256 _depositFee,
        uint256 _withdrawalFee,
        uint256 _performanceFee
    ) {
        return (depositFee, withdrawalFee, performanceFee);
    }

    function getThresholds() external view returns (
        uint256 _minVotingPower,
        uint256 _maxVotingPower,
        uint256 _proposalThreshold
    ) {
        return (minVotingPower, maxVotingPower, proposalThreshold);
    }
}