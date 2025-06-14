const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying GenesisNFT with:", deployer.address);

  const GenesisNFT = await hre.ethers.getContractFactory("GenesisNFT");
  const nft = await GenesisNFT.deploy();
  await nft.deployed();

  console.log("✅ GenesisNFT deployed to:", nft.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
