module.exports.default = async function updateJob(jobId, obj, contract) {
    const { parseJob } = require("../../parse/parseJob")
    const prevJob = await parseJob(jobId, contract)
    let resTemplate = {
        message: "Successfully update job",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "Error updating job",
        status: "error",
    }

    const id = jobId
    const title = obj.title || prevJob.title
    const job_type_id = obj.job_type_id || prevJob.job_type_id
    const experience = obj.experience || prevJob.experience
    const requirements = obj.requirements || prevJob.requirements
    const benefits = obj.benefits || prevJob.benefits
    const create_at = obj.create_at || prevJob.create_at
    const update_at = obj.update_at || prevJobbj.update_at
    const salary = obj.salary || prevJob.salary

    try {
        let tx = await contract.updateJob(
            id,
            title,
            job_type_id,
            experience,
            requirements,
            benefits,
            create_at,
            update_at,
            salary
        )
        tx.wait(1)

        const data = await parseJob(id, contract)
        resTemplate.data = data
        return resTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
