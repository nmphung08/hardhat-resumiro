module.exports.default = async function deleteExperience(id, contract) {
    const { parseExperience } = require("../../parse/parseExperience")
    let successTemplate = {
        message: "Successfully deleted experience",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "error deleting experience",
        status: "error",
    }

    let Experience = await parseExperience(id, contract)

    try {
        const tx = await contract.deleteExperience(id)
        tx.wait(1)
        successTemplate.data = Experience
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
