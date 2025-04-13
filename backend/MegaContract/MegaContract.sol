// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./BaseFunctions.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";




interface ITokenMinter {
    function mintTo(address to, uint256 amount) external;
}






interface ICoincapsule {
    function addModule(uint256 tokenId, address module) external;
}




interface IWalletModule {
    /// @notice Executes arbitrary logic in the context of the wallet
    /// @param tokenId The wallet tokenId (serves as wallet identity)
    /// @param data Encoded function call or action to perform
    /// @return result Return data from execution
    function execute(uint256 tokenId, bytes calldata data) external returns (bytes memory result);
    function executeModuleFunction(bytes calldata data) external returns (bytes memory);

    /// @notice Returns a list of function selectors this module supports
    /// @dev Used to declare which actions this module can handle
    /// @return selectors List of function selectors (bytes4)
    function supportedFunctions() external view returns (bytes4[] memory);

    /// @notice Returns true if this module supports a specific function selector
    /// @param selector The function selector to query
    /// @return isSupported True if the module supports the selector
    function supportsFunction(bytes4 selector) external view returns (bool isSupported);

    /// @notice Hook that runs when a module is added to a wallet
    /// @param tokenId The wallet tokenId
    function onInstall(uint256 tokenId) external;

    /// @notice Hook that runs when a module is removed from a wallet
    /// @param tokenId The wallet tokenId
    function onUninstall(uint256 tokenId) external;

    /// @notice Returns human-readable metadata for this module
    /// @return name Name of the module
    /// @return version Semantic version (e.g. "1.0.0")
    /// @return author Address or string representing the author
    function moduleInfo() external view returns (string memory name, string memory version, string memory author);

    /// @notice Optional role-based authorization for this module
    /// @dev Can be used by modules that implement their own ACL or permission layer
    /// @param tokenId Wallet tokenId
    /// @param user Address attempting to perform an action
    /// @param action The encoded action or function selector
    /// @return allowed True if the user is allowed
    function isAuthorized(uint256 tokenId, address user, bytes4 action) external view returns (bool allowed);
}


interface IStakingToken { function transferFrom(address sender, address recipient, uint256 amount) external returns (bool); function balanceOf(address account) external view returns (uint256); }

interface ICapsuleWallet { function getOwner(uint256 tokenId) external view returns (address); function getETHBalance(uint256 tokenId) external view returns (uint256); function getLabel(uint256 tokenId) external view returns (string memory); function depositETH(uint256 tokenId) external payable; function withdrawETH(uint256 tokenId, uint256 amount) external; }

interface ICapsuleWalletExtended is ICapsuleWallet { function walletId() external view returns (uint256); }


interface IOracleDrone { function assignTask(uint256 droneId, string calldata taskType, string calldata parameters) external returns (uint256); function completeTask(uint256 taskId) external; function executeTask(uint256 taskId) external returns (bool); function collectNoise(uint256[] calldata noiseValues) external; function commitToRandomNumber(bytes32 _commitment) external; function revealRandomNumber(uint256 _randomNumber, uint256 _nonce) external; function getRandomNumber(address user) external view returns (uint256); function emergencyRebalance() external; function setOracleManager(address _oracleManager) external; function depositToWallet() external payable; function withdrawFromWallet(uint256 amount) external; function getOracleManager() external view returns (address); }

interface IUnifiedOracleDroneExtended is IOracleDrone {}

interface ITaskManager { function assignTask(uint256 droneId, string calldata taskType, string calldata parameters) external returns (uint256); function completeTask(uint256 taskId) external; function executeTask(uint256 taskId) external returns (bool); }

interface IRandomnessManager { function commitToRandomNumber(bytes32 _commitment) external; function revealRandomNumber(uint256 _randomNumber, uint256 _nonce) external; function getRandomNumber(address user) external view returns (uint256); function collectNoise(uint256[] calldata noiseValues) external; }

interface IPriceAggregator { function registerProvider(address provider) external; function updateProvider(address provider, bool isActive) external; function submitData(bytes32 asset, uint256 price) external returns (bool); function getPrice(bytes32 asset) external view returns (uint256); }

interface IArbitrage { function executeFlashLoan(address token, uint256 amount) external; }

interface ICurvePool { function get_dy(int128 i, int128 j, uint256 dx) external view returns (uint256); function exchange(int128 i, int128 j, uint256 dx, uint256 min_dy) external returns (uint256); }

interface ILending { function depositCollateral(address user, uint256 amount) external; function withdrawCollateral(address user, uint256 amount) external; function liquidate(address user) external; }

interface IGovernance { function voteOnProposal(uint256 proposalId, bool support) external; function executeProposal(uint256 proposalId) external; }

interface ILiquidityAggregator { function getBestLiquiditySource(address token, uint256 amount) external view returns (address, uint256); function borrowLiquidity(address source, address token, uint256 amount) external; }

interface IOracle { function submitData(bytes32 asset, uint256 price) external returns (bool); }

interface IStaking { function stake(address user, uint256 amount) external; function unstake(address user, uint256 amount) external; }

library Create3 {
 function cloneAndDeploy(bytes32 salt) internal returns (address) {
        address implementation = 0x587050B41391cDa8235aF3C4F8260098b69704A7; // Replace with your base wallet implementation address
        address clone = Clones.cloneDeterministic(implementation, salt);
        return clone;
    }
}

library Create4 {
    function cloneAndDeploy(bytes32 salt) internal returns (address) {
        address implementation = 0x987309bB0ab7AaEEd4164Ca3c6D9dd69D2239602; // Replace with your oracle implementation address
        address clone = Clones.cloneDeterministic(implementation, salt);
        return clone;
    }
}

interface IDexPool {
    function initialize(address tokenA, address tokenB) external;
    function swap(
        address tokenIn, 
        uint256 amountIn, 
        uint256 leverage, 
        bytes32[] calldata proof,
        bytes32 leaf
    ) external;
}
contract MegaContract is ERC20, BaseFunctions {

      using Address for address;
    using Address for address payable;
    using SafeERC20 for IERC20;

    uint256 public currentTokenId;

 
 

       mapping(uint256 => Message[]) public capsuleInbox;

    event MessageSent(
        uint256 indexed fromCapsuleId,
        uint256 indexed toCapsuleId,
        string content,
        uint256 timestamp
    );


    // Events to log the creation of wallets, oracles, and token minting
event OracleCreated(uint256 indexed tokenId, address indexed oracleAddress);
    event TokenMinted(uint256 tokenId, uint256 amount);

    uint256 public constant MAX_SUPPLY = 13000000000;
    uint8 public constant DECIMALS = 0;
    uint256 public constant MAX_MINT_AMOUNT = 100;
    uint256 public constant MINT_FEE = 0.0001 ether;



    address public feeVault;

    enum TwinWalletType { PRIMARY, SECONDARY }

    mapping(uint256 => mapping(bytes4 => address)) public walletModules;
    mapping(uint256 => mapping(bytes4 => bool)) public moduleEnabled;
    mapping(uint256 => mapping(TwinWalletType => Wallet)) public tokenWallets;
    
    mapping(address => mapping(uint256 => uint256)) private ownerTokenIndex;
    mapping(uint256 => bytes32) private walletPasswords;
   
    mapping(uint256 => mapping(bytes4 => address)) public moduleSelectors; // function selectors
    mapping(uint256 => mapping(string => address)) public linkedContracts;
    

    struct MetaData {
    // Add any necessary fields here, e.g.
    string sender;
    uint256 timestamp;
}

    uint256 public totalMinted;

    // Events
    event WalletFrozen(uint256 indexed tokenId, TwinWalletType walletType);
    event WalletUnfrozen(uint256 indexed tokenId, TwinWalletType walletType);
    event ETHDeposited(uint256 indexed tokenId, TwinWalletType walletType, address indexed from, uint256 amount);
    event ETHWithdrawn(uint256 indexed tokenId, TwinWalletType walletType, address indexed to, uint256 amount);
    event ModuleAdded(uint256 indexed tokenId, address indexed module);
    event OracleDeployed(uint256 indexed tokenId, address oracle);

    // Modifiers
    modifier onlyWalletOwner(uint256 tokenId, TwinWalletType walletType) {
        require(tokenWallets[tokenId][walletType].owner == msg.sender, "Not the wallet owner");
        _;
    }

    modifier notFrozen(uint256 tokenId, TwinWalletType walletType) {
        require(!tokenWallets[tokenId][walletType].frozen, "Wallet is frozen");
        _;
    }

    modifier onlyTrustedModule(address module) {
    require(trustedModules[module], "Untrusted module");
    _;
}

    constructor(address _feeVault) ERC20("Iconoclast Commander", "ICMR")  {
        require(_feeVault != address(0), "Invalid fee vault address");
        feeVault = _feeVault;
        currentTokenId = 1;
    }

  

    function decimals() public pure override returns (uint8) {
        return DECIMALS;
    }



    // ----------------- Core Wallet Logic ------------------

    // Function to mint tokens, create wallet, and create oracle for each tokenId
 
function mintTokenAndCreateWalletAndOracle(uint256 amount, string memory label) external payable nonReentrant  {
        require(totalMinted + amount <= MAX_SUPPLY, "Exceeds max supply");
          require(msg.value >= MINT_FEE * amount, "Insufficient mint fee");

            (bool feeSent, ) = feeVault.call{ value: MINT_FEE * amount }("");
    require(feeSent, "Fee transfer failed");

        for (uint256 i = 1; i <= amount; i++) {
            uint256 tokenId = totalMinted + i;
            _mint(msg.sender, 1);

    address wallet = this.createWallet(tokenId); 
    address oracleAddress = this.createOracle(tokenId);
    ownerToTokenIds[msg.sender].push(tokenId);
    ownerTokenIndex[msg.sender][tokenId] = ownerToTokenIds[msg.sender].length - 1;

    // Store token details
    tokenDetails[tokenId] = TokenDetails({
        walletAddress: wallet,
        oracleAddress: oracleAddress,
        tokenId: tokenId,
        label: label
    });

 

    // Emit events
    emit WalletCreated(tokenId, wallet, label);
    emit OracleCreated(tokenId, oracleAddress);
    emit TokenMinted(tokenId, amount);

    // Increment the tokenId for the next mint
    currentTokenId++;

}
}


    // Fetch all messages received by a capsule ID
    function getMessages(uint256 capsuleId) external view returns (Message[] memory) {
        return capsuleInbox[capsuleId];
    }


      // Private function to create a new wallet for each tokenId (via CREATE2 or any method you like)
     function createWallet(uint256 tokenId) external returns (address) {
        bytes32 salt = keccak256(abi.encodePacked(tokenId, msg.sender, block.timestamp));
        address wallet = Create3.cloneAndDeploy(salt);
        return wallet;
    }
    // Private function to create an oracle for each tokenId (for simplicity, using a mock address generation)
    function createOracle(uint256 tokenId) external returns (address) {
        bytes32 salt = keccak256(abi.encodePacked("oracle", tokenId, msg.sender, block.timestamp));
        address oracle = Create4.cloneAndDeploy(salt);
        return oracle;
    }

  

   function addModule(uint256 tokenId, address module) external onlyOwner {
    require(module != address(0), "Invalid module");
    require(IWalletModule(module).supportedFunctions().length > 0, "No supported functions");

    // Push to array for tracking
    walletModules[tokenId][bytes4(keccak256(abi.encodePacked("add_module")))] = module;

    emit ModuleAdded(tokenId, module);

    // Register supported functions
    bytes4[] memory selectors = IWalletModule(module).supportedFunctions();
    for (uint i = 0; i < selectors.length; i++) {
        moduleSelectors[tokenId][selectors[i]] = module;
    }
}

    function getTokenFullDetails(uint256 tokenId) external view returns (
    address walletAddress, 
    address oracleAddress, 
    string memory label, 
    uint256 tokenBalance
) {
    TokenDetails memory details = tokenDetails[tokenId];
    Wallet memory wallet = tokenWallets[tokenId][TwinWalletType.PRIMARY];
    return (details.walletAddress, details.oracleAddress, details.label, balanceOf(wallet.wallet));
}



   function executeModule(address module, bytes calldata data) external onlyOwner onlyTrustedModule(module) {
    (bool success, ) = module.delegatecall(data);
    require(success, "Module execution failed");
}

    function executeSelector(uint256 tokenId, bytes4 selector, bytes calldata data)
        external onlyOwner returns (bytes memory) {
        address module = moduleSelectors[tokenId][selector];
        require(module != address(0), "Module not found");
        (bool success, bytes memory result) = module.delegatecall(data);
        require(success, "Execution failed");
        return result;
    }

      function _isModuleEnabled(uint256 tokenId, /* address module */ uint) internal view returns (bool) {
        return moduleEnabled[tokenId][bytes4(keccak256(abi.encodePacked("add_module")))];
    }

   function _createTwinWallet(
    uint256 tokenId, 
    address walletAddress, 
    string memory label, 
    TwinWalletType walletType
) internal {
    // Ensure the wallet is being created for the correct wallet type (PRIMARY or SECONDARY)
tokenWallets[tokenId][walletType] = Wallet({
    owner: owner(), // Call the function to get the address
    label: label,
    frozen: false,
    wallet: address(0),
    ethBalance: 0,
    tokenId: tokenId
});
    // Emit the WalletCreated event with the tokenId, wallet address, and label
    emit WalletCreated(tokenId, walletAddress, label);
}


    function freezeWallet(uint256 tokenId, TwinWalletType walletType, string memory password)
        external onlyWalletOwner(tokenId, walletType) nonReentrant returns (bool) {
        tokenWallets[tokenId][walletType].frozen = true;
        walletPasswords[uint256(keccak256(abi.encodePacked(tokenId, walletType)))] = keccak256(abi.encodePacked(password));
        emit WalletFrozen(tokenId, walletType);
        return true;
    }

    function unfreezeWallet(uint256 tokenId, TwinWalletType walletType, string memory password)
        external onlyWalletOwner(tokenId, walletType) nonReentrant returns (bool) {
        bytes32 key = keccak256(abi.encodePacked(tokenId, walletType));
        require(walletPasswords[uint256(key)] == keccak256(abi.encodePacked(password)), "Incorrect password");
        tokenWallets[tokenId][walletType].frozen = false;
        delete walletPasswords[uint256(key)];
        emit WalletUnfrozen(tokenId, walletType);
        return true;
    }

    function depositETH(uint256 tokenId, TwinWalletType walletType) external payable notFrozen(tokenId, walletType) nonReentrant {
        tokenWallets[tokenId][walletType].ethBalance += msg.value;
        emit ETHDeposited(tokenId, walletType, msg.sender, msg.value);
    }

    function withdrawETH(uint256 tokenId, TwinWalletType walletType, uint256 amount)
        external onlyWalletOwner(tokenId, walletType) notFrozen(tokenId, walletType) nonReentrant {
        Wallet storage wallet = tokenWallets[tokenId][walletType];
        require(wallet.ethBalance >= amount, "Insufficient balance");
        wallet.ethBalance -= amount;
        payable(msg.sender).transfer(amount);
        emit ETHWithdrawn(tokenId, walletType, msg.sender, amount);
    }

    // ------------------ Oracle Interaction ------------------

    function setOracleDrone(uint256 tokenId, address drone) external {
        require(drone != address(0), "Invalid drone");
        oracleDrones[tokenId] = drone;
    }
    function linkContractToToken(
    uint256 tokenId,
    string calldata moduleType, // e.g. "oracle", "drone", "strategy"
    address contractAddr  
) external {
    require(contractAddr != address(0), "Invalid contract address");

    // Link the contract to the tokenId and moduleType
    linkedContracts[tokenId][moduleType] = contractAddr;

    // Emit the event to notify about the linkage
    emit ContractLinkedToToken(tokenId, moduleType, contractAddr);
}
// Event to notify about the contract linkage
event ContractLinkedToToken(uint256 indexed tokenId, string moduleType, address indexed contractAddr);
  
    function assignTask(uint256 tokenId, uint256 droneId, string calldata taskType, string calldata parameters)
        external returns (uint256) {
        return IOracleDrone(oracleDrones[tokenId]).assignTask(droneId, taskType, parameters);
    }

    function completeTask(uint256 tokenId, uint256 taskId) external {
        IOracleDrone(oracleDrones[tokenId]).completeTask(taskId);
    }

    function executeTask(uint256 tokenId, uint256 taskId) external returns (bool) {
        return IOracleDrone(oracleDrones[tokenId]).executeTask(taskId);
    }

    function commitToRandom(uint256 tokenId, bytes32 commitment) external {
        IOracleDrone(oracleDrones[tokenId]).commitToRandomNumber(commitment);
    }

    function revealRandom(uint256 tokenId, uint256 number, uint256 nonce) external {
        IOracleDrone(oracleDrones[tokenId]).revealRandomNumber(number, nonce);
    }

    function getRandom(uint256 tokenId, address user) external view returns (uint256) {
        return IOracleDrone(oracleDrones[tokenId]).getRandomNumber(user);
    }

    // ------------------ Merkle Root Verification ------------------

    function setMerkleRoot(uint256 tokenId, bytes32 root) external {
        walletMerkleRoots[tokenId] = root;
    }

    function verifyMerkleLeaf(uint256 tokenId, bytes32 leaf, bytes32[] calldata proof) external view returns (bool) {
        return MerkleProof.verify(proof, walletMerkleRoots[tokenId], leaf);
    }

    // ------------------ View ------------------

  function getTokenDetails(uint256 tokenId) external view returns (
    address walletAddress, 
    address oracleAddress, 
    string memory label
) {
    TokenDetails memory details = tokenDetails[tokenId];
    return (details.walletAddress, details.oracleAddress, details.label);
}

// Fetch wallet details for a specific tokenId and wallet type
function getWalletDetails(uint256 tokenId, TwinWalletType walletType) external view returns (
    address owner, 
    string memory label, 
    bool frozen, 
    address wallet, 
    uint256 ethBalance
) {
    Wallet memory walletDetails = tokenWallets[tokenId][walletType];
    return (walletDetails.owner, walletDetails.label, walletDetails.frozen, walletDetails.wallet, walletDetails.ethBalance);
}

// Get all tokens owned by an address
function getTokensOwnedBy(address owner) external view returns (uint256[] memory) {
    return ownerToTokenIds[owner];
}

}
   