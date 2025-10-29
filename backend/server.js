const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise'); // MySQL client
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

const DB_HOST = process.env.DATABASE_HOST;
const DB_USER = process.env.DB_USER;
const DB_PASS = process.env.DB_PASS;
const DB_NAME = process.env.DB_NAME;

app.use(cors({ origin: "*" }));
app.use(express.json());

// إنشاء اتصال بالقاعدة عند التشغيل
let db;
async function initDB() {
  try {
    db = await mysql.createPool({
      host: DB_HOST,
      user: DB_USER,
      password: DB_PASS,
      database: DB_NAME,
      waitForConnections: true,
      connectionLimit: 10,
    });
    console.log('Connected to Google Cloud SQL ✅');
  } catch (err) {
    console.error('Error connecting to DB:', err);
  }
}
initDB();

app.get('/', (req, res) => {
  res.send('Backend server is running successfully ✅');
});

app.get('/products', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT id, name, price FROM products');
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Database error');
  }
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
