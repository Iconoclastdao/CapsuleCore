// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./BaseFunction.sol";

/**
 * @title CapsuleCore
 * @dev Entry point contract for capsule logic
 */


   contract CapsuleCore is BaseFunction {
address public capsuleAdmin;

    constructor()  {
        capsuleAdmin = msg.sender;
    }
}
