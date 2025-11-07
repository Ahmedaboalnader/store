const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');

const app = express();
app.use(cors());

const PORT = process.env.PORT || 5000;


let db;
async function initDB() {
  try {
    db = await mysql.createConnection({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASS,
      database: process.env.DB_NAME,
    });
    console.log('✅ Connected to Google Cloud SQL');
  } catch (err) {
    console.error('❌ Database connection failed:', err.message);
  }
}
initDB();

app.get('/', (req, res) => res.send('Backend server running ✅'));

app.listen(PORT, '0.0.0.0', () => console.log(`🚀 Server running on port ${PORT}`));
