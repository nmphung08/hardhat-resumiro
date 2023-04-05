function renameProps(obj) {
    // mapping of old property names to new property names
    const propMap = {
        id: "id",
        name: "name",
        verifiedAt: "verified_at",
        userId: "candidate_id",
    }

    // create a new object with renamed properties
    let newObj = {}
    Object.keys(obj).forEach((key) => {
        if (propMap[key]) {
            newObj[propMap[key]] = obj[key]
        }
    })

    return newObj
}

async function parseCertificate(id, contract) {
    let Certificate = await contract.getCertificate(id)
    Certificate = { ...Certificate }
    Certificate = renameProps(Certificate)
    return Certificate
}

async function parseNewestCertificate(contract) {
    let Certificate = await contract.getNewestCertificate()
    Certificate = { ...Certificate }
    Certificate = renameProps(Certificate)
    return Certificate
}

module.exports = { parseCertificate, renameProps, parseNewestCertificate }
