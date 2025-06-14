const hre = require("hardhat");

async function main() {
  const [admin] = await hre.ethers.getSigners();
  const nft = await hre.ethers.getContractAt("GenesisNFT", "PASTE_GENESISNFT_CONTRACT_ADDRESS");

  const mints = [
    {
      to: "0x260f6A4AdDC1328Cd14f20fb356179954d1bcd28", // Anton Christoff - Initiator
      uri: "ipfs://YOUR_CID/initiator.json",
      role: "Initiator",
      description: "Seeds Spiral Epochs through intention and creative spark.",
      traits: '{"Imagination":10,"Signal Clarity":8}'
    },
    {
      to: "0xIVAN_WALLET_ADDRESS", // Ivan Pasev - Architect
      uri: "ipfs://YOUR_CID/architect.json",
      role: "Architect",
      description: "Spiral builder, architect of logic and structure.",
      traits: '{"Creativity":10,"Clarity":8}'
    },
    {
      to: "0x15172aE1a0456ebE6299527A4FDc9e590818Faa1", // TGC DAO - Anchor
      uri: "ipfs://YOUR_CID/anchor.json",
      role: "Anchor",
      description: "Continuity & stability of Spiral governance.",
      traits: '{"Resonance":9,"Stability":10}'
    },
    {
      to: "0xb153bD45FF13298385439A2145222AE577859dBC", // TGC DAO - Steward
      uri: "ipfs://YOUR_CID/steward.json",
      role: "Steward",
      description: "Ethics, treasury, and cultural integrity guardian.",
      traits: '{"Integrity":10,"Wisdom":9}'
    }
  ];

  for (const data of mints) {
    const tx = await nft.mintGenesisWithRole(data.to, data.uri, data.role, data.description, data.traits);
    await tx.wait();
    console.log(`✅ Minted ${data.role} NFT to ${data.to}`);
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
