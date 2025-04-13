// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./BaseStructs.sol";
import "./BaseMappings.sol";
import "./BaseEvents.sol";
import  "./BaseVariable.sol";

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";







interface IDroneRegistry {
    function verifyDroneData(
        uint256 tokenId,
        uint256 trustScore,
        uint256 performanceMetric,
        bytes32[] calldata proof
    ) external view returns (bool);
}




/**
 * @title BaseFunctions
 * @dev Contract deployed by Iconoclastdao
 * @notice Deployment timestamp: 2025-04-13 13:08:30 UTC
 * @notice This contract contains all core functionality grouped by purpose
 */
contract BaseFunctions is Ownable, BaseStructs, BaseMappings, BaseEvents, ReentrancyGuard {
    using SafeMath for uint256;

        IERC20 public rewardToken;
    IERC20 public token;

    // ====== Counters ======
    uint256 public nextProposalId;
    uint256 public nextCapsuleId;

    // ====== System Addresses ======
    address public taskManager;
    address public treasury;

    // ====== Time Variables ======
    uint256 public votingPeriod = 7 days;

    // ====== Mappings ======
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    mapping(address => uint256) public deposits;
    mapping(uint256 => string) public capsulePrivacyData;
    mapping(address => bool) public registeredDrones;
    mapping(address => bool) public registeredOracles;
    mapping(address => uint256) public droneIds;

constructor() Ownable(msg.sender) {}

    // ====== Getter Functions ======
    function getDroneId(address drone) public view returns (uint256) {
        return droneIds[drone];
    }

    // ====== Admin Functions ======
    function setTaskManager(address _newTaskManager) external onlyOwner {
        require(_newTaskManager != address(0), "Invalid task manager");
        taskManager = _newTaskManager;
    }

    function setVotingPeriod(uint256 _newPeriod) external onlyOwner {
        require(_newPeriod > 0, "Invalid period");
        votingPeriod = _newPeriod;
    }

    function registerDrone(address _drone) external onlyOwner {
        require(_drone != address(0), "Invalid drone address");
        require(!registeredDrones[_drone], "Drone already registered");
        registeredDrones[_drone] = true;
        droneIds[_drone] = nextCapsuleId++;
    }

    function registerOracle(address _oracle) external onlyOwner {
        require(_oracle != address(0), "Invalid oracle address");
        require(!registeredOracles[_oracle], "Oracle already registered");
        registeredOracles[_oracle] = true;
    }

    // ====== Events ======
    event TaskManagerUpdated(address indexed oldManager, address indexed newManager);
    event VotingPeriodUpdated(uint256 oldPeriod, uint256 newPeriod);
    event DroneRegistered(address indexed drone, uint256 droneId);
    event OracleRegistered(address indexed oracle);


  

    function distributeReward(address node, uint256 amount) external onlyOwner {
        require(nodes[node].isRegistered, "Node not registered");
        require(rewardToken.transfer(node, amount), "Reward transfer failed");
        emit RewardDistributed(node, amount);
    }







    // ====== Privacy and Security Functions ======
    function attachPrivacyData(uint256 capsuleId, string calldata uri) external {
        require(msg.sender == capsules[capsuleId].owner, "Not capsule owner");
        capsulePrivacyData[capsuleId] = uri;
        emit PrivacyDataAttached(capsuleId, uri);
    }

    // ====== Modifiers ======
    modifier onlyTaskManager() {
        require(msg.sender == taskManager, "Only task manager");
        _;
    }

    modifier onlyRegisteredDrone() {
        require(registeredDrones[msg.sender], "Not a registered drone");
        _;
    }

    modifier onlyRegisteredOracle() {
        require(registeredOracles[msg.sender], "Not a registered oracle");
        _;
    }
}
