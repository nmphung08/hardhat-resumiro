const { ethers } = require("hardhat")

module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    const user = await ethers.getContract("User")
    const company = await ethers.getContract("Company")
    log("==================================")
    const experience = await deploy("Experience", {
        from: deployer,
        log: true,
        args: [user.address, company.address],
        confirmations: 1,
    })
    log(`Deployed Experience at: ${experience.address}`)
}

module.exports.tags = ["all", "experience", "mains"]
