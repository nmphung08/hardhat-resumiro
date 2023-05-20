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

    log("Adding data...")
    let skillContract = await ethers.getContract("Skill", deployer)
    await skillContract.addSkill("Java")
    await skillContract.addSkill("Python")
    await skillContract.addSkill("React.js")
    await skillContract.addSkill("Node.js")
    await skillContract.addSkill("Vue.js")
    await skillContract.addSkill("Docker")
    await skillContract.addSkill("PostgreSQL")
    await skillContract.addSkill("AWS")
    await skillContract.addSkill("MySQL")
    await skillContract.addSkill("Solidity")
    await skillContract.addSkill("C/C++")
    log("Added!")
}

module.exports.tags = ["all", "skill"]
