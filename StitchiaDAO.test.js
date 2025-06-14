const { expect } = require("chai");

describe("StitchiaDAO", function () {
  let dao, owner, user;

  beforeEach(async function () {
    const StitchiaDAO = await ethers.getContractFactory("StitchiaDAO");
    [owner, user] = await ethers.getSigners();
    dao = await StitchiaDAO.deploy();
    await dao.deployed();
  });

  it("should add a contributor", async function () {
    await dao.addContributor(user.address, 1, 5);
    const contributor = await dao.contributors(user.address);
    expect(contributor.active).to.equal(true);
    expect(contributor.reputation).to.equal(5);
  });

  it("should allow a contributor to submit a proposal", async function () {
    await dao.addContributor(user.address, 1, 5);
    await dao.connect(user).submitProposal("Test", "This is a test");
    const count = await dao.getProposalCount();
    expect(count).to.equal(1);
  });
});
