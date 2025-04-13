// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./BaseStructs.sol";

/**
 * @title BaseMappings
 * @dev Contract deployed by Iconoclastdao
 * @notice Deployment timestamp: 2025-04-13 12:50:31 UTC
 * @notice This contract inherits from BaseStructs and adds all mapping definitions
 */
contract BaseMappings is BaseStructs {
     mapping(address => Node) public nodes;

    mapping(address => uint256[]) public nftHoldings;

    mapping(address => RandomnessCommitment) public randomnessCommitments;

    mapping(uint256 => Proposal) public proposals;

    mapping(address => NodeData) public nodeData;


    mapping(address => uint256) public totalDeposits;

    mapping(uint256 => address) public wallets;

    mapping(uint256 => address) public oracleDrones;

    mapping(uint256 => address) public hiveUnifiedOracles;

    mapping(uint256 => address) public hiveCapsuleWallets;


    mapping(address => uint256) public liquidityBalances;


    mapping(uint256 => Task) public tasks;

    mapping(address => bytes32) public commitments;

    mapping(address => uint256) public randomNumbers;

    mapping(address => DataProvider) public providers;

    mapping(bytes32 => PriceData[]) public priceHistory;

    mapping(bytes32 => address[]) private submissionsForAsset;

    mapping(bytes32 => uint256) public aggregatedPrices;

    mapping(uint256 => Drone) private _droneData;

    mapping(uint256 => bytes32) public droneMerkleRoots;

    mapping(uint256 => string) public droneDataReferences;

    mapping(uint256 => Capsule) public capsules;

    mapping(address => CapsuleNode) public capsuleData;

    mapping(uint256 => MemoryEntry[]) public capsuleMemories;

    mapping(uint256 => address) public assignedAgents;

    mapping(address => uint256) public rep;

    mapping(uint256 => address) public controllers;


    mapping(uint256 => LegacyVault) public legacyVaults;

    mapping(uint256 => EncryptedVault) public encryptedVaults;


    mapping(address => uint256) public userShares;


    mapping(uint256 => Project) public projects;

    mapping(uint256 => uint256) public tokenToProject;

    mapping(uint256 => uint256) public tokenToMilestone;

    mapping(uint256 => Swap) public swaps;

    mapping(address => uint256) public staked;

    mapping(address => uint256) public lastClaim;

    mapping(bytes32 => address) public deployedModules;

    mapping(bytes32 => address) public proxyInstances;

    mapping(bytes32 => bool) public daoOnlyModules;

    mapping(address => uint256) public balances;

    mapping(uint256 => Message[]) private capsuleInbox;

    mapping(address => Metadata) public metadataByAddress;

    mapping(uint256 => uint256) public mintedTokens;

    mapping(address => uint256[]) public ownerToTokenIds;

    mapping(uint256 => bytes32) private walletPasswords;


    mapping(uint256 => bytes32) public walletMerkleRoots;

    mapping(uint256 => address) public tokenIdToOracle;

    mapping(uint256 => TokenDetails) public tokenDetails;

    mapping(address => bool) public trustedModules;

    mapping(address => bytes32) public merkleRoots;

    mapping(uint256 => Shard) public shards;

    mapping(address => CloneMetadata) public cloneMetadata;


    mapping(uint256 => address) public walletOracles;



    mapping(uint256 => TimelineEntry) public timelines;

    mapping(bytes32 => ModuleInfo) public modulesById;

    mapping(string => bytes32) public nameToId;

    mapping(address => address) public tokenToDrones;

    mapping(address => address) public poolToDrone;

    mapping(uint256 => Drone) public drones;




    mapping(bytes32 => RegistryEntry) public registry;
}