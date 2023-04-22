import React from "react";
import { Web3Context } from "@/src/context/Web3Context";
import CertificateContract from "@/src/contracts/Certificate";
import { useState } from "react";
import styles from "./form.module.css";
import { shortenAddress } from '@/src/utils/shortenAddress';

type Props = {};

const Certificate = (props: Props) => {
  const { provider, wallet } = React.useContext(Web3Context);
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [selectedFile, setSelectedFile] = useState(null);
  const [selectedUser, setSelectedUser] = useState("");

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

        if (!provider) {
            console.log("Out");
            return;
        }

        const certificateContract = new CertificateContract(provider);
        const test = wallet?.address;
        let candidateAddress = "0x0000000000000000000000000000000000000000";
        if (wallet) {
            candidateAddress = shortenAddress(wallet.address);
        }
        let doc = {
            id: 1,
            name: "Ngoc",
            verifiedAt: 2003,
            candidateAddress
        }
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
        console.log("handle user contract done");

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
            type="file"
            id="selectedFile"
            onChange={handleFileInputChange}
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
            <option value="user1">User 1</option>
            <option value="user2">User 2</option>
            <option value="user3">User 3</option>
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
