const { ethers, run } = require("hardhat");

async function main() {
  const safeAddress = process.env.GNOSIS_SAFE;
  const signer = await ethers.getSigner();

  if (signer.address !== safeAddress) {
    throw new Error("This deploy script must be triggered by Gnosis Safe multisig signer.");
  }

  const DAO = await ethers.getContractFactory("StitchiaDAO");
  const dao = await DAO.deploy();
  await dao.deployed();

  console.log("✅ DAO deployed at:", dao.address);
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
