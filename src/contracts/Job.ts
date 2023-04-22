import { ethers } from "ethers";
import { jobAbi, jobAddress } from "./abis";
import BaseInterface from "./interfaces/BaseInterface";

export type JobProps = {
    id: number,
    title?: string;
    location?: string;
    jobType?: string;
    createAt?: number;
    updateAt?: number;
    companyId?: number;
    salary?: number;
    field?: string;
    recruiterAddress?: string;
}

export default class Experience extends BaseInterface {
    constructor(provider: ethers.providers.Web3Provider) {
        super(provider, jobAddress, jobAbi);
    }

    async getJob(id: number) {
        try {
            const job = await this._contract.getJob(id);
            console.log(job);

            return {
                title: job.title,
                location: job.location,
                job_type: job.jobType,
                create_at: job.createAt,
                update_at: job.updateAt,
                company_id: job.companyId,
                salary: job.salary,
                field: job.field,
            }
        } catch (error) {
            return undefined;
        }
    }

    async addJob({ id, title, location, jobType, createAt, companyId, salary, field, recruiterAddress }: JobProps) {
        const addTx = await this._contract.addJob(id, title, location, jobType, createAt, companyId, salary, field, recruiterAddress, this._option);
        const result = await this._handleTransactionRespone(addTx);

        return result;
    }

    async updateJob({ id, title, location, jobType, updateAt, companyId, salary, field }: JobProps) {
        const job = await this.getJob(id);

        if (!job) {
            console.log("ERROR get job");
            return {};
        }

        const updateTx = await this._contract.updateJob(
            id,
            title ?? job.title,
            location ?? job.location,
            jobType ?? job.job_type,
            updateAt ?? job.update_at,
            companyId ?? job.company_id,
            salary ?? job.salary,
            field ?? job.field
        );
        const result = await this._handleTransactionRespone(updateTx);

        return result;
    }

    async deleteJob(id: number) {
        const deleteTx = await this._contract.deleteJob(id, this._option);
        const result = await this._handleTransactionRespone(deleteTx);

        return result;
    }

    async connectJobCandidate(candidateAddress: string, jobId: number) {
        const applyTx = await this._contract.connectJobCandidate(candidateAddress, jobId);
        const result = await this._handleTransactionRespone(applyTx);

        return result;
    }

    async disconnectJobCandidate(candidateAddress: string, jobId: number) {
        const disapproveTx = await this._contract.disconnectJobCandidate(candidateAddress, jobId);
        const result = await this._handleTransactionRespone(disapproveTx);

        return result;
    }
}
