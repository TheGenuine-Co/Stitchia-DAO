// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StitchiaCampaign is Ownable {
    enum Role { None, Anchor, Architect, Initiator, Steward }

    struct Contributor {
        uint256 contributed;
        Role role;
        bool exists;
    }

    uint256 public fundingGoal;
    uint256 public totalRaised;
    uint256 public startTime;
    uint256 public endTime;
    IERC20 public fundingToken; // address(0) for ETH

    mapping(address => Contributor) public contributors;
    mapping(address => bool) public voters;
    uint256 public votesFor;
    uint256 public votesAgainst;

    // Voting quorum (percentage)
    uint256 public quorumPercent;

    event ContributionReceived(address indexed contributor, uint256 amount);
    event RoleAssigned(address indexed contributor, Role role);
    event VoteCast(address indexed voter, bool support);

    constructor(
        uint256 _fundingGoal,
        uint256 _startTime,
        uint256 _endTime,
        address _fundingToken,
        uint256 _quorumPercent
    ) {
        require(_startTime < _endTime, "Invalid time range");
        fundingGoal = _fundingGoal;
        startTime = _startTime;
        endTime = _endTime;
        fundingToken = IERC20(_fundingToken);
        quorumPercent = _quorumPercent;
    }

    modifier onlyDuringCampaign() {
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Campaign not active");
        _;
    }

    function contribute(uint256 amount) external payable onlyDuringCampaign {
        if (address(fundingToken) == address(0)) {
            require(msg.value == amount, "Incorrect ETH sent");
        } else {
            require(fundingToken.transferFrom(msg.sender, address(this), amount), "Token transfer failed");
        }

        if (!contributors[msg.sender].exists) {
            contributors[msg.sender] = Contributor(amount, Role.None, true);
        } else {
            contributors[msg.sender].contributed += amount;
        }

        totalRaised += amount;
        emit ContributionReceived(msg.sender, amount);
    }

    function assignRole(address contributor, Role role) external onlyOwner {
        require(contributors[contributor].exists, "Contributor not found");
        contributors[contributor].role = role;
        emit RoleAssigned(contributor, role);
    }

    // Role-weighted voting weights
    function roleWeight(Role role) internal pure returns (uint256) {
        if (role == Role.Anchor) return 40;
        if (role == Role.Architect) return 30;
        if (role == Role.Initiator) return 20;
        if (role == Role.Steward) return 10;
        return 0;
    }

    function vote(bool support) external {
        Contributor storage contributor = contributors[msg.sender];
        require(contributor.exists, "Not a contributor");
        require(!voters[msg.sender], "Already voted");
        require(contributor.role != Role.None, "No role assigned");

        voters[msg.sender] = true;

        uint256 weight = roleWeight(contributor.role);
        if (support) {
            votesFor += weight;
        } else {
            votesAgainst += weight;
        }

        emit VoteCast(msg.sender, support);
    }

    function votingResult() public view returns (string memory) {
        uint256 totalVotes = votesFor + votesAgainst;
        uint256 quorum = (totalRaised > 0) ? (totalVotes * 100) / totalRaised : 0;
        if (quorum < quorumPercent) return "Quorum not reached";

        if (votesFor > votesAgainst) {
            return "Proposal Passed";
        } else {
            return "Proposal Rejected";
        }
    }

    // Withdraw funds by owner after successful campaign
    function withdraw() external onlyOwner {
        require(block.timestamp > endTime, "Campaign still active");
        require(totalRaised >= fundingGoal, "Funding goal not reached");

        if (address(fundingToken) == address(0)) {
            payable(owner()).transfer(address(this).balance);
        } else {
            uint256 balance = fundingToken.balanceOf(address(this));
            fundingToken.transfer(owner(), balance);
        }
    }

    // Fallback to receive ETH
    receive() external payable {}
}
