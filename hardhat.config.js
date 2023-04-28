require("@nomicfoundation/hardhat-toolbox")
require("hardhat-deploy")
require("@nomiclabs/hardhat-ethers")
require("dotenv").config()

/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: {
    compilers: [{ version: "0.8.8" }],
    settings: {
      optimizer: {
        enabled: true,
      },
    },
  },
  defaultNetwork: "localhost",
  networks: {
    ganache: {
      url: "http://0.0.0.0:7545",
      accounts: [
        "0x8a9fb729d9a2892577c567b419c32e1c26201c71f5c2bc514e5d7508ad4cb020",
        "0xc19415d4f5e2ff393376559e7cf8d796cdf2649e0c16f1efeceb2691e4ebc5e0",
        "0x389d7cbe20fa1c0fa0b2c8032b497bcd653b2f9d094cd456f5b31ad869491bc3",
        "0x3bbe917766aa1a0976c6d9e93ed98f4637917e3fe115114f67f654a901b1a991",
        "0x7cc73893143c45bd41920b9f92eda77c5fc80c4a3e88782f1202e1ba6f0743c4"
      ],
      chainId: 1337,
    },
    hardhat: {
      allowUnlimitedContractSize: true,
      chainId: 31337,
    },
    localhost: {
      allowUnlimitedContractSize: true,
      chainId: 31337,
    }
  },

  namedAccounts: {
    deployer: {
      default: 0
    },
    user: {
      default: 1,
    }
  },

};

