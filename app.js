// app.js
const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const nodemailer = require('nodemailer');
const User = require('./models/user');
const dotenv = require('dotenv');
const app = express();
const path = require('path');
dotenv.config();
require('dotenv').config();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));


app.get('/', (req, res) => {
    res.render('index.ejs');  // Or replace 'index.ejs' with your actual view
});

// Connect to MongoDB

mongoose.connect(process.env.MONGODB_URI, { 
    // Remove useNewUrlParser and useUnifiedTopology options
}).then(() => {
    console.log('MongoDB connected');
}).catch(err => {
    console.log('MongoDB connection error:', err);
});


// Login Route
app.get('/login', (req, res) => {
    res.render('login');
});

app.post('/login', async (req, res) => {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
        return res.status(400).send('User not found');
    }

    const isMatch = await user.matchPassword(password);
    if (!isMatch) {
        return res.status(400).send('Invalid credentials');
    }

    res.send('Login successful');
});

// Register Route
app.get('/register', (req, res) => {
    res.render('register');
});

app.post('/register', async (req, res) => {
    const { email, password } = req.body;

    const userExists = await User.findOne({ email });
    if (userExists) {
        return res.status(400).send('User already exists');
    }

    const user = new User({
        email,
        password
    });

    await user.save();
    res.redirect('/login');
});

// Forgot Password Route
app.get('/forgot-password', (req, res) => {
    res.render('reset-password');
});

app.post('/forgot-password', async (req, res) => {
    const { email } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
        return res.status(400).send('User not found');
    }

    // Generate password reset token (in a real application, you'd send a unique link)
    const token = Math.floor(Math.random() * 1000000).toString();
    
    // Send email with reset token
    const transporter = nodemailer.createTransport({
        service: 'gmail', // Example using Gmail
        auth: {
            user: process.env.EMAIL_USER,
            pass: process.env.EMAIL_PASS
        }
    });

    const mailOptions = {
        from: process.env.EMAIL_USER,
        to: email,
        subject: 'Password Reset',
        text: `Use the following token to reset your password: ${token}`
    };

    transporter.sendMail(mailOptions, (err, info) => {
        if (err) {
            console.log(err);
            return res.status(500).send('Error sending email');
        }
        res.send('Password reset email sent');
    });
});

app.listen(3000, () => {
    console.log('Server running on port 3000');
});
