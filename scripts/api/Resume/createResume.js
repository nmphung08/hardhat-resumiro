module.exports.default = async function createResume(obj, contract) {
    const { parseNewestResume } = require("../../api/parseResume")
    let successTemplate = {
        message: "Successfully create resume",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "",
        status: "error",
    }

    let data = obj.data || ""
    let owner_id = obj.owner_id || ""
    let title = obj.title || ""
    let create_at = obj.create_at || ""

    try {
        let tx = await contract.addResume(data, owner_id, title, create_at)
        tx.wait(1)
        const resume = await parseNewestResume(contract)
        successTemplate.data = resume
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
