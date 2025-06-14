const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying PulseScorer with:", deployer.address);

  const PulseScorer = await hre.ethers.getContractFactory("PulseScorer");
  const pulse = await PulseScorer.deploy();

  await pulse.deployed();
  console.log("✅ PulseScorer deployed to:", pulse.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
