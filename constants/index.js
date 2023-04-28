const userAbi = require("./userAbi.json")
const companyAbi = require("./companyAbi.json")
const experienceAbi = require("./experienceAbi.json")
const jobAbi = require("./jobAbi.json")
const resumeAbi = require("./resumeAbi.json")
const skillAbi = require("./skillAbi.json")
const resumiroAbi = require("./resumiroAbi.json")
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
