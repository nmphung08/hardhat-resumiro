const { ethers, getNamedAccounts } = require("hardhat")

module.exports = async function ({ getNamedAccounts, deployments }) {
    if (process.env.UPDATE_CONSTANTS) {
        try {
            await updateContracts()
        } catch (err) {
            console.log(err)
        }
        console.log("==============================")
        console.log("Updated contracts!")
    }
}

async function updateContracts() {
    const user = await ethers.getContract("User")
    const company = await ethers.getContract("Company")
    const certificate = await ethers.getContract("Certificate")
    const experience = await ethers.getContract("Experience")
    const job = await ethers.getContract("Job")
    const resume = await ethers.getContract("Resume")
    const skill = await ethers.getContract("Skill")

    const deployer = (await getNamedAccounts()).deployer
    const resumiro = await ethers.getContractAt(
        "Resumiro",
        process.env.RESUMIRO_CONTRACT,
        deployer
    )
    await resumiro.setContracts(
        user.address,
        company.address,
        certificate.address,
        experience.address,
        job.address,
        resume.address,
        skill.address
    )
    console.log(resumiro.address)
}

module.exports.tags = ["all", "mains", "interfaces"]
