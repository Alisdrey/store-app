import { useState } from "react";
import { useProducts } from "../hooks/useProducts";
import type { Product } from "../types/product";
import { ProductList } from "../components/ProductList";

export default function Products() {
  const [form, setForm] = useState({
    id: undefined as string | undefined,
    name: "",
    description: "",
    price: "",
  });

  const {
    products = [],
    loading,
    createProduct,
    deleteProduct,
    updateProduct,
    error,
  } = useProducts();

  const handleSubmit = async () => {
    if (!form.name.trim() || !form.price.trim()) {
      alert("Name and price are required.");
      return;
    }

    if (isEditing && form.id) {
      await updateProduct(form.id, {
        name: form.name,
        description: form.description,
        price: Number(form.price),
      });
    } else {
      await createProduct({
        name: form.name,
        description: form.description,
        price: Number(form.price),
      });
    }

    setForm({ id: undefined, name: "", description: "", price: "" });
  };

  const handleEdit = (product: Product) => {
    setForm({
      id: product.id,
      name: product.name,
      description: product.description,
      price: String(product.price),
    });
  };

  const isEditing = !!form.id;

  return (
    <div>
      <h1>Products</h1>

      <div className="d-flex gap-4">
        <input
          placeholder="Name"
          value={form.name}
          onChange={(e) => setForm({ ...form, name: e.target.value })}
        />
        <input
          placeholder="Description"
          value={form.description}
          onChange={(e) => setForm({ ...form, description: e.target.value })}
        />
        <input
          placeholder="Price"
          type="number"
          value={form.price}
          onChange={(e) => setForm({ ...form, price: e.target.value })}
        />

        <button onClick={handleSubmit} disabled={loading || !form.name || !form.price}>
          {loading ? (isEditing ? "Updating..." : "Adding...") : isEditing ? "Update" : "Add"}
        </button>
      </div>

      {loading && <p>Loading products...</p>}
      {!loading && error && <p style={{ color: "red" }}>{error}</p>}
      {!loading && !error && products.length === 0 && <p>No products found.</p>}

      <ProductList
        products={products}
        onEdit={handleEdit}
        onDelete={deleteProduct}
        loading={loading}
        error={error}
      />
    </div>
  );
}
