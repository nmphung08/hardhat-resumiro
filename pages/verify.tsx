import { useState } from 'react';

export default function Table() {
  // Define a sample data for the table
  const [data, setData] = useState([
    { id: 1, name: 'Item 1', description: 'Description 1', status: 'Pending', transaction: 'Transaction 1' },
    { id: 2, name: 'Item 2', description: 'Description 2', status: 'Verified', transaction: 'Transaction 2' },
    { id: 3, name: 'Item 3', description: 'Description 3', status: 'Rejected', transaction: 'Transaction 3' },
    { id: 4, name: 'Item 4', description: 'Description 4', status: 'Pending', transaction: 'Transaction 4' },
  ]);

  // Render the table
  return (
    <div className="container mx-auto">
      <h1 className="text-3xl font-bold mt-10 mb-5">Table</h1>
      <table className="table-auto w-full">
        <thead>
          <tr className="bg-gray-200">
            <th className="py-2 px-4 text-left">Name</th>
            <th className="py-2 px-4 text-left">Description</th>
            <th className="py-2 px-4 text-left">Status</th>
            <th className="py-2 px-4 text-left">Transaction</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item) => (
            <tr key={item.id} className="border">
              <td className="py-2 px-4">{item.name}</td>
              <td className="py-2 px-4">{item.description}</td>
              <td className="py-2 px-4">{item.status}</td>
              <td className="py-2 px-4">{item.transaction}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
