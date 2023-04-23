import { ethers } from 'ethers'

declare var window: any;

export const IsConnectedWallet = async() => {
    let address : any;
    let isConnected = false;
    let amount = 0;
    let provider : any;
    
    if ("true" === localStorage?.getItem("isWalletConnected")) {
        isConnected = true;
        address = localStorage?.getItem('metamaskAddress')
        if (address !== null) {
            provider = new ethers.providers.Web3Provider(window.ethereum);
            await provider.send("eth_requestAccounts", []);
            const signer = provider.getSigner();
            amount = Number(ethers.utils.formatEther(await signer.getBalance()));
        }
    }

    return {isConnected, address, amount, provider}
}

// useEffect(() => {
//     if (wallet) {
//         setIsConnected(true);
//     }
//     const connectWallet = async() => {
//         if ("true" === localStorage?.getItem("isWalletConnected")) {
//             setIsConnected(true);
//             const address = localStorage?.getItem('metamaskAddress')
//             const provider = localStorage?.getItem('metamaskProvider')
//             if (address !== null && provider !== null)
//             {
//                 setAddress(address);
//                 const signer = (JSON.parse(provider)).getSigner();
//                 const amount = Number(ethers.utils.formatEther(await signer.getBalance()));
//                 setAmount(amount);
//             }
//         }
//     }
//     connectWallet
// }, [wallet])

            // localStorage.setItem('metamaskAddress', address);
            // localStorage.setItem('metamaskProvider', JSON.stringify(provider));
            // localStorage.setItem('isWalletConnected', "true");