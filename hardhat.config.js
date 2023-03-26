require('@nomicfoundation/hardhat-toolbox');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: {
        version: '0.8.15',
        settings: {
            optimizer: {
                enabled: true,
                runs: 1000000,
            },
        },
    },
    mocha: {
        timeout: 40000,
    },
    paths: {
        sources: "./optimizedContracts",
        tests: "./test",
        cache: "./cache",
        artifacts: "./artifacts"
      },
};
