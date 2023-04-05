const { parseJob } = require("./parse/parseJob")
const {getContract} = require("./contract")
// const { abi } = require("../deployments/localhost/Resumiro.json")

async function main() {
    // const Resumiro = await getContract()
    // const deployer = (await getNamedAccounts()).deployer
    // const Resumiro = await ethers.getContract("Resumiro", deployer)
    // await Resumiro.addLocation("1", "TPHCM")
    // console.log(await getJob("1", Resumiro))
    // console.log(await getJobs("",Resumiro))
    // console.log(await parseJob("1", Resumiro))

    // await Resumiro.addJobType("1", "part-time")
    // await Resumiro.addField("1",'Lập trình/ IT/ CNTT/ Engineering', 'This is a Job')
    // await Resumiro.addCompany("1", "1", 'Google', 'https://cdn-icons-png.flaticon.com/512/281/281764.png?w=740&t=st=1678987111~exp=1678987711~hmac=d5b56dfe9ae4ede505dfcfcd33b37138ca4f8bdbc812b96d3fd9e4a7be021609', 'https://goldidea.vn/upload/y-nghia-logo-google.jpg', 'Google is a multinational technology company specializing in Internet-related services and products.', '1000 - 5000 nhân viên', 'https://www.google.com', "1", '35 Xô Viết Nghệ Tĩnh, Quận 9', "")

    //   await Resumiro.addJob(["1", 'Software Engineer (Full-stack)', "1", 'Full-time', 25, 'Experience with Java, React.js and Node.js required. Master degree in Computer Science or related field preferred.', 'Health insurance, gym membership, flexible schedule, 401k', '2023-02-02 12:44:05', "", "1", "1", 5000000, "1"])

    // let jobs = await Resumiro.getAllJobs()
    // console.log(jobs.length)
    // console.log("=============")
    // for (let job of jobs) {
    //     console.log(job)
    // }
}

main()
    .then(() => {
        process.exit(0)
    })
    .catch((err) => {
        console.log(err)
        process.exit(1)
    })
