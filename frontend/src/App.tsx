import type { JSX } from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { useAuth } from "./auth";
import Login from "./pages/Login";
import Products from "./pages/Products";

function PublicRoute({ children }: { children: JSX.Element; }) {
  const { token } = useAuth();
  console.log(token);
  return token ? <Navigate to="/products" replace /> : children;
}

function PrivateRoute({ children }: { children: JSX.Element; }) {
  const { token } = useAuth();
  return token ? children : <Navigate to="/login" replace />;
}

export default function App() {
  return (
    <Router>
      <Routes>
        <Route
          path="/login"
          element={
            <PublicRoute>
              <Login />
            </PublicRoute>
          }
        />

        <Route
          path="/products"
          element={
            <PrivateRoute>
              <Products />
            </PrivateRoute>
          }
        />

        <Route path="*" element={<Navigate to="/products" replace />} />
      </Routes>
    </Router>
  );
}
