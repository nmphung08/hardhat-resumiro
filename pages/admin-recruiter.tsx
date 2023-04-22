import React from 'react'

import { Web3Context } from '@/src/context/Web3Context';
import CompanyContract from "@/src/contracts/Company";

type Props = {}

const AdminRecruiter = (props: Props) => {
    const [recruiterAddress, setRecruiterAddress] = React.useState<string>();
    const [companyId, setCompanyId] = React.useState<string>();
    const { provider } = React.useContext(Web3Context);

    const handleCompanyRecruiter = async (action: number) => {
        try {
            if (!provider || !recruiterAddress || !companyId) {
                console.log("Cut");
                return;
            }
            let result;
            const companyContract = new CompanyContract(provider);
            switch (action) {
                case 0:
                    result = await companyContract.connectCompanyRecruiter({ recruiterAddress, companyId: Number(companyId) });
                    break;
                case 1:
                    result = await companyContract.disconnectCompanyRecruiter({ recruiterAddress, companyId: Number(companyId) });
                    break;
                default:
                    break;
            }

            console.log(result);

            if (!result) {
                throw new Error("Not have result");
            }
            if (result.status == 1) {
                alert("Success transaction");
            } else {
                alert("Failed transaction");
            }
        } catch (error: any) {
            console.log(error);
            console.log("Loi o Company-Recruiter");
        }
    }

    return (
        <div>
            <label>Company-Recruiter</label>
            <div>
                <label>Input Recruiter Address: </label>
                <input type="text" className="bg-gray-300 w-50" onChange={(e) => setRecruiterAddress(e.target.value)} />
            </div>
            <div>
                <label>Input Company Id: </label>
                <input type="text" className="bg-gray-300 w-50" onChange={(e) => setCompanyId(e.target.value)} />
            </div>
            <button className="bg-blue-500 hover:bg-blue-700 text-white  py-1 m-2 px-4 rounded-full" onClick={() => handleCompanyRecruiter(0)}>Connect</button>
            <button className="bg-red-500 hover:bg-red-700 text-white  py-1 m-2 px-4 rounded-full" onClick={() => handleCompanyRecruiter(1)}>Disconnect</button>
        </div>
    )
}

export default AdminRecruiter