import { ethers } from "hardhat";

async function main() {
  const LectureNFT = await ethers.getContractFactory('LectureNFT');
  const contract = await LectureNFT.deploy();

  await contract.getDeployedCode();

  console.log("NFT Contract:", contract.address);

  //We recommend this patttern to be able to use async/await everywhere
  //and properly handle errors.
  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })
}
