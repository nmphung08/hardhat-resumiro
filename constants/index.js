const userAbi = require("./User.json")
const companyAbi = require("./Company.json")
const experienceAbi = require("./experience.json")
const jobAbi = require("./job.json")
const resumeAbi = require("./resume.json")
const skillAbi = require("./skill.json")
const resumiroAbi = require("./resumiro.json")
const contractAddress = require("./contractAddress.json")

module.exports = {
    userAbi,
    companyAbi,
    experienceAbi,
    jobAbi,
    resumeAbi,
    skillAbi,
    resumiroAbi,
    contractAddress,
}

// contractAddress.json must be created with initial value: {}
