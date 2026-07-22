import { useState } from "react";
import Login from "./Login";
import Register from "./Register";
import "./App.css";

export default function App() {
  const [page, setPage] = useState("login");
  const [user, setUser] = useState(null);

  function handleLogout() {
    localStorage.clear();
    setUser(null);
    setPage("login");
  }

  if (user) {
    return (
      <div className="card">
        <h2>Welcome, {user.name}</h2>
        <p>You are signed in as <strong>{user.role}</strong>.</p>
        <p className="muted">Your session token is stored in the browser.</p>
        <button onClick={handleLogout}>Log out</button>
      </div>
    );
  }

  return page === "login" ? (
    <Login onSuccess={setUser} goToRegister={() => setPage("register")} />
  ) : (
    <Register goToLogin={() => setPage("login")} />
  );
}
