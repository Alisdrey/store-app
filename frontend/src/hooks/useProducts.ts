import { useEffect, useState } from "react";
import api from "../services/api";
import type { Product } from "../types/product";

export function useProducts() {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const token = localStorage.getItem("token");

  const fetchProducts = async () => {
    try {
      setLoading(true);
      setError(null);
      const res = await api.get("/products", {
        headers: { Authorization: `Bearer ${token}` },
      });
      setProducts(res.data.data);
    } catch (err) {
      console.error("Failed to fetch products:", err);
      setError("Failed to fetch products.");
    } finally {
      setLoading(false);
    }
  };

  const createProduct = async (product: Omit<Product, "id">) => {
    try {
      setLoading(true);
      setError(null);
      await api.post("/products", { product }, {
        headers: { Authorization: `Bearer ${token}` },
      });
      await fetchProducts();
    } catch (err) {
      console.error("Failed to create product:", err);
      setError("Failed to create product.");
    }
    finally {
      setLoading(false);
    }
  };

  const updateProduct = async (id: string, data: Omit<Product, "id">) => {
    try {
      await api.put(`/products/${id}`, { product: data }, {
        headers: { Authorization: `Bearer ${token}` },
      });
      await fetchProducts();
    } catch (err: any) {
      console.error("Error updating product:", err);
      setError("Failed to update product.");
    }
  };

  const deleteProduct = async (id: string) => {
    try {
      setLoading(true);
      setError(null);
      await api.delete(`/products/${id}`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      await fetchProducts();
    } catch (err) {
      console.error(`Failed to delete product with ID ${id}:`, err);
      setError("Failed to delete product.");
    }
    finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchProducts();
  }, []);

  return {
    products,
    loading,
    error,
    createProduct,
    deleteProduct,
    updateProduct,
    refetch: fetchProducts,
  };
}
