// const { abi } = require("../deployments/localhost/Resumiro.json")
const { ethers, getNamedAccounts } = require("hardhat")
const { getContracts } = require("./getContracts")

async function main() {
    // const {
    //     user,
    //     company,
    //     certificate,
    //     experience,
    //     job,
    //     resume,
    //     skill,
    //     resumiro,
    // } = await getContracts()

    // console.log("All users: ", await resumiro.getAllUser())
    // console.log("All companies: ", await resumiro.getAllCompanies())
    // console.log("All jobs: ", await resumiro.getAllJobs())
    // console.log("All cvs: ", await resumiro.getAllResumes())
    // console.log("All experiences: ", await resumiro.getAllExperiences())
    // console.log("All Certificates: ", await resumiro.getAllCertificates())
    // console.log("All Skills: ", await resumiro.getAllSkill())
}

main()
    .then(() => {
        process.exit(0)
    })
    .catch((err) => {
        console.log(err)
        process.exit(1)
    })
