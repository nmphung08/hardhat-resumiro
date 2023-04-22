import { ethers } from "ethers";
import { companyAbi, companyAddress } from "./abis";
import BaseInterface from "./interfaces/BaseInterface";

export type CompanyProps = {
    id: number,
    name?: string,
    website?: string,
    location?: string,
    address?: string
}

export default class Company extends BaseInterface {
    constructor(provider: ethers.providers.Web3Provider) {
        super(provider, companyAddress, companyAbi);
    }

    async getCompany(id: number) {
        const company = await this._contract.getCompany();

        console.log(company);

        return {
            name: company.name,
            website: company.website,
            location: company.location,
            address: company.address
        }
    }

    async addCompany({ id, name, website, location, address }: CompanyProps) {
        const addTx = await this._contract.addCompany(id, name, website, location, address, this._option);
        const result = await this._handleTransactionRespone(addTx);

        return result;
    }

    async updateCompany({ id, name, website, location, address }: CompanyProps) {
        const company = await this.getCompany(id);

        const updateTx = await this._contract.updateCompany(
            id,
            name ?? company.name,
            website ?? company.website,
            location ?? company.location,
            address ?? company.address,
            this._option
        )
        const result = await this._handleTransactionRespone(updateTx);

        return result;
    }

    async deleteCompany(id: number) {
        const deleteTx = await this._contract.deleteCompany(id, this._option);
        const result = await this._handleTransactionRespone(deleteTx);

        return result;
    }

    async connectCompanyRecruiter({ recruiterAddress, companyId }: { recruiterAddress: string, companyId: number }) {
        const connectTx = await this._contract.connectCompanyRecruiter(recruiterAddress, companyId, this._option);
        const result = await this._handleTransactionRespone(connectTx);

        return result;
    }

    async disconnectCompanyRecruiter({ recruiterAddress, companyId }: { recruiterAddress: string, companyId: number }) {
        const disconnectTx = await this._contract.disconnectCompanyRecruiter(recruiterAddress, companyId, this._option);
        const result = await this._handleTransactionRespone(disconnectTx);

        return result;
    }
}