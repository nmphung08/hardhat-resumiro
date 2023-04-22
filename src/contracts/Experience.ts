import { ethers } from "ethers";
import { experienceAbi, experienceAddress } from "./abis";
import BaseInterface from "./interfaces/BaseInterface";

export type ExperienceProps = {
    id: number,
    position?: string,
    start?: number,
    finish?: number,
    companyId?: number,
    userAddress: string
}

export default class Experience extends BaseInterface {
    constructor(provider: ethers.providers.Web3Provider) {
        super(provider, experienceAddress, experienceAbi);
    }

    async getExperience(id: number) {
        try {
            const exp = await this._contract.getExperience(id);
            console.log(exp);

            return {
                position: exp.postion,
                start: exp.start,
                finish: exp.finish,
                company_id: exp.companyId
            }
        } catch (error) {
            return undefined;
        }
    }

    async addExperience({ id, position, start, finish, companyId, userAddress }: ExperienceProps) {
        const addTx = await this._contract.addExperience(userAddress, id, position, start, finish, companyId, userAddress, this._option);
        const result = await this._handleTransactionRespone(addTx);

        return result;
    }

    async updateExperience({ id, position, start, finish, companyId, userAddress }: ExperienceProps) {
        const exp = await this.getExperience(id);

        if (!exp) {
            console.log("ERROR get exp");
            return {};
        }

        const updateTx = await this._contract.updateExperience(userAddress,
            id,
            position ?? exp.position,
            start ?? exp.start,
            finish ?? exp.finish,
            companyId ?? exp.company_id
        );
        const result = await this._handleTransactionRespone(updateTx);

        return result;
    }

    async deleteExperience(id: number) {
        const deleteTx = await this._contract.deleteExperience(id, this._option);
        const result = await this._handleTransactionRespone(deleteTx);

        return result;
    }
}
