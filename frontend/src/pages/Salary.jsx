import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import api from "../api";

export default function Salary() {
  const { id } = useParams();
  const [data, setData] = useState(null);

  useEffect(() => {
    api.get(`/employees/${id}/salary`)
      .then((res) => setData(res.data))
      .catch((err) => console.error(err));
  }, [id]);

  if (!data) return <p>Loading...</p>;

  return (
    <div>
      <h1>Salary Details</h1>

      <p><strong>Name:</strong> {data.full_name}</p>
      <p><strong>Country:</strong> {data.country}</p>
      <p><strong>Gross Salary:</strong> ₹{data.gross_salary}</p>

      <h3>Deductions</h3>
      {data.deductions.length === 0 ? (
        <p>No deductions</p>
      ) : (
        data.deductions.map((d, i) => (
          <div key={i}>
            <p>{d.name} ({d.rate}) - ₹{d.amount}</p>
          </div>
        ))
      )}

      <p><strong>Total Deductions:</strong> ₹{data.total_deductions}</p>
      <p><strong>Net Salary:</strong> ₹{data.net_salary}</p>
    </div>
  );
}