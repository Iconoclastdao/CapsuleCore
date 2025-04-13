// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./BaseMappings.sol";
import "./BaseVariables.sol";
import "./BaseEvents.sol";
import "./BaseStructs.sol";

/**
 * @title BaseFunction
 * @dev Core functional logic
 */
contract BaseFunction is BaseMappings,   BaseVariables, BaseEvents {
    uint256 public capsuleCounter;
    uint256 public claimFee = 0.01 ether;

    modifier onlyAdmin() {
        require(msg.sender == owner(), "Not authorized");
        _;
    }

    function createCapsule(string memory _dataURI) public {
        uint256 id = capsuleCounter++;
        capsules[id] = Capsule({
            id: id,
            owner: msg.sender,
            dataURI: _dataURI,
            claimed: false
        });

        emit CapsuleCreated(id, msg.sender, _dataURI);
    }

    function claimCapsule(uint256 capsuleId) public payable {
        require(msg.value >= claimFee, "Insufficient claim fee");
        require(!capsules[capsuleId].claimed, "Already claimed");

        capsules[capsuleId].claimed = true;
        claimedCapsules[capsuleId] = true;

        userClaims[msg.sender].push(Claim({
            capsuleId: capsuleId,
            claimer: msg.sender,
            timestamp: block.timestamp
        }));

        emit CapsuleClaimed(capsuleId, msg.sender, block.timestamp);
    }

    function setClaimFee(uint256 newFee) external onlyAdmin {
        claimFee = newFee;
        emit ClaimFeeUpdated(newFee);
    }
}