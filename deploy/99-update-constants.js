const fs = require("fs")
const { network, ethers } = require("hardhat")
// const ABI_PATH = "D:\\pp\\tot-nghiep\\projects\\hardhat-resumiro\\constants\\abi.json"
// const ADDRESS_PATH = "D:\\pp\\tot-nghiep\\projects\\hardhat-resumiro\\constants\\contractAddress.json"

/* ==================================== */
/**
 * @purpose For updating constants: abi, contract address
 * @notes
 *  1. Change the PATH variable to wanted directory before deploy
 *  2. contractAddress.json must be created with initial value {} before deploy
 *  3. set UPDATE_CONSTANTS=true in .env before deploy
 * @usage [npx hardhat deploy --tags constants --network {hardhat || localhost || ganache || mumbai}]
 */
/* ==================================== */

const PATH =
    "D:/pp/tot-nghiep/projects/hardhat-resumiro-clone/hardhat-resumiro/constants/"
const USER_ABI_PATH = `${PATH}userAbi.json`
const COMPANY_ABI_PATH = `${PATH}companyAbi.json`
const EXPERIENCE_ABI_PATH = `${PATH}experienceAbi.json`
const JOB_ABI_PATH = `${PATH}jobAbi.json`
const RESUME_ABI_PATH = `${PATH}resumeAbi.json`
const SKILL_ABI_PATH = `${PATH}skillAbi.json`
const RESUMIRO_ABI_PATH = `${PATH}resumiroAbi.json`
const ADDRESS_PATH = `${PATH}contractAddress.json`
module.exports = async function () {
    if (process.env.UPDATE_CONSTANTS) {
        try {
            await updateConstants()
        } catch (err) {
            console.log(err)
        }
        console.log("==============================")
        console.log("Updated constants!")
    }
}

async function updateConstants() {
    let currentAddresses = JSON.parse(fs.readFileSync(ADDRESS_PATH, "utf8"))
    let chainId = network.config.chainId.toString()

    let user = await ethers.getContract("User")
    fs.writeFileSync(
        USER_ABI_PATH,
        user.interface.format(ethers.utils.FormatTypes.json)
    )
    updateContractAddress(currentAddresses, chainId, "User", user.address)

    let company = await ethers.getContract("Company")
    fs.writeFileSync(
        COMPANY_ABI_PATH,
        company.interface.format(ethers.utils.FormatTypes.json)
    )
    updateContractAddress(currentAddresses, chainId, "Company", company.address)

    let experience = await ethers.getContract("Experience")
    fs.writeFileSync(
        EXPERIENCE_ABI_PATH,
        experience.interface.format(ethers.utils.FormatTypes.json)
    )
    updateContractAddress(
        currentAddresses,
        chainId,
        "Experience",
        experience.address
    )

    let job = await ethers.getContract("Job")
    fs.writeFileSync(
        JOB_ABI_PATH,
        job.interface.format(ethers.utils.FormatTypes.json)
    )
    updateContractAddress(currentAddresses, chainId, "Job", job.address)

    let resume = await ethers.getContract("Resume")
    fs.writeFileSync(
        RESUME_ABI_PATH,
        resume.interface.format(ethers.utils.FormatTypes.json)
    )
    updateContractAddress(currentAddresses, chainId, "Resume", resume.address)

    let skill = await ethers.getContract("Skill")
    fs.writeFileSync(
        SKILL_ABI_PATH,
        skill.interface.format(ethers.utils.FormatTypes.json)
    )
    updateContractAddress(currentAddresses, chainId, "Skill", skill.address)

    let resumiro = await ethers.getContract("Resumiro")
    fs.writeFileSync(
        RESUMIRO_ABI_PATH,
        resumiro.interface.format(ethers.utils.FormatTypes.json)
    )
    updateContractAddress(
        currentAddresses,
        chainId,
        "Resumiro",
        resumiro.address
    )

    fs.writeFileSync(ADDRESS_PATH, JSON.stringify(currentAddresses))
}

function updateContractAddress(
    current,
    chainId,
    contractName,
    contractAddress
) {
    if (chainId in current) {
        if (
            current[chainId][contractName] &&
            !current[chainId][contractName].includes(contractAddress)
        ) {
            current[chainId][contractName].push(contractAddress)
        } else if (!current[chainId][contractName]) {
            current[chainId][contractName] = [contractAddress]
        }
    } else {
        current[chainId] = {}
        current[chainId][contractName] = [contractAddress]
    }
}

module.exports.tags = ["all", "constants"]
