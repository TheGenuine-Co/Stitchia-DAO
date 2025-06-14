interface IStitchiaCampaign {
    function contribute(uint256 amount) external payable;
    function claimRewards() external;
    function getFundingStatus() external view returns (uint256 raised, uint256 goal);
    function assignRole(address participant, bytes32 role) external;
    function vote(uint256 proposalId, bool support) external;
}
