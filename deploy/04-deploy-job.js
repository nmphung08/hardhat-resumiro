const { ethers } = require("hardhat")

module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    const user = await ethers.getContract("User")
    const company = await ethers.getContract("Company")
    log("==================================")
    const job = await deploy("Job", {
        from: deployer,
        log: true,
        args: [user.address, company.address],
        confirmations: 1,
    })
    log(`Deployed Job at: ${job.address}`)
}

module.exports.tags = ["all", "job"]
