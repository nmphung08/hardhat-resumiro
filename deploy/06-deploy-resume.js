const { ethers } = require("hardhat")

module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    const user = await ethers.getContract("User")
    log("==================================")
    const resume = await deploy("Resume", {
        from: deployer,
        log: true,
        args: [user.address],
        confirmations: 1,
    })
    log(`Deployed Resume at: ${resume.address}`)
}

module.exports.tags = ["all", "resume"]
