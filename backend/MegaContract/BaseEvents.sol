// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title BaseEvents
 * @dev Contract deployed by Iconoclastdao
 * @notice Deployment timestamp: 2025-04-13 12:50:31 UTC
 * @notice This contract defines all system events
 */
contract BaseEvents {
     event NodeRegistered(address indexed node);
    event RewardDistributed(address indexed node, uint256 amount);

    event ProposalCreated(uint256 proposalId, address proposer, string description, uint256 endTimestamp);
    event Voted(uint256 proposalId, address voter);
    event ProposalExecuted(uint256 proposalId);
    event NodeDataSubmitted(address indexed node, uint256 stakeAmount, uint256 performanceScore, string taskResults);
    event TokensDeposited(address indexed depositor, uint256 amount);
    event TokensWithdrawn(address indexed withdrawer, uint256 amount, uint256 withdrawTime);
    event RewardsDeposited(address indexed from, uint256 amount);
    event RewardsWithdrawn(address indexed to, uint256 amount);
    event AtomicMultiCallExecuted(address indexed caller, uint256 numCalls);
    event OracleDataSubmitted(uint256 indexed droneId, uint256 trustScore, uint256 performanceMetric);
    event CapsuleDeployed(
        uint256 indexed capsuleId,
        address indexed owner,
        address capsuleController,
        address capsuleWallet,
        address userUnifiedOracle,
        address hiveUnifiedOracle,
        address hiveCapsuleWallet
    );
    event ImplementationsUpdated(
        address capsuleControllerImpl,
        address capsuleWalletImpl,
        address unifiedOracleDroneImpl,
        address hiveCapsuleWalletImpl
    );
    event VaultUpdated(address indexed oldVault, address indexed newVault);
    event HiveOracleAdded(uint256 indexed capsuleId, address hiveUnifiedOracle);
    event HiveWalletAdded(uint256 indexed capsuleId, address hiveCapsuleWallet);
    event HiveOracleRemoved(uint256 indexed capsuleId);
    event HiveWalletRemoved(uint256 indexed capsuleId);
    event CapsulePaused(uint256 indexed capsuleId);
    event CapsuleUnpaused(uint256 indexed capsuleId);
    event TaskExecutedOnCapsule(uint256 indexed capsuleId, uint256 taskId, bool success);
    event RewardsDistributed(uint256 indexed capsuleId, address capsuleWallet, uint256 amount);

    event ProposalCreated(uint256 indexed proposalId, string description, bool aiSuggested, bool humanSuggested);
  
    event Voted(uint256 indexed proposalId, address indexed voter, bool support);
    event LiquidityProvided(address indexed token, uint256 amount);
    event LiquidityWithdrawn(address indexed token, uint256 amount);
    event SwapExecuted(address fromToken, address toToken, uint256 amountIn, uint256 amountOut, address indexed user);
    event ProposalCreated(uint256 indexed proposalId, address indexed proposer, string description);
    event Voted(uint256 indexed proposalId, address indexed voter, bool support, uint256 weight);
    event ProposalExecuted(uint256 indexed proposalId, bool success);
    event ProposalRejected(uint256 indexed proposalId);
    event ConsensusThresholdUpdated(uint256 newThreshold);
    event RiskThresholdUpdated(uint256 newThreshold);
    event RiskAlert(uint256 capsuleId, uint256 riskScore, string message);
    event RebalanceTriggered(uint256 capsuleId, string message);
    event TaskAssigned(uint256 indexed taskId, uint256 indexed droneId, string taskType, string parameters, uint256 assignedAt);
    event TaskCompleted(uint256 indexed taskId, uint256 completedAt);
    event TaskExecuted(uint256 indexed taskId, uint256 indexed droneId, uint256 trustScore, uint256 performanceMetric);
    event NoiseCollected(uint256 noiseValue);
    event CommitmentMade(address indexed user, bytes32 commitment);
    event RandomNumberRevealed(address indexed user, uint256 randomNumber);
    event RandomNumberGenerated(uint256 finalRandomness);
    event DataSubmitted(address indexed provider, bytes32 indexed asset, uint256 price);
    event PriceAggregated(bytes32 indexed asset, uint256 aggregatedPrice);
    event ProviderUpdated(address indexed provider, bool isActive, uint256 reputation);
    event ModulesUpdated(address taskManager, address randomnessManager, address priceAggregator);

    event MerkleRootUpdated(uint256 indexed tokenId, bytes32 newMerkleRoot, string dataReference);
    event AccessGranted(uint256 indexed tokenId, address indexed user);
    event AccessRevoked(uint256 indexed tokenId, address indexed user);
    event TokensMinted(address indexed recipient, uint256 amount);
    event TokensBurned(address indexed burner, uint256 amount);
    event TaskExecuted(address indexed user, uint256 indexed taskId);
    event VoteCast(address indexed user, uint256 indexed proposalId, bool support);

    event PrivacyDataAttached(uint256 indexed capsuleId, string uri);

    event InferenceTriggered(uint256 indexed capsuleId, string prompt);
    event CapsuleRegistered(address indexed capsule);
    event CapsuleValidated(address indexed capsule, uint256 zkProofHash);
    event CapsuleTriggered(address indexed capsule, string topic);
    event MemorySubmitted(uint256 indexed capsuleId, string uri, string memoryHash, bool verified, uint256 timestamp);
    event AgentAssigned(uint256 indexed capsuleId, address agent);
    event InferenceRequested(uint256 indexed capsuleId, string prompt, uint256 requestTime);
    event InferenceCompleted(uint256 indexed capsuleId, string result, uint256 responseTime);
    event ReputationGranted(address indexed user, uint256 score);
    event CapsuleMinted(address indexed owner, uint256 capsuleId, string metadataURI);
    event ControllerAssigned(uint256 indexed capsuleId, address controller);
    event SwarmSynced(uint256 indexed capsuleId, string topic, string dataURI, uint256 timestamp);
    event MessageBroadcast(uint256 indexed capsuleId, string topic, string message, uint256 timestamp);
    event CapsuleMinted(uint256 indexed capsuleId, address indexed owner, address wallet, address oracle);
    event PrivacyAttached(uint256 indexed capsuleId, string uri);
    event HeirAssigned(uint256 indexed capsuleId, address heir, uint256 unlockTime);

    event AgentAdded(uint256 indexed capsuleId, address agent);
    event InferenceTriggered(uint256 indexed capsuleId, address agent, string prompt);
    event CapsuleClaimed(uint256 indexed capsuleId, address indexed beneficiary);
    event LegacyAssigned(uint256 indexed capsuleId, address indexed beneficiary, uint256 unlockTimestamp);
    event EncryptedCapsuleStored(uint256 indexed capsuleId, string uri, address decryptor);
    event Deposited(address indexed user, uint256 amount);
    event LeverageAdjusted(uint256 newLeverage);
    event Rebalanced(uint256 newLeverage);
    event AssetAdded(address indexed token, uint256 weight);
    event Deposited(address indexed user, uint256 amount, uint256 shares);
    event Withdrawn(address indexed user, uint256 shares);
    event TaskPosted(uint256 indexed taskId, string description, uint256 reward);
    event TaskClaimed(uint256 indexed taskId, address indexed assignee);
    event TaskCompleted(uint256 indexed taskId, address indexed assignee);
    event ProjectCreated(uint256 indexed projectId, address indexed creator);
    event MilestoneMinted(uint256 indexed projectId, uint256 milestoneId, uint256 tokenId, address to);
    event MilestoneClaimed(uint256 indexed tokenId);
    event SwapCreated(
        uint256 indexed swapId,
        address indexed initiator,
        address tokenA,
        uint256 amountA,
        address tokenB,
        uint256 amountB,
        uint256 deadline
    );
    event SwapAccepted(uint256 indexed swapId, address indexed counterparty);
    event SwapCancelled(uint256 indexed swapId);
    event TaskAssigned(address indexed user, uint256 indexed droneId, string taskType);
    event ProposalCreated(uint256 indexed proposalId);
    event Voted(address indexed voter, uint256 indexed proposalId, bool support);
    event LiquidityProvided(address indexed user, address token, uint256 amount);
    event LiquidityWithdrawn(address indexed user, address token, uint256 amount);
    event RewardsClaimed(address indexed user);
    event GovernanceRouted(string system, uint256 proposalId);
    event ModuleExecuted(address indexed caller, bytes32 indexed bytecodeHash, address proxy);
    event MerkleRootUpdated(bytes32 newRoot);
    event ModuleDeployed(bytes32 indexed bytecodeHash, address implementation, address proxy);
    event SwapExecuted(address indexed from, address indexed to, uint amountOutMin, address[] path, uint deadline);
    event SwapExecuted(uint tokenAmountReceived);
    event Deposit(address indexed sender, uint256 amount);
    event Withdrawal(address indexed receiver, uint256 amount);
    event CapsuleMessageSent(
    address indexed sender,
    uint256 indexed fromCapsuleId,
    uint256 indexed toCapsuleId,
    string content,
    uint256 timestamp
);

    event MerkleRootUpdated(address indexed user, bytes32 newRoot);
    event VerifiedAction(address indexed user, string actionType);
    event DecodedEvent(uint256 indexed id, address indexed addr, string data);
    event OracleUpdated(uint256 newValue, string label);
    event ShardCreated(uint256 indexed id, bytes32 asset, uint256 price);
    event CloneCreated(address indexed cloneAddress);
    event Received(address, uint);
    event WalletAndOracleCreated(uint256 indexed walletId, address owner, string label, address oracleAddress);
    event WalletCreatedAndOracleDroneInstantiated(uint256 indexed tokenId1, uint256 id1);
    event WalletWithUniqueIdCreated(uint256 indexed tokenId1, uint256 id);
    event NewWalletCreatedAndOracleDroneInstantiated(uint256 indexed tokenId1, uint256 id);
    event TimelineLinked(uint256 indexed capsuleId, uint256 indexed parentId, string tag);
    event ModuleRegistered(string name, address implementation, string version, string author);
    event ModuleInstalled(uint256 indexed tokenId, string name, address moduleInstance);
    event ExecutorCreated(address indexed executor);
    event BestRouteSelected(address[] route, uint256 profit);
    event FlashLoanTriggered(address[] drones, address token, uint256 amount);
    event FlashLoanExecuted(address token, uint256 amount);
    event ArbitrageProfit(uint256 profit);
    event DroneRegistered(address indexed pool, address drone);
    event FlashLoansExecuted(address[] pools, address token, uint256 amount);
    event LeveragedSwapExecuted(
        address indexed user,
        address indexed tokenIn,
        address indexed tokenOut,
        uint256 totalAmountIn,
        uint256 amountOutReceived,
        uint256 borrowAmount
    );
    event DroneRegistered(uint256 indexed tokenId, address droneAddress);
    event DroneUpdated(uint256 indexed tokenId, uint256 trustScore, uint256 performanceMetric);
    event TaskCreated(bytes32 indexed taskId, string description);
    event TaskAssigned(bytes32 indexed taskId, uint256 indexed droneId);
    event TaskCompleted(bytes32 indexed taskId, uint256 result);
    event ModuleInstalled(uint256 indexed tokenId);
    event ModuleUninstalled(uint256 indexed tokenId);
    event DroneCreated(uint256 indexed tokenId, address indexed droneAddress);
    event WalletCreated(uint256 indexed tokenId, address indexed owner, string label);
    event WalletFrozen(uint256 indexed tokenId);
    event WalletUnfrozen(uint256 indexed tokenId);
    event LabelChanged(uint256 indexed tokenId, string newLabel);
    event ETHDeposited(uint256 indexed tokenId, address indexed from, uint256 amount);
    event ETHWithdrawn(uint256 indexed tokenId, address indexed to, uint256 amount);
    event ERC20Deposited(uint256 indexed tokenId, address indexed token, address indexed from, uint256 amount);
    event ERC20Withdrawn(uint256 indexed tokenId, address indexed token, address indexed to, uint256 amount);
    event ERC721Deposited(uint256 indexed tokenId, address indexed token, address indexed from, uint256 nftId);
    event ERC721Withdrawn(uint256 indexed tokenId, address indexed token, address indexed to, uint256 nftId);
    event OracleDroneUpdated(address indexed newOracleDrone);
    event Registered(bytes32 indexed id, address instance, string metadata, address creator);
}