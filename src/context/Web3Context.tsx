import { ethers } from 'ethers'
import React, { ReactNode } from 'react'
import UserContract from '@/src/contracts/User'

type Props = {
    children: ReactNode
}

type Wallet = {
    address: string,
    amount: number,
}

type contextProps = {
    provider?: ethers.providers.Web3Provider,
    signer?: ethers.providers.JsonRpcSigner,
    wallet?: Wallet,
    handleConnectWallet?: any,
    handleAddUser?: any
}

export const Web3Context = React.createContext<contextProps>({});

declare var window: any;

export const Web3Provider = ({ children }: Props) => {
    const [wallet, setWallet] = React.useState<Wallet>();
    const [provider, setProvider] = React.useState<ethers.providers.Web3Provider>();

    const handleConnectWallet = async () => {
        try {
            if (!window.ethereum) alert("Please install metamask!")

            console.log('...connecting wallet');
            const provider = new ethers.providers.Web3Provider(window.ethereum, undefined);
            await provider.send("eth_requestAccounts", []);
            const signer = provider.getSigner();
            // const accounts = window.ethereum.request({ method: "eth_requestAccounts" });

            const address = await signer.getAddress();
            const amount = Number(ethers.utils.formatEther(await signer.getBalance()));
            // const balance = (await signer.getBalance()).toNumber;

            setProvider(provider);
            setWallet({ address, amount });
            console.log('connect wallet done');
        } catch (error) {
            console.log(error);
            console.log('connect wallet done');

            throw new Error("No ethereum Object");
        }
    }

    //======================USER=========================

    return (
        <Web3Context.Provider value={{ provider, wallet, handleConnectWallet }}>
            {children}
        </Web3Context.Provider>
    )
}