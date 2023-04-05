module.exports.default = async function applyJob(jobId, obj, contract) {
    let resTemplate = {
        message: "Successfully apply job for candidate",
        status: "ok",
        data: {
            job_id: 0,
            applicant_id: 0,
        },
    }
    let errorTemplate = {
        message: "Candidate already apply job",
        status: "error",
    }
    try {
        let tx = await contract.connectJobCandidate(obj.candidate_id, jobId)
        tx.wait(1)

        resTemplate.data.job_id = jobId
        resTemplate.data.candidate_id = obj.candidate_id
        return resTemplate
    } catch (error) {
        errorTemplate.message = error
        return errorTemplate
    }
}
