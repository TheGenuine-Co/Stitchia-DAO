// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract SpiralRegistry {
    enum SpiralTier { Founding, Early, Regen, Earned }

    struct Member {
        address user;
        SpiralTier tier;
        string role;
        uint256 mintedAt;
    }

    mapping(address => Member) public members;

    event Registered(address indexed user, SpiralTier tier, string role);

    function register(address user, SpiralTier tier, string memory role) public {
        require(members[user].user == address(0), "Already registered");
        members[user] = Member(user, tier, role, block.timestamp);
        emit Registered(user, tier, role);
    }

    function getTier(address user) public view returns (SpiralTier) {
        return members[user].tier;
    }

    function getRole(address user) public view returns (string memory) {
        return members[user].role;
    }
}
