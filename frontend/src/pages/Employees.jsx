import { useEffect, useState } from "react";
import api from "../api";
import { Link } from "react-router-dom";

export default function Employees() {
  const [employees, setEmployees] = useState([]);

  useEffect(() => {
    api.get("/employees")
      .then((res) => {
        setEmployees(res.data.data);
      })
      .catch((err) => console.error(err));
  }, []);

  return (
    <div>
      <h1>Employees</h1>
      <Link to="/create">Create Employee</Link>
      {employees.map((emp) => (
        <div key={emp.id}>
          <p>{emp.full_name}</p>
          <p>{emp.job_title}</p>
          <p>{emp.country}</p>
          <p>₹{emp.salary}</p>
          <Link to={`/employees/${emp.id}/salary`}>View Salary</Link>
          <Link to="/metrics">View Metrics</Link>
          <hr />
        </div>
        
      ))}
    </div>
  );
}
