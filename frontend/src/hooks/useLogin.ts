import { useState } from "react";
import api from "../services/api";
import { useAuth } from "../auth";

export function useLogin() {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const { login: setAuthToken } = useAuth();

  const login = async (email: string, password: string): Promise<boolean> => {
    setLoading(true);
    setError(null);

    try {
      const response = await api.post("/auth/login", { email, password });
      setAuthToken(response.data.token);
      return true;
    } catch (err: any) {
      const message =
        err?.response?.data?.message ||
        err?.response?.data?.error ||
        err?.message ||
        "An unexpected error occurred. Please try again.";

      setError(message);
      return false;
    } finally {
      setLoading(false);
    }
  };

  return { login, loading, error };
}
