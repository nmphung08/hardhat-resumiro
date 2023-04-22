import Link from 'next/link'
import React from 'react'
import { Web3Context } from '@/src/context/Web3Context';
import { shortenAddress } from '@/src/utils/shortenAddress';

type Props = {}

const Header = (props: Props) => {
    const { wallet, handleConnectWallet } = React.useContext(Web3Context);

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

                {!wallet ?
                    <button
                        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-4 rounded-full"
                        onClick={handleConnectWallet}
                    >
                        Connect Wallet
                    </button> :
                    <button
                        className="bg-blue-700 text-white font-bold py-1 px-4 rounded-full items-center"
                    >
                        <div>{shortenAddress(wallet.address)}</div>
                        <div>{wallet.amount} ETH</div>
                    </button>
                }
            </div>
        </nav>
    )
}

export default Header