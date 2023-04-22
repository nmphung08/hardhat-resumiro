import React from 'react'
import { Web3Context } from '@/src/context/Web3Context';
import ExperienceContract, { ExperienceProps } from "@/src/contracts/Experience";

type Props = {}

const Candidate = (props: Props) => {
    const { provider } = React.useContext(Web3Context);
    const [experience, setExperience] = React.useState<ExperienceProps>();

    return (
        <>
            <div>
                <label>Experience</label>
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

export default Candidate