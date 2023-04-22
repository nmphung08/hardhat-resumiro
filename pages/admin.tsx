import React from "react"
import { Web3Context } from '@/src/context/Web3Context';
import UserContract, { UserProps } from "@/src/contracts/User";
import CompanyContract, { CompanyProps } from "@/src/contracts/Company";

export default function Admin() {
    const { provider } = React.useContext(Web3Context);
    const [user, setUser] = React.useState<UserProps>({ userAddress: "", type: -1 });
    const [company, setCompany] = React.useState<CompanyProps>({ id: -1 });


    const handleAddUser = async () => {
        try {
            console.log("...handling user contract");

            if (!provider || user.userAddress == "" || user.type == -1) {
                console.log("Cut");
                console.log("handle user contract done");
                return;
            }

            const userContract = new UserContract(provider);
            let result: any = await userContract.addUser(user);

            if (result.status == 1) {
                alert("Success transaction");
            } else {
                alert("Failed transaction");
            }

            console.log(result);
            console.log("handle user contract done");
        } catch (error) {
            console.log(error);
            console.log("handle user contract done");

            throw new Error("No ethereum Object");
        }
    }

    const handleCompany = async (action: number) => {
        try {
            console.log("...handling company contract");
            if (!provider || company.id == -1 || company.name == "") {
                console.log("Cut");
                console.log("handle company contract done");
                return;
            }
            let result;
            const companyContract = new CompanyContract(provider);
            switch (action) {
                case 0:
                    result = await companyContract.addCompany(company);
                    break;
                case 1:
                    console.log(company);

                    result = await companyContract.updateCompany({ ...company });
                    break;
                case 2:
                    result = await companyContract.deleteCompany(company.id);
                    break;
                default:
                    break;
            }

            console.log(result);
            console.log("handle company contract done");

            if (!result) {
                throw new Error("Not have result");
            }
            if (result.status == 1) {
                alert("Success transaction");
            } else {
                alert("Failed transaction");
            }
        } catch (error) {
            console.log("handle company contract done");
            console.log(error);
        }
    }

    return (
        <>
            <div>
                <label>Add User</label>
                <div>
                    <label>Input User Address: </label>
                    <input type="text" className="bg-gray-300 w-50" onChange={(e) => setUser({ ...user, userAddress: e.target.value })} />
                </div>
                <div>
                    <label>Input User Type: </label>
                    <input type="text" className="bg-gray-300 w-50" onChange={(e) => setUser({ ...user, type: Number(e.target.value) })} />
                </div>
                <button className="bg-blue-500 hover:bg-blue-700 text-white  py-1 px-4 rounded-full" onClick={handleAddUser}>Add</button>
            </div>

            <div>
                <label>Company</label>
                <div>
                    <label>Input ID: </label>
                    <input type="text" className="bg-gray-300 w-50" onChange={(e) => setCompany({ ...company, id: Number(e.target.value) })} />
                </div>
                <div>
                    <label>Input Name: </label>
                    <input type="text" className="bg-gray-300 w-50" onChange={(e) => setCompany({ ...company, name: e.target.value })} />
                </div>
                <div>
                    <label>Input Website: </label>
                    <input type="text" className="bg-gray-300 w-50" onChange={(e) => setCompany({ ...company, website: e.target.value })} />
                </div>
                <div>
                    <label>Input Location: </label>
                    <input type="text" className="bg-gray-300 w-50" onChange={(e) => setCompany({ ...company, location: e.target.value })} />
                </div>
                <div>
                    <label>Input Address: </label>
                    <input type="text" className="bg-gray-300 w-50" onChange={(e) => setCompany({ ...company, address: e.target.value })} />
                </div>
                <button className="bg-blue-500 hover:bg-blue-700 text-white  py-1 m-2 px-4 rounded-full" onClick={() => handleCompany(0)}>Add</button>
                <button className="bg-green-500 hover:bg-green-700 text-white  py-1 m-2 px-4 rounded-full" onClick={() => handleCompany(1)}>Update</button>
                <button className="bg-red-500 hover:bg-red-700 text-white  py-1 m-2 px-4 rounded-full" onClick={() => handleCompany(2)}>Delete</button>
            </div>
        </>
    )
}
