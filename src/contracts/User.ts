import { ethers } from "ethers";
import { userAbi, userAddress } from "./abis";
import BaseInterface from "./interfaces/BaseInterface";

export type UserProps = {
    userAddress: string,
    type: number
}

export default class User extends BaseInterface {
    constructor(provider: ethers.providers.Web3Provider) {
        super(provider, userAddress, userAbi);
    }

    async addUser({ userAddress, type }: UserProps) {
        const addTx = await this._contract.addUser(userAddress, type, this._option);
        const result = await this._handleTransactionRespone(addTx);
        // const log = this.listenEvent(0);

        return result;
    }

    async getVerifiers() {
        const getTx = await this._contract.getVerifiers();

        return getTx;
    }

    async getUser(_address: string) {
        const getTx = await this._contract.getUser(_address);

        return getTx;
    }
}