import { Web3Context } from '@/src/context/Web3Context';
import { useContext, useEffect, useState } from 'react';
import UserContract from "../src/contracts/User"
import CertificateContract from "../src/contracts/Certificate"

export default function Table() {
  // Define a sample data for the table
  const { provider, wallet, isConnected } = useContext(Web3Context);
  const [userType, setUserType] = useState(0);

  const [data, setData] = useState<{name: string, user: string, verifiedAt: number, certificateAddress: string, status: number} []>([]);;

  const connectWallet = async() => {
    let address : any;
      
    if ("true" === localStorage?.getItem("isWalletConnected")) {
        address = localStorage?.getItem('metamaskAddress')
        if (address !== null) {
            isConnected();
        }
    }
  }

  useEffect(() => {
    connectWallet();
  }, [])

  useEffect(() => {
    (async() => {
      if (provider && wallet) {
        const userContract = new UserContract(provider);
        const certificateContract = new CertificateContract(provider);

        userContract.getUser(wallet.address).then((user) => {
          setUserType(user.userType);
          certificateContract.getCount(wallet.address).then((count) => {

            let index = 0;
            for (let i = 0; i < count.toString(); i++) {
              if (user.userType === 2) {
                certificateContract.getCertificateVerifier(wallet.address, index).then((res) => {
                  const {name, candidate, verifiedAt, certificateAddress, status} = res;
                  index = res.index;
                  setData((data) => [...data, {name, user: candidate, verifiedAt: verifiedAt.toString(), certificateAddress, status: status.toString()}]);
                })
              } else if (user.userType === 0) {
                certificateContract.getCertificatecandidate(wallet.address, index).then((res) => {
                  const {name, verifier, verifiedAt, certificateAddress, status} = res;
                  index = res.index;
                  setData((data) => [...data, {name, user: verifier, verifiedAt: verifiedAt.toString(), certificateAddress, status: status.toString()}]);
                })
              }
            }
          }).catch((err) => {
            console.log(err);
          })
        })
        .catch((err) => {
          console.log(err);
        });
      }
    })()
  }, [wallet])

  const verifyCert = async(e: any) => {
    const status = e.target.value;
    const certificateAddress = e.target.closest("tr").dataset.key;
    
    if (provider && wallet) {
      const certificateContract = new CertificateContract(provider);
      certificateContract.updateCertificate(0, (new Date()).getTime(), wallet.address, certificateAddress, status)
      .then((result) => {
        console.log(result);
      }).catch((err) => {
        console.log(err);
      })
    }
  }

  // Render the table
  return (
    <div className="container mx-auto">
      <h1 className="text-3xl font-bold mt-10 mb-5">Table</h1>
      <table className="table-auto w-full">
        <thead>
          <tr className="bg-gray-200">
            <th className="py-2 px-4 text-left">Name</th>
            <th className="py-2 px-4 text-left">User</th>
            <th className="py-2 px-4 text-left">Status</th>
            <th className="py-2 px-4 text-left">Transaction</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, index) => (
            <tr data-key={item.certificateAddress} key={index} className="border">
              <td className="py-2 px-4">{item.name}</td>
              <td className="py-2 px-4">{item.user}</td>
              <td className="py-2 px-4">
                <select defaultValue={item.status} disabled={userType !== 2} onChange={(e) => verifyCert(e)}>
                  <option value={0}>Pending</option>
                  <option value={1}>Reject</option>
                  <option value={2}>Verify</option>
                </select>
              </td>
              <td className="py-2 px-4">{item.verifiedAt}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
