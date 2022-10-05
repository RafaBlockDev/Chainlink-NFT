import { ethers } from "hardhat"
import { upgrades } from "hardhat"

async function main() {

    const Box = await ethers.getContractFactory("Box");
    const box = await upgrades.deployProxy(Box,[1], {initializer: "store"}) 

    console.log("Proxy address: ", box.address);
    console.log(await upgrades.erc1967.getImplementationAddress(box.address), "getImplementationAddress");
    // Admin
    console.log(await upgrades.erc1967.getAdminAddress(box.address), "getAdminAddress");
}

main().catch((error) => {
    console.log(error)
    process.exitCode = 1;
})