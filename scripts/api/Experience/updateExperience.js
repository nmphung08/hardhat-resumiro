module.exports.default = async function updateExperience(
    experienceId,
    obj,
    contract
) {
    const { parseExperience } = require("../../parse/parseExperience")
    const prev = await parseExperience(experienceId, contract)
    let successTemplate = {
        message: "Successfully updated experience",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "Error updating experience",
        status: "error",
    }

    const id = experienceId
    const position = obj.position || prev.position
    const start = obj.start || prev.start
    const finish = obj.finish || prev.finish
    const companyId = obj.company_id || prev.company_id


    try {
        let tx = await contract.updateExperience(id, position, start, finish, companyId)
        tx.wait(1)

        const data = await parseExperience(id, contract)
        successTemplate.data = data
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
