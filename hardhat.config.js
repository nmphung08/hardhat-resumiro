require("@nomicfoundation/hardhat-toolbox")
require("hardhat-deploy")
require("@nomiclabs/hardhat-ethers")
require("dotenv").config()

/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
    solidity: {
        // compilers: [{ version: "0.8.8" }, { version: "0.8.18" }],
        version: "0.8.18",
        settings: {
            optimizer: {
                enabled: true,
                runs: 1,
            },
        },
    },
    defaultNetwork: "hardhat",
    networks: {
        ganache: {
            url: "http://0.0.0.0:7545",
            accounts: [
                "0x8a9fb729d9a2892577c567b419c32e1c26201c71f5c2bc514e5d7508ad4cb020",
                "0xc19415d4f5e2ff393376559e7cf8d796cdf2649e0c16f1efeceb2691e4ebc5e0",
                "0x389d7cbe20fa1c0fa0b2c8032b497bcd653b2f9d094cd456f5b31ad869491bc3",
                "0x3bbe917766aa1a0976c6d9e93ed98f4637917e3fe115114f67f654a901b1a991",
                "0x7cc73893143c45bd41920b9f92eda77c5fc80c4a3e88782f1202e1ba6f0743c4",
            ],
            chainId: 1337,
        },
        hardhat: {
            allowUnlimitedContractSize: true,
            initialBaseFeePerGas: 0,
            chainId: 31337,
            // accounts: [
            //     "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80",
            //     "0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d",
            //     "0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a",
            //     "0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6",
            //     "0x47e179ec197488593b187f80a00eb0da91f1b9d0b13f8733639f19c30a34926a",
            //     "0x8b3a350cf5c34c9194ca85829a2df0ec3153be0318b5e2d3348e872092edffba",

            // ],
        },
        localhost: {
            allowUnlimitedContractSize: true,
            chainId: 31337,
            initialBaseFeePerGas: 0,
            // gas: 2100000,
            // gasPrice: 8000000000,
        },
        mumbai: {
            allowUnlimitedContractSize: true,
            initialBaseFeePerGas: 0,
            gasLimit: 3e7,
            url: "https://rpc-mumbai.maticvigil.com",
            accounts: [process.env.PRIVATE_KEY],
            chainId: 80001,
        },
        zkEVM: {
            allowUnlimitedContractSize: true,
            initialBaseFeePerGas: 0,
            gasLimit: 3e7,
            url: `https://rpc.public.zkevm-test.net`,
            accounts: [process.env.PRIVATE_KEY],
            chainId: 1442,
        },
    },

    namedAccounts: {
        deployer: {
            default: 0,
        },
        user: {
            default: 1,
        },
    },
}
