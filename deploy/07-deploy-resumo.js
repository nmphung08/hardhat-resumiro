const { ethers } = require("hardhat")

module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    const user = await ethers.getContract("User")
    const company = await ethers.getContract("Company")
    const experience = await ethers.getContract("Experience")
    const job = await ethers.getContract("Job")
    const resume = await ethers.getContract("Resume")
    const skill = await ethers.getContract("Skill")
    log("==================================")
    const resumiro = await deploy("Resumiro", {
        from: deployer,
        log: true,
        args: [
            user.address,
            company.address,
            experience.address,
            job.address,
            resume.address,
            skill.address,
        ],
        confirmations: 1,
    })
    log(`Deployed Resumiro at: ${resumiro.address}`)
}

module.exports.tags = ["all", "resumiro"]
