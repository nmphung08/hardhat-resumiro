module.exports.default = async function deleteResume(id, contract) {
    const { parseResume } = require("../../parse/parseResume")
    let successTemplate = {
        message: "Successfully deleted resume",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "error deleting resume",
        status: "error",
    }

    let resume = await parseResume(id, contract)

    try {
        const tx = await contract.deleteResume(id)
        tx.wait(1)
        successTemplate.data = resume
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
