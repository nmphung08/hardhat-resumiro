module.exports.default = async function isApplied(jobId, obj, contract) {
    let appliedTemplate = {
        message: "Candidate already apply job",
        status: "success",
        data: {
            job_id: 0,
            applicant_id: 0,
        },
    }

    let notAppliedTemplate = {
        message: "Candidate not applied",
        status: "success",
    }

    let errorTemplate = {
        message: "Error getting information",
        status: "error",
    }

    try {
        const isApplied = await contract.isExistedJobCandidate(
            obj.candidate_id,
            jobId
        )

        if (isApplied) {
            appliedTemplate.data.job_id = jobId
            appliedTemplate.data.candidate_id = obj.cadidate_id
            return appliedTemplate
        } else {
            return notAppliedTemplate
        }
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
