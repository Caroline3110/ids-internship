import { useState } from "react";
import { register } from "./api";

export default function Register({ goToLogin }) {
  const [form, setForm] = useState({
    firstName: "",
    lastName: "",
    email: "",
    password: "",
    roleId: 4,
  });
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");
  const [loading, setLoading] = useState(false);

  function update(field, value) {
    setForm({ ...form, [field]: value });
  }

  async function handleSubmit(e) {
    e.preventDefault();
    setError("");
    setSuccess("");
    setLoading(true);
    try {
      await register(form);
      setSuccess("Account created. You can now sign in.");
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="card">
      <h2>Create an account</h2>
      <form onSubmit={handleSubmit}>
        <label>First name</label>
        <input value={form.firstName} onChange={(e) => update("firstName", e.target.value)} required />
        <label>Last name</label>
        <input value={form.lastName} onChange={(e) => update("lastName", e.target.value)} required />
        <label>Email</label>
        <input type="email" value={form.email} onChange={(e) => update("email", e.target.value)} required />
        <label>Password</label>
        <input type="password" value={form.password} onChange={(e) => update("password", e.target.value)} required />
        <label>Role</label>
        <select value={form.roleId} onChange={(e) => update("roleId", Number(e.target.value))}>
          <option value={4}>Employee</option>
          <option value={3}>IT Support Agent</option>
          <option value={2}>Manager</option>
          <option value={1}>Admin</option>
        </select>
        {error && <p className="error">{error}</p>}
        {success && <p className="success">{success}</p>}
        <button type="submit" disabled={loading}>
          {loading ? "Creating..." : "Register"}
        </button>
      </form>
      <p className="link" onClick={goToLogin}>
        Already have an account? Sign in
      </p>
    </div>
  );
}
