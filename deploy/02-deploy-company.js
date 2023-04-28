const { ethers } = require("hardhat")

module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    const user = await ethers.getContract("User")
    log("==================================")
    const company = await deploy("Company", {
        from: deployer,
        log: true,
        args: [user.address],
        confirmations: 1,
    })
    log(`Deployed Company at: ${company.address}`)
}

module.exports.tags = ["all", "company"]
