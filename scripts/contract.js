async function getContract() {
    const { ethers, getNamedAccounts } = require("hardhat")
    const deployer = (await getNamedAccounts()).deployer

    let contract = await ethers.getContract("Resumiro", deployer)
    return contract
}

module.exports = { getContract }
