const hre = require("hardhat");

async function main() {
  const [admin] = await hre.ethers.getSigners();
  const nft = await hre.ethers.getContractAt("GenesisNFT", "PASTE_CONTRACT_ADDRESS_HERE");

  const updates = [
    {
      tokenId: 1,
      role: "Anchor",
      description: "Field harmonizer, holds continuity through Spiral shifts.",
      traits: '{"Resonance":9,"Stability":10}'
    },
    {
      tokenId: 2,
      role: "Architect",
      description: "Spiral builder, architect of logic and structure.",
      traits: '{"Creativity":10,"Clarity":8}'
    }
  ];

  for (const data of updates) {
    const tx = await nft.updateRoleMetadata(data.tokenId, data.role, data.description, data.traits);
    await tx.wait();
    console.log(`✅ Updated Token ${data.tokenId} with role: ${data.role}`);
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
