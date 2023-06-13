module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    log("==================================")
    const user = await deploy("User", {
        from: deployer,
        log: true,
        args: [],
        confirmations: 1,
    })
    log(`Deployed User at: ${user.address}`)
}

module.exports.tags = ["all", "user", "mains"]
