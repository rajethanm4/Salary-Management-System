import { useState } from "react";
import api from "../api";

export default function CreateEmployee() {
  const [form, setForm] = useState({
    full_name: "",
    job_title: "",
    country: "",
    salary: ""
  });

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      await api.post("/employees", {
        employee: {
          ...form,
          salary: Number(form.salary)
        }
      });

      alert("Employee created!");
    } catch (err) {
      console.error(err);
      alert("Error creating employee");
    }
  };

  return (
    <div>
      <h1>Create Employee</h1>

      <form onSubmit={handleSubmit}>
        <input name="full_name" placeholder="Name" onChange={handleChange} />
        <input name="job_title" placeholder="Job Title" onChange={handleChange} />
        <input name="country" placeholder="Country" onChange={handleChange} />
        <input name="salary" placeholder="Salary" onChange={handleChange} />

        <button type="submit">Create</button>
      </form>
    </div>
  );
}
