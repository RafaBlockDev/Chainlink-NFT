import { ethers } from "hardhat"
import { upgrades } from "hardhat"

const proxyAddress = "0x6f7D84BCc0CCaea429dCf81D06CBBAb1060c0d04";

async function main() {

    console.log("First contract address is: ", proxyAddress);

    const BoxV2 = await ethers.getContractFactory("BoxV2");

    console.log("Upgrading smart contract to BoxV2");

    const boxV2 = await upgrades.upgradeProxy(proxyAddress, BoxV2);

    console.log(boxV2.address, "BoxV2 address should be the same");

    console.log(await upgrades.erc1967.getImplementationAddress(boxV2.address), "getImplementationAddress");
    // Admin
    console.log(await upgrades.erc1967.getAdminAddress(boxV2.address), "getAdminAddress");
}

main().catch((error) => {
    console.log(error)
    process.exitCode = 1;
})