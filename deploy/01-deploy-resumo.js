
module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    
    log("==================================")
    await deploy("Resumiro", {
        from: deployer,
        log: true,
        args: [],
        confirmations: 1,
    })
}

module.exports.tags = ["all", "resumiro"]
