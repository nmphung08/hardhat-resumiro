
const fs = require("fs")
const { network, ethers } = require("hardhat")
// const ABI_PATH = "D:\\pp\\tot-nghiep\\projects\\hardhat-resumiro\\constants\\abi.json"
// const ADDRESS_PATH = "D:\\pp\\tot-nghiep\\projects\\hardhat-resumiro\\constants\\contractAddress.json"
const ABI_PATH = "D:/pp/tot-nghiep/projects/hardhat-resumiro/constants/abi.json"
const ADDRESS_PATH = "D:/pp/tot-nghiep/projects/hardhat-resumiro/constants/contractAddress.json"
module.exports = async function () {

    if (process.env.UPDATE_CONSTANTS) {
        console.log("Update constants!")
        try {
            await updateAbi()
            await updateContractAddresses()
        } catch(err) {
            console.log(err)
        }
    }

}

async function updateAbi() {
    let resumiro = await ethers.getContract("Resumiro")
    fs.writeFileSync(ABI_PATH, resumiro.interface.format(ethers.utils.FormatTypes.json))
}

async function updateContractAddresses() {
    let resumiro = await ethers.getContract("Resumiro")
    let currentAddresses = JSON.parse(fs.readFileSync(ADDRESS_PATH, "utf8"))
    let chainId = network.config.chainId.toString()
    if (chainId in currentAddresses) {
        if (!currentAddresses[chainId].includes(resumiro.address)) {
            currentAddresses[chainId].push(resumiro.address)
        }
    }
    else {
        currentAddresses[chainId] = [resumiro.address]
    }

    fs.writeFileSync(ADDRESS_PATH, JSON.stringify(currentAddresses))
}

module.exports.tags = ["all", "constants"]
