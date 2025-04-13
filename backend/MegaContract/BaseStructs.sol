// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title BaseStructs
 * @dev Contract deployed by Iconoclastdao
 * @notice Deployment timestamp: 2025-04-13 12:50:31 UTC
 * @notice This contract acts as the base layer for all data structures
 */
contract BaseStructs {
   struct Node {
        address nodeAddress;
        bool isRegistered;
        uint256 stakeAmount;
        uint256 reputationScore;
        uint256 performanceScore;
        uint256 rewardClaimed;
       uint256 currentTier;
    }

    struct RandomnessCommitment {
        bytes32 commitment;
        uint256 timestamp;
    }

  
    struct NodeData {
        uint256 stakeAmount;
        uint256 performanceScore;
        string taskResults;
    }


    struct Call {
        address target;
        uint256 value;
        bytes data;
    }

    struct Proposaldata {
        uint256 id;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 endTime;
        bool executed;
        bool aiSuggested;
        bool humanSuggested;
    }

    struct Proposal {
        uint256 id;
        address proposer;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 createdAt;
        bytes callData;
        address target;
        uint256 endTime;
    }

    struct Task {
        uint256 taskId;
        uint256 droneId;
        string taskType;
        string parameters;
        uint256 assignedAt;
        bool completed;
    }

    struct DataProvider {
        bool isActive;
        uint256 reputation;
    }

    struct PriceData {
        uint256 price;
        uint256 timestamp;
    }

    struct Drone {
        uint256 trustScore;
        uint256 performanceMetric;
        uint256 lastUpdate;
        bool active;
    }



    struct CapsuleNode {
        address capsule;
        uint256 score;
        uint256 lastUpdate;
    }

    struct MemoryEntry {
        string uri;
        string memoryHash;
        bool verified;
        uint256 timestamp;
    }

    struct SyncEvent {
        uint256 capsuleId;
        string topic;
        string dataURI;
        uint256 timestamp;
    }

    struct Broadcast {
        uint256 capsuleId;
        string topic;
        string message;
        uint256 timestamp;
    }

    struct Capsule {
        address owner;
        address linkedWallet;
        address oracle;
        address[] agents;
        address heir;
        uint256 unlockTime;
        string[] encryptedURIs;
        address[] authorizedViewers;
        uint256[] timelineLinks;
        string[] linkReasons;
    }

    struct LegacyVault {
        address beneficiary;
        uint256 unlockTimestamp;
        bool claimed;
    }

    struct EncryptedVault {
        string encryptedUri;
        address allowedDecryptor;
    }

    struct Asset {
        address token;
        uint256 weight; // Basis points (out of 10,000)
    }

   
    struct Milestone {
        string description;
        uint256 dueDate;
        bool isClaimed;
    }

    struct Project {
        address creator;
        uint256 milestoneCount;
        bool exists;
    }

    struct Swap {
        address initiator;
        address counterparty;
        address tokenA;
        uint256 amountA;
        address tokenB;
        uint256 amountB;
        uint256 deadline;
        bool accepted;
        bool cancelled;
    }

    struct FunctionData {
        bytes32 selector;
        bytes32[] proof;
    }

    struct Metadata {
        string name;
        uint256 priceInWei; // Assuming you want to store the price of a token.
    }

    struct Wallet {
        address owner;
        string label;
        bool frozen;
        address wallet;
        uint256 ethBalance;
        uint tokenId;
    }

    struct TokenDetails {
        address walletAddress;
        address oracleAddress;
        uint256 tokenId;
        string label; // Adding label field
    }

    struct Message {
    address sender;
    uint256 fromCapsuleId;
    uint256 toCapsuleId;
    uint256 timestamp;
    string content;
}

    struct DecodedTransaction {
        address from;
        address to;
        uint256 value;
        uint256 gasLimit;
        uint256 nonce;
        bytes data;
        bytes signature;
    }

    struct DecodedTuple {
        uint256 num;
        address addr;
        string text;
        bytes extraData;
    }

    struct DecodedStruct {
        uint256 id;
        address owner;
        uint256 balance;
    }

    struct DecodedKeyValue {
        bytes32 key;
        bytes value;
    }

    struct Shard { uint256 id; bytes32 asset; uint256 price; }

    struct CloneMetadata {
        address creator;
        uint256 creationTime;
        bytes bytecode;
    }

    struct WalletData {
        address owner;
        string label;
        bool frozen;
        uint256 ethBalance;
    }

    struct TimelineEntry {
        uint256 parentId;
        string tag;
    }

    struct ModuleInfo {
        address implementation;
        string version;
        string author;
    }

  
    struct RegistryEntry {
        address instance;
        string metadata;
        address creator;
    }
}