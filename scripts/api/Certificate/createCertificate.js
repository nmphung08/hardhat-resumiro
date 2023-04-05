module.exports.default = async function createCertificate(obj, contract) {
    const { parseNewestCertificate } = require("../../api/parseCertificate")
    let successTemplate = {
        message: "Successfully create certificate",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "Error creating certificate",
        status: "error",
    }

    let name = obj.name || ""
    let verifiedAt = obj.verified_at || ""
    let userId = obj.candidate_id || ""


    try {
        let tx = await contract.addCertificate(name, verifiedAt, userId)
        tx.wait(1)
        const Certificate = await parseNewestCertificate(contract)
        successTemplate.data = Certificate
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
