import { useEffect, useState } from 'react';

function App() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const backendUrl = process.env.REACT_APP_API_URL || 'http://localhost:5000/products';

    fetch(`${backendUrl}/products`)
      .then(res => res.json())
      .then(data => setProducts(data))
      .catch(err => console.error('❌ Error fetching products:', err));
  }, []);

  const removeProduct = (id) => {
    setProducts(products.filter(p => p.id !== id));
  };

  const addProduct = () => {
    const newProduct = {
      id: products.length + 1,
      name: 'New Product',
      price: Math.floor(Math.random() * 10000)
    };
    setProducts([...products, newProduct]);
  };

  return (
    <div className="min-h-screen bg-gray-100 p-6">
      <h1 className="text-3xl font-bold mb-6 text-center">Product List</h1>
      <div className="flex justify-center mb-6">
        <button
          onClick={addProduct}
          className="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600"
        >
          Add Product
        </button>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {products.map(product => (
          <div key={product.id} className="bg-white p-4 rounded shadow">
            <h2 className="text-xl font-semibold">{product.name}</h2>
            <p className="text-gray-700 mb-4">{product.price} EGP</p>
            <div className="flex gap-2">
              <button
                onClick={() => removeProduct(product.id)}
                className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600"
              >
                Remove
              </button>
              <button
                onClick={() => alert(`Buying ${product.name}`)}
                className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
              >
                Buy
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default App;
