module.exports.default = async function updateCandidateById(
    obj,
    candidateId,
    contract
) {
    const { parseCandidate } = require("../../parse/parseCandidate")
    const prev = await parseCandidate(candidateId, contract)
    let successTemplate = {
        message: "Successfully update candidate",
        status: "ok",
        data: {},
    }
    let errorTemplate = {
        message: "Error updating candidate",
        status: "error",
    }

    const id = candidateId
    const avatar = obj.avatar || prev.avatar
    const background = obj.background || prev.background
    const addressWallet = obj.address_wallet || prev.address_wallet
    const fullName = obj.full_name || prev.full_name
    const email = obj.email || prev.email
    const phone = obj.phone || prev.phone
    const about = obj.about || prev.about

    try {
        let tx = await contract.updateCandiate(
            id,
            avatar,
            background,
            addressWallet,
            fullName,
            email,
            phone,
            about
        )
        tx.wait(1)

        const data = await parseCandidate(id, contract)
        successTemplate.data = data
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
