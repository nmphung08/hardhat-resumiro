import { ethers, getNamedAccounts } from "hardhat"
import { parseJobs } from "../parse/parseJobs"
import { parseLocation } from "../parse/parseLocation"
import { parseJobType } from "../parse/parseJobType"
import { parseCompany } from "../parse/parseCompany"

module.exports.default = async function getJobs(searchParams) {
    /**
     * 1. get list of needed job ids
     * 1.1. get job ids
     * 1.2. slice the job ids array for the needed job ids
     * 2. get jobs
     * 3. iterate thru jobs append the company and location props
     */

    const deployer = (await getNamedAccounts()).deployer
    const Resumiro = await ethers.getContract("Resumiro", deployer)

    let jobIds = await Resumiro.getJobIds()
    let total = floor((jobIds.length - 1) / searchParams.limit) + 1
    let start = (page - 1) * limit
    let end = start + limit
    jobIds = jobIds.slice(start, end)
    let jobs = parseJobs(jobIds, Resumiro)
    for (let i = 0; i < jobs.length; i++) {
        let job = jobs[i]
        let location = await parseLocation(job.location_id)
        let jobType = await parseJobType(job.job_type_id)
        let company = await parseCompany(job.company_id)
        jobs[i]["location"] = location
        jobs[i]["job_type"] = jobType["name"]
        jobs[i]["company"] = company
    }
    let returnObj = {
        message: "Successfully get jobs",
        status: "ok",
        pagination: {
            total: total,
            page: searchParams.page,
            limit: searchParams.limit,
        },
        data: jobs,
    }

    return returnObj
}
