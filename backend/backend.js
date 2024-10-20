import express from "express";
import mysql from "mysql2";
import cors from "cors";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

const app = express();
app.use(express.json());
app.use(cors());

const JWT_SECRET = "secret-cloud-jwt-clinic-1234";

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "db",
});

app.post("/register", (req, res) => {
  const values = [
    req.body.hos_name,
    req.body.email,
    req.body.hos_no,
    req.body.hos_address,
    req.body.password,
  ];

  const sql =
    "INSERT INTO user_details (`hos_name`, `email`, `hos_no`, `hos_address`, `password`) VALUES(?)";

  db.query(sql, [values], (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
});

app.post('/login', (req, res) => {
  const { email, password } = req.body;

  const sql = 'SELECT admin_id AS user_id, name, email, password, role FROM admin_details WHERE email = ? UNION ALL SELECT doctor_id AS user_id, name, email, password, role FROM doctor_details WHERE email = ? UNION ALL SELECT patient_id AS user_id, name, email, password, role FROM patient_details WHERE email = ?';

  db.query(sql, [email, email, email], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Database error' });
    }

    if (results.length === 0) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    const user = results[0];

    if (user.password !== password) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }

    const token = jwt.sign({ userId: user.user_id, role: user.role }, JWT_SECRET, { expiresIn: '1h' });

    return res.status(200).json({
      message: 'Login successful',
      token,
      role: user.role
    });
  });
});

app.get('/profile', (req, res) => {
  const token = req.headers.authorization?.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'Access denied, no token provided.' });
  }

  jwt.verify(token, JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(403).json({ error: 'Invalid token.' });
    }

    const { userId } = decoded;

    const sql = 'SELECT * FROM user_details WHERE user_id = ?';
    db.query(sql, [userId], (err, results) => {
      if (err) {
        return res.status(500).json({ error: 'Database error' });
      }

      if (results.length === 0) {
        return res.status(404).json({ error: 'User not found' });
      }

      const user = results[0];

      return res.status(200).json({
        id: user.user_id,
        name: user.name,
        email: user.email,
        phone_no: user.phone_no,
        address: user.address,
        gender: user.gender,
        role: user.role,
      });
    });
  });
});

app.listen(8081, () => {
  console.log("Listening on port 8081");
});
