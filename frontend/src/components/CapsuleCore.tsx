import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
import { useMetamask } from "../hooks/useMetamask";

interface ABIInput {
  name: string;
  type: string;
}

interface ABIItem {
  name: string;
  type: string;
  stateMutability?: string;
  inputs?: ABIInput[];
}

// Hardcoded contract address and ABI
const HARD_CODED_CONTRACT_ADDRESS = "0x1b877402e3bed0a18859b25be8a9c4085de8d646"; // Replace with your contract address
const HARD_CODED_ABI = `[
    {
      "inputs": [],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "owner",
          "type": "address"
        }
      ],
      "name": "OwnableInvalidOwner",
      "type": "error"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "account",
          "type": "address"
        }
      ],
      "name": "OwnableUnauthorizedAccount",
      "type": "error"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "capsuleId",
          "type": "uint256"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "claimer",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "timestamp",
          "type": "uint256"
        }
      ],
      "name": "CapsuleClaimed",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "capsuleId",
          "type": "uint256"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "creator",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "string",
          "name": "dataURI",
          "type": "string"
        }
      ],
      "name": "CapsuleCreated",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "newFee",
          "type": "uint256"
        }
      ],
      "name": "ClaimFeeUpdated",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "previousOwner",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "newOwner",
          "type": "address"
        }
      ],
      "name": "OwnershipTransferred",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "proposalId",
          "type": "uint256"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "proposer",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "string",
          "name": "description",
          "type": "string"
        }
      ],
      "name": "ProposalCreated",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "proposalId",
          "type": "uint256"
        }
      ],
      "name": "ProposalExecuted",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "proposalId",
          "type": "uint256"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "voter",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "bool",
          "name": "support",
          "type": "bool"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "weight",
          "type": "uint256"
        }
      ],
      "name": "Voted",
      "type": "event"
    },
    {
      "inputs": [],
      "name": "COMMITMENT_EXPIRATION",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "MAX_DELAY",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "MAX_DEPOSIT_AMOUNT",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "MIN_DELAY",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "MIN_DEPOSIT_AMOUNT",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "QUORUM_PERCENTAGE",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "activeProposals",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "capsuleAdmin",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "capsuleCounter",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "capsuleId",
          "type": "uint256"
        }
      ],
      "name": "claimCapsule",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function",
      "payable": true
    },
    {
      "inputs": [],
      "name": "claimFee",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "completedProposals",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [
        {
          "internalType": "string",
          "name": "_dataURI",
          "type": "string"
        }
      ],
      "name": "createCapsule",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "currentEpochHash",
      "outputs": [
        {
          "internalType": "bytes32",
          "name": "",
          "type": "bytes32"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "governance",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "isDepositPaused",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "isSystemPaused",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "isVotingPaused",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "maxVotingPower",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "minVotingPower",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "nextProposalId",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "oracle",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "owner",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "proposalThreshold",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "randomDelay",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "renounceOwnership",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "rewardToken",
      "outputs": [
        {
          "internalType": "contract IERC20",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "newFee",
          "type": "uint256"
        }
      ],
      "name": "setClaimFee",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "stakeToken",
      "outputs": [
        {
          "internalType": "contract IERC20",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "totalDeposits",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "newOwner",
          "type": "address"
        }
      ],
      "name": "transferOwnership",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "treasury",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "validator",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "votingPeriod",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "votingToken",
      "outputs": [
        {
          "internalType": "contract IERC20",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    }
  ]`;

const CapsuleCore: React.FC = () => {
    const { account, connectWallet, signer } = useMetamask();
  const [contract, setContract] = useState<ethers.Contract | null>(null);
  const [response, setResponse] = useState<string>("");
  const [abiMethods, setAbiMethods] = useState<ABIItem[]>([]);
  const [inputValues, setInputValues] = useState<Record<string, string[]>>({});
  const [interfaceCode, setInterfaceCode] = useState<string>("");

  // Generate a TypeScript interface based on the ABI methods
  const generateInterfaceCode = (abi: ABIItem[]) => {
    const code = `
interface ContractInterface {
  ${abi
    .map(
      (fn) =>
        `${fn.name}(${fn.inputs
          ?.map((input) => `${input.name}: ${input.type}`)
          .join(", ")}): Promise<any>;`
    )
    .join("\n  ")}
}
    `;
    console.log("Generated TypeScript Interface:\n", code);
    return code;
  };

  // Initialize the contract instance using the hardcoded address and ABI
  const initializeContract = async () => {
    try {
      if (!signer) {
        setResponse("❌ Please connect your wallet.");
        return;
      }

      // Parse the hardcoded ABI and filter only functions
      const parsedABI: ABIItem[] = JSON.parse(HARD_CODED_ABI);
      const filteredMethods = parsedABI.filter((fn) => fn.type === "function");

      // Create a new contract instance using the hardcoded address and ABI
      const contractInstance = new ethers.Contract(
        HARD_CODED_CONTRACT_ADDRESS,
        parsedABI,
        signer
      );

      setAbiMethods(filteredMethods);
      setContract(contractInstance);
      setInterfaceCode(generateInterfaceCode(filteredMethods));
      setResponse("✅ Contract Initialized!");
    } catch (error: any) {
      console.error("🚨 Error initializing contract:", error);
      setResponse("❌ Invalid ABI or contract address.");
    }
  };


  const executeFunction = async (methodName: string, isView: boolean) => {
    if (!contract) {
      alert("⚠️ Contract not initialized!");
      return;
    }
    setResponse("");

    try {
      const args = inputValues[methodName] || [];
      const result = isView
        ? await contract[methodName](...args)
        : await (await contract[methodName](...args)).wait();

      const formattedResult = Array.isArray(result)
        ? result.map((item) => (typeof item === "bigint" ? item.toString() : item))
        : typeof result === "bigint"
        ? result.toString()
        : result;

      setResponse(
        isView
          ? `✅ Fetched: ${JSON.stringify(formattedResult)}`
          : `✅ Transaction successful`
      );
    } catch (error: any) {
      console.error(`🚨 Error executing ${methodName}:`, error);
      setResponse(`❌ Error: ${error.message || error}`);
    }
  };

  useEffect(() => {
    if (signer) {
      initializeContract();
    }
  }, [signer]);


   return (
    <div style={{
      padding: "24px",
      maxWidth: "800px",
      margin: "0 auto",
      backgroundColor: "#1E1E2F", // Deep navy background
      borderRadius: "12px",
      boxShadow: "0px 4px 12px rgba(0, 0, 0, 0.3)",
      color: "LavenderBlush",
      fontFamily: "'Bradley DJR Variable', sans-serif"
    }}>
      
      {/* 🔹 Logo at the Top */}
      <div style={{ textAlign: "center", marginBottom: "16px" }}>
        <img src="/logo.jpeg" alt="App Logo" style={{ width: "100px", height: "100px", borderRadius: "50%" }} />
      </div>

      <h2 style={{ fontSize: "26px", fontWeight: "bold", marginBottom: "16px", textAlign: "center" }}>
        Iconoclast CapsuleCore
      </h2>

      {/* 🔹 Wallet Connection */}
      {account ? (
        <p style={{ color: "lightgreen", fontWeight: "bold", marginBottom: "10px", textAlign: "center" }}>
          ✅ Wallet Connected: {account}
        </p>
      ) : (
        <button
          onClick={connectWallet}
          style={{
            backgroundColor: "indigo",
            color: "LavenderBlush",
            padding: "12px",
            borderRadius: "12px",
            border: "2px solid darkgray",
            width: "100%",
            fontWeight: "bold",
            fontSize: "16px",
            transition: "all 0.3s ease-in-out"
          }}
        >
          🔗 Connect Wallet
        </button>
      )}

     

      {/* 🔹 Response Messages */}
      {response && (
        <p
          style={{
            marginTop: "10px",
            color: response.includes("✅") ? "lightgreen" : "red",
            fontWeight: "bold",
            textAlign: "center"
          }}
        >
          {response}
        </p>
      )}

      {/* 🔹 Contract Methods Section */}
      {contract && (
        <>
          <div
            style={{
              marginTop: "20px",
              padding: "15px",
              border: "1px solid #555",
              borderRadius: "12px",
              background: "#2A2A3D",
              boxShadow: "0px 4px 10px rgba(0, 0, 0, 0.2)"
            }}
          >
            {/* 🔹 Replacing "Contract Methods" Title with Logo */}
            <div style={{ textAlign: "center", marginBottom: "10px" }}>
              <img src="/logo.jpeg" alt="Logo" style={{ width: "80px", height: "80px", borderRadius: "50%" }} />
            </div>

            {abiMethods.map((fn) => (
              <div key={fn.name} style={{ padding: "10px", borderBottom: "1px solid #444" }}>
                <h4 style={{ fontSize: "18px", fontWeight: "bold", marginBottom: "5px" }}>{fn.name}</h4>

                {/* 🔹 Inputs for functions */}
                {fn.inputs?.map((input, index) => (
                  <input
                    key={index}
                    type="text"
                    placeholder={`${input.name} (${input.type})`}
                    value={inputValues[fn.name]?.[index] || ""}
                    onChange={(e) =>
                      setInputValues((prev) => {
                        const currentValues = prev[fn.name] ? [...prev[fn.name]] : [];
                        currentValues[index] = e.target.value;
                        return { ...prev, [fn.name]: currentValues };
                      })
                    }
                    style={{
                      marginBottom: "5px",
                      padding: "10px",
                      border: "1px solid darkgray",
                      borderRadius: "12px",
                      width: "100%",
                      backgroundColor: "#333",
                      color: "LavenderBlush",
                      fontSize: "1rem"
                    }}
                  />
                ))}

                {/* 🔹 Execute Button */}
                <button
                  onClick={() =>
                    executeFunction(fn.name, fn.stateMutability === "view")
                  }
                  style={{
                    backgroundColor: "indigo",
                    color: "LavenderBlush",
                    padding: "10px",
                    borderRadius: "12px",
                    border: "2px solid darkgray",
                    width: "100%",
                    fontWeight: "bold",
                    fontSize: "16px",
                    marginTop: "5px",
                    transition: "all 0.3s ease-in-out"
                  }}
                >
                  {fn.stateMutability === "view" ? "Fetch" : "Execute"}
                </button>
              </div>
            ))}
          </div>

          {/* 🔹 Underlying Code Section (Now with Logo Instead of Gold Title) */}
          {interfaceCode && (
            <div
              style={{
                marginTop: "20px",
                padding: "15px",
                border: "1px solid #555",
                borderRadius: "12px",
                background: "#2A2A3D",
                boxShadow: "0px 4px 10px rgba(0, 0, 0, 0.2)"
              }}
            >
              {/* 🔹 Replacing "Underlying Code for the GUI" Title with Logo */}
              <div style={{ textAlign: "center", marginBottom: "10px" }}>
                <img src="/logo.jpeg" alt="Logo" style={{ width: "80px", height: "80px", borderRadius: "50%" }} />
              </div>

              <pre
                style={{
                  background: "#1E1E2F",
                  padding: "12px",
                  borderRadius: "8px",
                  overflowX: "auto",
                  color: "LavenderBlush",
                  fontSize: "14px"
                }}
              >
              </pre>
            </div>
          )}
        </>
      )}
    </div>
  );
};

export default CapsuleCore;