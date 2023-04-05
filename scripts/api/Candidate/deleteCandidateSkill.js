module.exports.default = async function deleteCandidateSkill(candidateId, obj, contract) {
    let successTemplate = {
        "message": "Successfully delete skill for candidate",
        "status": "ok",
        "data": {
          "candidate_id": 0,
          "skill_id": 0
        }
      }
    let errorTemplate = {
        message: "Error deleting skill",
        status: "error",
    }
    try {
        let tx = await contract.disconnectCandidateSkill(obj.skill_id, candidateId)
        tx.wait(1)

        successTemplate.data.skill_id = obj.skill_id
        successTemplate.data.candidate_id = candidateId
        return successTemplate
    } catch (error) {
        errorTemplate.message = error
        throw errorTemplate
    }
}
