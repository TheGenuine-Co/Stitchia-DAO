const { ethers } = require("hardhat");

async function main() {
  const SpiralRegistry = await ethers.getContractFactory("SpiralRegistry");
  const registry = await SpiralRegistry.deploy();
  await registry.deployed();

  const GenesisNFT = await ethers.getContractFactory("GenesisNFT");
  const nft = await GenesisNFT.deploy(registry.address);
  await nft.deployed();

  console.log("SpiralRegistry deployed to:", registry.address);
  console.log("GenesisNFT deployed to:", nft.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
