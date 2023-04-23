import { ethers } from "ethers";
import { certificateAbi, certificateAddress } from "./abis";
import BaseInterface from "./interfaces/BaseInterface";

export type CertProps = {
    id: number,
    name?: string,
    verifiedAt?: number,
    candidateAddress?: string,
    verifierAddress?: string,
    certAddress?: string
}

export default class Certificate extends BaseInterface {
    constructor(provider: ethers.providers.Web3Provider) {
        super(provider, certificateAddress, certificateAbi);
    }

    // async getCertificate(id: number) {
    //     const cert = await this._contract.getCertificate(id);

    //     console.log(cert);

    //     return {
    //         name: cert.name,
    //         verified_at: Number(cert.verifiedAt),
    //         candidate_address: cert.candidateAddress
    //     }
    // }

    async getDocument(certificateAddress: string) {
        const cert = await this._contract.getDocument(certificateAddress);

        // return {
        //     name: cert.name,
        //     verified_at: Number(cert.verifiedAt),
        //     candidate_address: cert.candidateAddress
        // }
        return cert;
    }

    async getCertificatecandidate(certificateAddress: string, lindex: number) {
        const cert = await this._contract.getCertificatecandidate(certificateAddress, lindex);

        // return {
        //     name: cert.name,
        //     verified_at: Number(cert.verifiedAt),
        //     candidate_address: cert.candidateAddress
        // }
        return cert;
    }

    async getCertificateVerifier(certificateAddress: string, lindex: number) {
        const cert = await this._contract.getCertificateVerifier(certificateAddress, lindex);

        // return {
        //     name: cert.name,
        //     verified_at: Number(cert.verifiedAt),
        //     candidate_address: cert.candidateAddress
        // }
        return cert;
    }

    async addCertificate({ id, name, verifiedAt, candidateAddress, verifierAddress, certAddress }: CertProps) {
        const addTx = await this._contract.addCertificate(id, name, verifiedAt, candidateAddress, verifierAddress, certAddress, this._option);
        const result = await this._handleTransactionRespone(addTx);

        return result;
    }

    // async updateCertificate({ id, name, verifiedAt }: CertProps) {
    //     const cert = await this.getCertificate(id);
    //     const updateTx = await this._contract.updateCertificate(
    //         id,
    //         name ?? cert.name,
    //         verifiedAt ?? cert.verified_at,
    //         this._option
    //     )
    //     const result = await this._handleTransactionRespone(updateTx);

    //     return result;
    // }

    async deleteCertificate(id: number) {
        const deleteTx = await this._contract.deleteCertificate(id, this._option);
        const result = await this._handleTransactionRespone(deleteTx);

        return result;
    }
}