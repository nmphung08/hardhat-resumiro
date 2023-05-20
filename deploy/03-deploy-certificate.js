const { ethers } = require("hardhat")

module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    const user = await ethers.getContract("User")
    log("==================================")
    const certificate = await deploy("Certificate", {
        from: deployer,
        log: true,
        args: [user.address],
        confirmations: 1,
    })
    log(`Deployed Certificate at: ${certificate.address}`)
}

module.exports.tags = ["all", "certificate"]
