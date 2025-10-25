const express = require('express');
const cors = require('cors');
const app = express();

// استخدم البورت اللى Cloud Run هيباصيه
const PORT = process.env.PORT || 5000;

app.use(cors({
  origin: "*"
}));
app.use(express.json());

const products = [
  { id: 1, name: 'Laptop', price: 15000 },
  { id: 2, name: 'Phone', price: 10000 },
  { id: 3, name: 'Headphones', price: 1200 },
];

app.get('/', (req, res) => {
  res.send('Backend server is running successfully ✅');
});

app.get('/products', (req, res) => {
  res.json(products);
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
