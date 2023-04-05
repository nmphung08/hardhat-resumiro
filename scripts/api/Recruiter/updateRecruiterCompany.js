module.exports.default = async function updateRecruiterCompany(
    recruiterId,
    obj,
    contract
) {
    let successTemplate = {
        message: "Successfully update company for recruiter",
        status: "ok",
        data: {
            recruiter_id: 0,
            company_id: 0
        },
    }
    let errorTemplate = {
        message: "Error updating company for recruiter",
        status: "error",
    }
    try {
        let tx = await contract.connectCompanyRecruiter(
            recruiterId,
            obj.company_id
        )
        tx.wait(1)

        successTemplate.data.company_id = obj.company_id
        successTemplate.data.recruiter_id = recruiterId
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
