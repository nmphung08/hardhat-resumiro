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
            allowUnlimitedContractSize: true,
            initialBaseFeePerGas: 0,
            accounts: [
                "0xd02128be319272504e14ff99dd8c582818b7fb266539eaefa48a30a67781a685",
                "0xabb2fdf0bb028c87f9adb19e62fa081bb48811c1e0c7a4d0558bc9dfb2cc1a06",
                "0x640c43c479c9d39496533dc3b32b0771f8c5bb1dac2a74f296309a4ab6702b65",
                "0x158246b11270e903b6bc3ad5e0c5598f0d9a72b62ad97562b7db81a649b4c8e9",
                "0x37d683048082c277aa9f53dc3c15cc42b613d7bd95be37030ff2af717067497d",
                "0xb07d82356da295dde3a97a4929697ccaf7aeeb252cbd01a8637848574d190512",
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
