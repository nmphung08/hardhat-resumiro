const { ethers } = require("hardhat")

module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    const user = await ethers.getContract("User")
    const job = await ethers.getContract("Job")
    log("==================================")
    const skill = await deploy("Skill", {
        from: deployer,
        log: true,
        args: [user.address, job.address],
        confirmations: 1,
    })
    log(`Deployed Skill at: ${skill.address}`)
}

module.exports.tags = ["all", "skill"]
