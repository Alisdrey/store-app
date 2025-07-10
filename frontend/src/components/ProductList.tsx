import type { Product } from "../types/product";

interface ProductListProps {
  products: Product[];
  onEdit: (product: Product) => void;
  onDelete: (id: string) => void;
  loading: boolean;
  error: string | null;
}

export function ProductList({
  products,
  onEdit,
  onDelete,
}: ProductListProps) {
  return (
    <ul>
      {products.map((p) => (
        <li key={p.id} className="d-flex gap-4">
          {p.name} - R$ {p.price}
          <button onClick={() => onEdit(p)}>Edit</button>
          <button onClick={() => onDelete(p.id)}>Delete</button>
        </li>
      ))}
    </ul>
  );
}
