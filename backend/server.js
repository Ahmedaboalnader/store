const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

let db;
async function initDB() {
  try {
    db = await mysql.createConnection(process.env.DATABASE_URL);
    console.log('✅ Connected to Google Cloud SQL');
  } catch (err) {
    console.error('❌ Database connection failed:', err);
  }
}
initDB();

app.get('/', (req, res) => res.send('Backend server running ✅'));

app.listen(PORT, '0.0.0.0', () => console.log(`🚀 Server running on port ${PORT}`));
