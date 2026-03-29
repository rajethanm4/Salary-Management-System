import { BrowserRouter, Routes, Route } from "react-router-dom";
import Employees from "./pages/Employees";
import CreateEmployee from "./pages/CreateEmployee";
import Salary from "./pages/Salary";
import Metrics from "./pages/Metrics";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Employees />} />
        <Route path="/create" element={<CreateEmployee />} />
        <Route path="/employees/:id/salary" element={<Salary />} />
        <Route path="/metrics" element={<Metrics />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
