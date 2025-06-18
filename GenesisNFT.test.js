const { expect } = require("chai");

describe("GenesisNFT", function () {
  it("Should deploy and mint correctly", async function () {
    const [owner, addr1] = await ethers.getSigners();
    const Registry = await ethers.getContractFactory("SpiralRegistry");
    const registry = await Registry.deploy();
    await registry.deployed();

    const NFT = await ethers.getContractFactory("GenesisNFT");
    const nft = await NFT.deploy(registry.address);
    await nft.deployed();

    await nft.mint(addr1.address, "ipfs://example-uri");
    expect(await nft.ownerOf(0)).to.equal(addr1.address);
  });
});
