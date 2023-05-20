// const { abi } = require("../deployments/localhost/Resumiro.json")
const { getContracts } = require("./getContracts")

async function main() {
    const {
        user,
        company,
        certificate,
        experience,
        job,
        resume,
        skill,
        resumiro,
    } = await getContracts()

    console.log(await resumiro.getAllSkillsOfCandidate("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"))
}

main()
    .then(() => {
        process.exit(0)
    })
    .catch((err) => {
        console.log(err)
        process.exit(1)
    })
