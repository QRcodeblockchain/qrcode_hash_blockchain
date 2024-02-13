require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const { GOERLI_URL, PRIVATE_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: GOERLI_URL,
      // accounts: [`0x${PRIVATE_KEY}`],
      accounts: [PRIVATE_KEY],
    },
  },
};
