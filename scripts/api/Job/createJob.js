module.exports.default = async function createJob(obj, contract) {
    const { parseNewestJob } = require("../../parse/parseJob")
    let resTemplate = {
        message: "Successfully create job",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "Error creating job",
        status: "error",
    }
    const title = obj.title || ""
    const location_id = obj.location_id || ""
    const job_type_id = obj.job_type_id || ""
    const experience = obj.experience || ""
    const requirements = obj.requirements || ""
    const benefits = obj.benefits || ""
    const create_at = obj.create_at || ""
    const update_at = obj.update_at || ""
    const owner_id = obj.owner_id || ""
    const company_id = obj.company_id || ""
    const salary = obj.salary || ""
    const field_id = obj.field_id || ""

    try {
        let tx = await contract.addJob([
            title,
            location_id,
            job_type_id,
            experience,
            requirements,
            benefits,
            create_at,
            update_at,
            owner_id,
            company_id,
            salary,
            field_id,
        ])
        tx.wait(1)

        const data = await parseNewestJob(contract)
        resTemplate.data = data
        return resTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
