// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract SpiralRoleManager is AccessControl {
    bytes32 public constant ANCHOR_ROLE = keccak256("ANCHOR_ROLE");
    bytes32 public constant ARCHITECT_ROLE = keccak256("ARCHITECT_ROLE");
    bytes32 public constant INITIATOR_ROLE = keccak256("INITIATOR_ROLE");
    bytes32 public constant STEWARD_ROLE = keccak256("STEWARD_ROLE");

    constructor(address admin) {
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function assignRole(address account, bytes32 role) external onlyRole(DEFAULT_ADMIN_ROLE) {
        grantRole(role, account);
    }

    function revokeRoleFrom(address account, bytes32 role) external onlyRole(DEFAULT_ADMIN_ROLE) {
        revokeRole(role, account);
    }

    function hasSpiralRole(address account, bytes32 role) external view returns (bool) {
        return hasRole(role, account);
    }
}
