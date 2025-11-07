import express from "express";
import cors from "cors";
import mysql from "mysql2/promise";
import productRoutes from "./src/routes/productRoutes.js";

const app = express();
app.use(cors());
app.use(express.json()); 


let db;
async function initDB() {
  try {
    db = await mysql.createPool({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASS,
      database: process.env.DB_NAME,
    });
    console.log("✅ Connected to Google Cloud SQL");
  } catch (err) {
    console.error("❌ Database connection failed:", err.message);
  }
}
initDB();


app.get("/", (req, res) => res.send("Backend server running ✅"));

app.use("/products", productRoutes);


const PORT = process.env.PORT || 5000;
app.listen(PORT, "0.0.0.0", () =>
  console.log(`🚀 Server running on port ${PORT}`)
);

export { db };