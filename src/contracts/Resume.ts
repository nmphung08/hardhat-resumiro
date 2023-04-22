import { ethers } from "ethers";
import { resumeAbi, resumeAddress } from "./abis";
import BaseInterface from "./interfaces/BaseInterface";

export type ResumeProps = {
    id: number,
    data?: string,
    createAt?: number,
    updateAt?: number,
    candidateAddress?: string
}

export default class Experience extends BaseInterface {
    constructor(provider: ethers.providers.Web3Provider) {
        super(provider, resumeAddress, resumeAbi);
    }

    async getResume(id: number) {
        try {
            const resume = await this._contract.getResume(id);
            console.log(resume);

            return {
                data: resume.data,
                create_at: resume.createAt,
                update_at: resume.updateAt
            }
        } catch (error) {
            return undefined;
        }
    }

    async addResume({ id, data, createAt, candidateAddress }: ResumeProps) {
        const addTx = await this._contract.addExperience(id, data, createAt, candidateAddress, this._option);
        const result = await this._handleTransactionRespone(addTx);

        return result;
    }

    async updateResume({ id, data, updateAt }: ResumeProps) {
        const resume = await this.getResume(id);

        if (!resume) {
            console.log("ERROR get resume");
            return {};
        }

        const updateTx = await this._contract.updateResume(
            id,
            data ?? resume.data,
            updateAt ?? resume.update_at
        );
        const result = await this._handleTransactionRespone(updateTx);

        return result;
    }

    async deleteResume(id: number) {
        const deleteTx = await this._contract.deleteResume(id, this._option);
        const result = await this._handleTransactionRespone(deleteTx);

        return result;
    }

    async connectResumeRecruiter(recruiterAddress: string, resumeId: number) {
        const approveTx = await this._contract.connectResumeRecruiter(recruiterAddress, resumeId);
        const result = await this._handleTransactionRespone(approveTx);

        return result;
    }

    async disconnectResumeRecruiter(recruiterAddress: string, resumeId: number) {
        const disapproveTx = await this._contract.disconnectResumeRecruiter(recruiterAddress, resumeId);
        const result = await this._handleTransactionRespone(disapproveTx);

        return result;
    }
}
