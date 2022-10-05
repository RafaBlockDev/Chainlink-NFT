import { expect } from "chai";
import { ethers } from "hardhat"
import { Contract, BigNumber } from "ethers"
import { BoxV2 } from "../typechain";

describe("Box", function () {
  let boxV2:Contract;

  beforeEach(async function () {
    const BoxV2 = await ethers.getContractFactory("BoxV2")
    boxV2 = await BoxV2.deploy()
    await boxV2.deployed()
  })

  it("should retrieve value previously stored", async function () {
    await boxV2.store(42)
    expect(await boxV2.retrieve()).to.equal(BigNumber.from('42'))

    await boxV2.store(100)
    expect(await boxV2.retrieve()).to.equal(BigNumber.from('100'))
  })
  
  // Increment function
  it("Should increment value correctly", async function () {
      await boxV2.store(1);
      await boxV2.increment(); // 1 + 1 = 2
      expect(await boxV2.retrieve()).to.equal(BigNumber.from("2"));
  })

})