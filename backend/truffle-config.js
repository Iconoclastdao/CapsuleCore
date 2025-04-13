module.exports = {
  networks: {
    dashboard: {
      host: "localhost",
      port: 24012,           // Required: Truffle Dashboard runs on this port
      network_id: "*",       // Matches any network
    }
  },

  compilers: {
    solc: {
      version: "0.8.28",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};