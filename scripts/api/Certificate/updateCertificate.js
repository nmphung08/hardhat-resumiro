module.exports.default = async function updateCertificate(
    certificateId,
    obj,
    contract
) {
    const { parseCertificate } = require("../../parse/parseCertificate")
    const prev = await parseCertificate(certificateId, contract)
    let successTemplate = {
        message: "Successfully updated certificate",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "Error updating certificate",
        status: "error",
    }

    const id = certificateId
    const name = obj.name || prev.name
    const verifiedAt = obj.verified_at || prev.verified_at
    const userId = obj.candidate_id || prev.candidate_id

    try {
        let tx = await contract.updateCertificate(id, name, verifiedAt, userId)
        tx.wait(1)

        const data = await parseCertificate(id, contract)
        successTemplate.data = data
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
