import { ethers, hardhatArguments } from "hardhat";
import * as Config from "./config";

import * as dotenv from 'dotenv' // see https://github.com/motdotla/dotenv#how-do-i-use-dotenv-with-import
dotenv.config()

/* --------------------------------------------------------------------------------------------- */
/* should USE [npx hardhat deploy --network {hardhat || localhost || ganache || mumbai}] */
/* --------------------------------------------------------------------------------------------- */

async function main() {
  await Config.initConfig();
  const network = hardhatArguments.network ? hardhatArguments.network : "dev";
  const [deployer] = await ethers.getSigners();
  console.log("Deploying from address: ", deployer.address);

  const User = await ethers.getContractFactory("User");
  const user = await User.deploy();
  await user.deployed();

  console.log("User Contract address: ", user.address);
  Config.setConfig(network + '.User', user.address);

  const Company = await ethers.getContractFactory("Company");
  const company = await Company.deploy(user.address);
  await company.deployed();

  console.log("Company Contract address: ", company.address);
  Config.setConfig(network + '.Company', company.address);

  const Experience = await ethers.getContractFactory("Experience");
  const experience = await Experience.deploy(user.address, company.address);
  await experience.deployed();

  console.log("Experience Contract address: ", experience.address);
  Config.setConfig(network + '.Experience', experience.address);

  const Job = await ethers.getContractFactory("Job");
  const job = await Job.deploy(user.address, company.address);
  await job.deployed();

  console.log("Job Contract address: ", job.address);
  Config.setConfig(network + '.Job', job.address);

  const Resume = await ethers.getContractFactory("Resume");
  const resume = await Resume.deploy(user.address);
  await resume.deployed();

  console.log("Resume Contract address: ", resume.address);
  Config.setConfig(network + '.Resume', resume.address);

  const Skill = await ethers.getContractFactory("Skill");
  const skill = await Skill.deploy(user.address, job.address);
  await skill.deployed();

  console.log("Skill Contract address: ", skill.address);
  Config.setConfig(network + '.Skill', skill.address);

  const Resumiro = await ethers.getContractFactory("Resumiro");
  const resumiro = await Resumiro.deploy(user.address, company.address, experience.address, job.address, resume.address, skill.address);
  await resumiro.deployed();

  console.log("Resumiro Contract address: ", resumiro.address);
  Config.setConfig(network + '.Resumiro', resumiro.address);

  // const Certificate = await ethers.getContractFactory("Certificate2");
  // const certificate = await Certificate.deploy("0x867b584D008fA88357c3Ae6A29C2Ce66079AD9C8");
  // await certificate.deployed();

  // console.log("Certificate Contract address: ", certificate.address);
  // Config.setConfig(network + '.Certificate', certificate.address);

  await Config.updateConfig();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
