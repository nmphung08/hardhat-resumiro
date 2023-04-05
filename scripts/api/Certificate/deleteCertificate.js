module.exports.default = async function deleteCertificate(id, contract) {
    const { parseCertificate } = require("../../parse/parseCertificate")
    let successTemplate = {
        message: "Successfully deleted certificate",
        status: "ok",
        data: {},
    }

    let errorTemplate = {
        message: "error deleting certificate",
        status: "error",
    }

    let Certificate = await parseCertificate(id, contract)

    try {
        const tx = await contract.deleteCertificate(id)
        tx.wait(1)
        successTemplate.data = Certificate
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
