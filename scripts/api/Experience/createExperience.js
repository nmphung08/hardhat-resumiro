module.exports.default = async function createExperience(obj, contract) {
    const { parseNewestExperience } = require("../../api/parseExperience")
    let successTemplate = {
        message: "Successfully create experience",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "Error creating experience",
        status: "error",
    }

    let position = obj.position || ""
    let start = obj.start || ""
    let finish = obj.finish || ""
    let companyId = obj.company_id || ""
    let userId = obj.user_id || ""



    try {
        let tx = await contract.addExperience(position, start, finish, companyId, userId)
        tx.wait(1)
        const Experience = await parseNewestExperience(contract)
        successTemplate.data = Experience
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
