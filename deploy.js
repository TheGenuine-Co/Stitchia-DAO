const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying StitchiaDAO with account:", deployer.address);

  const StitchiaDAO = await hre.ethers.getContractFactory("StitchiaDAO");
  const dao = await StitchiaDAO.deploy();

  await dao.deployed();

  console.log("StitchiaDAO deployed to:", dao.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
