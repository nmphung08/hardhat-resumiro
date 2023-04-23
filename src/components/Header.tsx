import Link from 'next/link'
import React, { useEffect, useState } from 'react'
import { Web3Context } from '@/src/context/Web3Context';
import { shortenAddress } from '@/src/utils/shortenAddress';
import { ethers } from 'ethers';
import { IsConnectedWallet } from "@/src/utils/IsConnectedWallet";

type Props = {}
declare var window: any;

const Header = (props: Props) => {
    const { wallet, handleConnectWallet, provider } = React.useContext(Web3Context);

    const [isConnected,setIsConnected] = useState(false);
    const [address, setAddress] = useState(typeof window !== 'undefined' ? localStorage?.getItem('metamaskAddress') ?? "" : "");
    const [amount, setAmount] = useState(typeof window !== 'undefined' ? localStorage?.getItem('metamaskAmount') ?? 0 : 0);

    const connectWallet = async() => {
        let address : any;
        
        if ("true" === localStorage?.getItem("isWalletConnected")) {
            
            setIsConnected(true);
            address = localStorage?.getItem('metamaskAddress')
            if (address !== null) {
                setAddress(address);
                const provider = new ethers.providers.Web3Provider(window.ethereum);
                await provider.send("eth_requestAccounts", []);
                const signer = provider.getSigner();
                const amount = Number(ethers.utils.formatEther(await signer.getBalance()));
                setAmount(amount);
            }
        }
    }

    useEffect(() => {  

        if (wallet) {
            setIsConnected(true);
            setAddress(wallet.address);
            setAmount(wallet.amount);
        }
        
        connectWallet();
    }, [wallet])

    const handleLogOut = () => {
        localStorage?.setItem("isWalletConnected", "false");
        localStorage?.removeItem("metamaskAddress");
    }

    return (
        <nav className='p-1 border-b-2 flex flex-row justify-between items-center'>
            <div>Demo Web3 Resumiro</div>
            <div className='flex flex-row items-center'>
                <Link className='mr-4 p-6' href="/certificate">
                    Certificate
                </Link>
                <Link className='mr-4 p-6' href="/candidate">
                    Candidate
                </Link>
                <Link className='mr-4 p-6' href="/recruiter">
                    Recruiter
                </Link>
                <Link className='mr-4 p-6' href="/admin-recruiter">
                    Admin of Recruiter
                </Link>
                <Link className='mr-4 p-6' href="/admin">
                    Admin
                </Link>

                {!isConnected ?
                    <button
                        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-4 rounded-full"
                        onClick={handleConnectWallet}
                    >
                        Connect Wallet
                    </button> :
                    <button
                        className="bg-blue-700 text-white font-bold py-1 px-4 rounded-full items-center"
                        onClick={handleLogOut}
                    >
                        <div>{shortenAddress(address)}</div>
                        <div>{amount} ETH</div>
                    </button>
                }
            </div>
        </nav>
    )
}

export default Header