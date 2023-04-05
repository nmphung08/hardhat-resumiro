module.exports.default = async function deleteJob(id, contract) {
    const { parseJob } = require("../../parse/parseJob")
    let successTemplate = {
        message: "Successfully deleted job",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "Error deleting job",
        status: "error",
    }

    const job = await parseJob(id, contract)

    try {
        const tx = await contract.deleteJob(id)
        tx.wait(1)
        successTemplate.data = job
        return successTemplate
        
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
