module.exports.default = async function updateRecruiterById(
    obj,
    recruiterId,
    contract
) {
    const { parseRecruiter } = require("../../parse/parseRecruiter")
    const prev = await parseRecruiter(recruiterId, contract)
    let successTemplate = {
        message: "Successfully update recruiter",
        status: "ok",
        data: {},
    }
    let errorTemplate = {
        message: "Error updating recruiter",
        status: "error",
    }

    const id = recruiterId
    const owned = obj.owned || prev.owned
    const avatar = obj.avatar || prev.avatar
    const background = obj.background || prev.background
    const addressWallet = obj.address_wallet || prev.address_wallet
    const fullName = obj.full_name || prev.full_name
    const email = obj.email || prev.email
    const phone = obj.phone || prev.phone
    const position = obj.position || prev.position

    try {
        let tx = await contract.updateRecruiter(
            id,
            owned,
            avatar,
            background,
            addressWallet,
            fullName,
            email,
            phone,
            position
        )
        tx.wait(1)

        const data = await parseRecruiter(id, contract)
        successTemplate.data = data
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
