import React, { useEffect } from "react";
import { Web3Context } from "@/src/context/Web3Context";
import CertificateContract from "@/src/contracts/Certificate";
import UserContract, { UserProps } from "@/src/contracts/User";
import { useState } from "react";
import styles from "./form.module.css";
import { ethers } from "ethers";

declare var window: any;

const Certificate = () => {
  const { provider, wallet, isConnected } = React.useContext(Web3Context);
  const [name, setName] = useState("");
  const [verifiers, setVerifiers] = useState([]);
  const [description, setDescription] = useState("");
  const [selectedFile, setSelectedFile] = useState("");
  const [selectedUser, setSelectedUser] = useState("");
  const [address, setAddress] = useState("");
  // const [wallet, setWallet] = useState({address: "", amount: 0});

  const connectWallet = async() => {
    let address : any;
    
    if ("true" === localStorage?.getItem("isWalletConnected")) {
        address = localStorage?.getItem('metamaskAddress')
        if (address !== null) {
            setAddress(address);
            isConnected();
        }
    }
}

  useEffect(() => {
    connectWallet();
  }, [])

  useEffect(() => {
    if (provider) {
      ((async () => {
          const userContract = new UserContract(provider);
          const result = await userContract.getVerifiers();
          setVerifiers(result);
          console.log(result);
      }))()
  }
  }, [wallet])

  const handleSubmit = async (event: any) => {
    event.preventDefault();
    console.log("Form submitted:", {
      name,
      description,
      selectedFile,
      selectedUser,
      wallet
    });
    try {
        console.log("...handling user contract");

        if (!provider || !wallet) {
            console.log("Out");
            return;
        }

        const certificateContract = new CertificateContract(provider);
        const candidateAddress = wallet.address;
        let doc = {
            id: 0,
            name,
            verifiedAt: (new Date()).getTime(),
            candidateAddress,
            verifierAddress: selectedUser,
            certAddress: "bafybeibdv3wg7iy7rpb7duykdotznprtwb7v2z5pyrtywyvytcrg7zbunq"
        }
        console.log(doc)
        let result = await certificateContract.addCertificate(doc);

        if (result.status == 1) {
            alert("Success transaction");
        } else {
            alert("Failed transaction");
        }

        console.log(result);
        console.log("handle user contract done");
    } catch (error) {
        console.log(error);
        console.log("handle user contract error");

        throw new Error("No ethereum Object");
    }
  };

  const handleFileInputChange = (event: any) => {
    const file = event.target.files[0];
    console.log("Selected file:", file);
    setSelectedFile(file);
  };

  const handleUserSelectChange = (event: any) => {
    const user = event.target.value;
    console.log("Selected user:", user);
    setSelectedUser(user);
  };

  return (
    <div className={styles.container}>
      <h1>Create New Item</h1>
      <form onSubmit={(e) => handleSubmit(e)}>
        <div className={styles.formGroup}>
          <label htmlFor="name" style={{ marginBottom: "5px" }}>
            Name:
          </label>
          <input
            style={{
              padding: "10px",
              fontSize: "16px",
              border: "1px solid #ccc",
              borderRadius: "5px",
            }}
            type="text"
            id="name"
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
          />
        </div>
        <div className={styles.formGroup}>
          <label htmlFor="description" style={{ marginBottom: "5px" }}>
            Description:
          </label>
          <textarea
            style={{ height: "100px", resize: "none", padding: "10px",
            fontSize: "16px",
            border: "1px solid #ccc",
            borderRadius: "5px" }}
            id="description"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
          ></textarea>
        </div>
        <div className={styles.formGroup}>
          <label htmlFor="selectedFile" style={{ marginBottom: "5px" }}>
            Choose File:
          </label>
          <input
            type="text"
            id="selectedFile"
            onChange={(e) => setSelectedFile(e.target.value)}
          />
        </div>
        <div className={styles.formGroup}>
          <label htmlFor="selectedUser" style={{ marginBottom: "5px" }}>
            Choose User:
          </label>
          <select
            style={{ padding: '10px',
                fontSize: '16px',
                border: '1px solid #ccc',
                borderRadius: '5px'}}
            id="selectedUser"
            value={selectedUser}
            onChange={handleUserSelectChange}
          >
            <option value="">-- Select User --</option>
            {/* <option value="0xcf6f5811a1bcA80B632735301A615C863AEdf7fb">Test 2</option>
            <option value="user2">User 2</option>
            <option value="user3">User 3</option> */}
            {verifiers.map((element) => (<option value={element}>{element}</option>))}
          </select>
        </div>
        <div className={styles.buttons}>
          <button
            className="mybutton"
            type="submit"
            style={{ backgroundColor: "#008000", color: "#fff" }}
          >
            Submit
          </button>
          <button
            className="mybutton"
            type="button"
            onClick={() => window.history.back()}
            style={{ backgroundColor: "#ccc", color: "#fff" }}
          >
            Back
          </button>
        </div>
      </form>
    </div>
  );
};

export default Certificate;
