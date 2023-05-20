const { ethers, getNamedAccounts } = require("hardhat")

async function getContracts() {
    const deployer = (await getNamedAccounts()).deployer

    let user = await ethers.getContract("User", deployer)
    let company = await ethers.getContract("Company", deployer)
    let certificate = await ethers.getContract("Certificate", deployer)
    let experience = await ethers.getContract("Experience", deployer)
    let job = await ethers.getContract("Job", deployer)
    let resume = await ethers.getContract("Resume", deployer)
    let skill = await ethers.getContract("Skill", deployer)
    let resumiro = await ethers.getContract("Resumiro", deployer)
    return {
        user,
        company,
        certificate,
        experience,
        job,
        resume,
        skill,
        resumiro,
    }
}

module.exports = { getContracts }
