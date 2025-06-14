// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract StitchiaDAO is Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;

    // ====== ENUMS & STRUCTS ======
    enum Role { None, Initiator, Anchor, Architect, Steward }

    struct Contributor {
        Role role;
        uint reputation;
        bool active;
    }

    struct Proposal {
        string title;
        string description;
        uint256 timestamp;
        address proposer;
        bool executed;
        uint approvals;
        uint rejections;
    }

    // ====== STATE ======
    mapping(address => Contributor) public contributors;
    EnumerableSet.AddressSet private contributorList;

    Proposal[] public proposals;
    uint public quorumPercent = 60; // % minimum participation
    uint public majorUpgradeThreshold = 75; // % required to pass
    uint public epochDuration = 30 days; // optional, not enforced in pulse mode

    // ====== EVENTS ======
    event ContributorAdded(address indexed account, Role role);
    event ProposalSubmitted(uint indexed proposalId, string title);
    event Voted(address indexed voter, uint indexed proposalId, bool support);
    event ProposalExecuted(uint indexed proposalId);

    // ====== MODIFIERS ======
    modifier onlyActive() {
        require(contributors[msg.sender].active, "Not an active contributor");
        _;
    }

    // ====== CONTRIBUTOR MGMT ======
    function addContributor(address _account, Role _role, uint _reputation) external onlyOwner {
        contributors[_account] = Contributor({
            role: _role,
            reputation: _reputation,
            active: true
        });
        contributorList.add(_account);
        emit ContributorAdded(_account, _role);
    }

    // ====== PROPOSAL FLOW ======
    function submitProposal(string calldata _title, string calldata _desc) external onlyActive {
        proposals.push(Proposal({
            title: _title,
            description: _desc,
            timestamp: block.timestamp,
            proposer: msg.sender,
            executed: false,
            approvals: 0,
            rejections: 0
        }));
        emit ProposalSubmitted(proposals.length - 1, _title);
    }

    function vote(uint _id, bool support) external onlyActive {
        Proposal storage p = proposals[_id];
        require(!p.executed, "Already executed");

        if (support) {
            p.approvals += contributors[msg.sender].reputation;
        } else {
            p.rejections += contributors[msg.sender].reputation;
        }

        emit Voted(msg.sender, _id, support);
    }

    function executeProposal(uint _id) external {
        Proposal storage p = proposals[_id];
        require(!p.executed, "Already executed");

        uint totalVotes = p.approvals + p.rejections;
        uint totalRep = 0;

        for (uint i = 0; i < contributorList.length(); i++) {
            totalRep += contributors[contributorList.at(i)].reputation;
        }

        require(totalVotes * 100 / totalRep >= quorumPercent, "Quorum not met");

        if (p.approvals * 100 / totalRep >= majorUpgradeThreshold) {
            p.executed = true;
            emit ProposalExecuted(_id);
        }
    }

    // ====== VIEW HELPERS ======
    function getContributorCount() public view returns (uint) {
        return contributorList.length();
    }

    function getContributorAt(uint index) public view returns (address) {
        return contributorList.at(index);
    }

    function getContributors() public view returns (address[] memory) {
        return contributorList.values();
    }

    function getProposalCount() public view returns (uint) {
        return proposals.length;
    }
}
