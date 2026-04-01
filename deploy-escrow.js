const hre = require("hardhat");

async function main() {
  const [buyer, seller, arbiter] = await hre.ethers.getSigners();

  const Escrow = await hre.ethers.getContractFactory("MultisigEscrow");
  const escrow = await Escrow.deploy(seller.address, arbiter.address, {
    value: hre.ethers.parseEther("5.0")
  });

  await escrow.waitForDeployment();
  console.log("2-of-3 Escrow deployed to:", await escrow.getAddress());
  console.log("Status: Funded with 5 ETH");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
