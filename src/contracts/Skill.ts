import { ethers } from "ethers";
import { skillAbi, skillAddress } from "./abis";
import BaseInterface from "./interfaces/BaseInterface";

export type SkillProps = {
    id: number,
    name?: string,
}

export default class Certificate extends BaseInterface {
    constructor(provider: ethers.providers.Web3Provider) {
        super(provider, skillAddress, skillAbi);
    }

    async addSkill({ id, name }: SkillProps) {
        const addTx = await this._contract.addSkill(id, name, this._option);
        const result = await this._handleTransactionRespone(addTx);

        return result;
    }

    async deleteSkill(id: number) {
        const deleteTx = await this._contract.deleteSkill(id, this._option);
        const result = await this._handleTransactionRespone(deleteTx);

        return result;
    }

    async connectCandidateSkill(candidateAddress: string, skills: number[]) {
        const connectTx = await this._contract.connectCandidateSkill(candidateAddress, skills, this._option);
        const result = await this._handleTransactionRespone(connectTx);

        return result;
    }

    async disconnectCandidateSkill(candidateAddress: string, skills: number[]) {
        const disconnectTx = await this._contract.disconnectCandidateSkill(candidateAddress, skills, this._option);
        const result = await this._handleTransactionRespone(disconnectTx);

        return result;
    }

    async connectJobSkill(jobId: number, skills: number[]) {
        const connectTx = await this._contract.connectJobSkill(jobId, skills, this._option);
        const result = await this._handleTransactionRespone(connectTx);

        return result;
    }

    async disconnectJobSkill(jobId: number, skills: number[]) {
        const disconnectTx = await this._contract.disconnectJobSkill(jobId, skills, this._option);
        const result = await this._handleTransactionRespone(disconnectTx);

        return result;
    }
}