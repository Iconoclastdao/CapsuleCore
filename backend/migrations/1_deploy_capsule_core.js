const CapsuleCore = artifacts.require("Capsule/CapsuleCore");

module.exports = async function (deployer) {
  await deployer.deploy(CapsuleCore);
};