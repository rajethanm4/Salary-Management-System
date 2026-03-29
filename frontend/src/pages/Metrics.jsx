import { useState } from "react";
import api from "../api";

export default function Metrics() {
  const [country, setCountry] = useState("");
  const [jobTitle, setJobTitle] = useState("");
  const [data, setData] = useState(null);
  const [type, setType] = useState(""); // "country" or "job"

  const fetchByCountry = async () => {
    try {
      const res = await api.get(`/metrics/salary/country/${country}`);
      setData(res.data);
      setType("country");
    } catch (err) {
      console.error(err);
      alert("No data found for this country");
      setData(null);
    }
  };

  const fetchByJobTitle = async () => {
    try {
      const res = await api.get(`/metrics/salary/job_title/${jobTitle}`);
      setData(res.data);
      setType("job");
    } catch (err) {
      console.error(err);
      alert("No data found for this job title");
      setData(null);
    }
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>📊 Salary Metrics</h1>

      {/* Country Section */}
      <div style={{ marginBottom: "20px" }}>
        <h3>By Country</h3>
        <input
          placeholder="Enter country (e.g. india)"
          value={country}
          onChange={(e) => setCountry(e.target.value)}
        />
        <button onClick={fetchByCountry}>Get Country Stats</button>
      </div>

      {/* Job Title Section */}
      <div style={{ marginBottom: "20px" }}>
        <h3>By Job Title</h3>
        <input
          placeholder="Enter job title (e.g. engineer)"
          value={jobTitle}
          onChange={(e) => setJobTitle(e.target.value)}
        />
        <button onClick={fetchByJobTitle}>Get Job Stats</button>
      </div>

      {/* Result Section */}
      {data && (
        <div style={{ marginTop: "20px", border: "1px solid #ccc", padding: "15px" }}>
          <h2>Results</h2>

          {type === "country" && (
            <>
              <p><strong>Country:</strong> {data.country}</p>
              <p><strong>Employees:</strong> {data.employee_count}</p>
              <p><strong>Minimum Salary:</strong> ₹{data.minimum_salary}</p>
              <p><strong>Maximum Salary:</strong> ₹{data.maximum_salary}</p>
              <p><strong>Average Salary:</strong> ₹{data.average_salary}</p>
            </>
          )}

          {type === "job" && (
            <>
              <p><strong>Job Title:</strong> {data.job_title}</p>
              <p><strong>Employees:</strong> {data.employee_count}</p>
              <p><strong>Average Salary:</strong> ₹{data.average_salary}</p>
            </>
          )}
        </div>
      )}
    </div>
  );
}
