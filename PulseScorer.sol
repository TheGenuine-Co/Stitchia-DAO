// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PulseScorer {
    struct Pulse {
        address sender;
        uint256 timestamp;
        string intent;
        uint8 alignment;
        uint8 coherence;
    }

    mapping(address => Pulse[]) public pulseLogs;
    mapping(string => uint8) public roleWeights;

    event PulseSubmitted(address indexed sender, uint indexed totalScore);

    function setRoleWeight(string memory role, uint8 weight) external {
        roleWeights[role] = weight;
    }

    function submitPulse(
        string memory intent,
        uint8 alignment,
        uint8 coherence,
        string memory role
    ) external {
        uint score = (alignment + coherence) * roleWeights[role];
        pulseLogs[msg.sender].push(Pulse(msg.sender, block.timestamp, intent, alignment, coherence));
        emit PulseSubmitted(msg.sender, score);
    }
}
