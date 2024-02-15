const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const HashStorage = await ethers.getContractFactory("HashStorage");
  const hashStorage = await HashStorage.deploy();

  console.log("Deploying HashStorage...", hashStorage);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
