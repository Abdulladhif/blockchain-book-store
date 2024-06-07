const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("BookstoreModule", (m) => {
  const bookstore = m.contract("Bookstore", []);

  return { bookstore };
});