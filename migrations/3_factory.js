const PackFactory = artifacts.require("PackFactory");

module.exports = function (deployer) {
  deployer.deploy(PackFactory);
};