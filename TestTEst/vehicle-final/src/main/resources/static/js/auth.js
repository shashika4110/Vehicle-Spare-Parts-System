// Authentication JavaScript
const API_BASE_URL = 'http://localhost:8080/api';

// Login function
async function login(event) {
    event.preventDefault();
    
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const errorDiv = document.getElementById('errorMessage');
    const loginButton = document.getElementById('loginButton');
    
    // Clear previous errors
    errorDiv.style.display = 'none';
    errorDiv.textContent = '';
    
    // Disable button during login
    loginButton.disabled = true;
    loginButton.textContent = 'Logging in...';
    
    try {
        const response = await fetch(`${API_BASE_URL}/auth/login`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ username, password })
        });
        
        const data = await response.json();
        
        if (response.ok) {
            // Store token and user info
            localStorage.setItem('token', data.token);
            localStorage.setItem('user', JSON.stringify(data.user));
            
            // Redirect based on role
            switch(data.user.role) {
                case 'ADMIN':
                    window.location.href = 'admin-dashboard.html';
                    break;
                case 'CUSTOMER':
                    window.location.href = 'customer-dashboard.html';
                    break;
                case 'STORE_OWNER':
                    window.location.href = 'store-dashboard.html';
                    break;
                case 'DELIVERY_STAFF':
                    window.location.href = 'delivery-dashboard.html';
                    break;
                default:
                    window.location.href = 'index.html';
            }
        } else {
            throw new Error(data.message || 'Login failed');
        }
    } catch (error) {
        errorDiv.textContent = error.message || 'Login failed. Please check your credentials.';
        errorDiv.style.display = 'block';
        loginButton.disabled = false;
        loginButton.textContent = 'Login';
    }
}

// Register function
async function register(event) {
    event.preventDefault();
    
    const username = document.getElementById('username').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const fullName = document.getElementById('fullName').value;
    const phone = document.getElementById('phone').value;
    const errorDiv = document.getElementById('errorMessage');
    const successDiv = document.getElementById('successMessage');
    const registerButton = document.getElementById('registerButton');
    
    // Clear previous messages
    errorDiv.style.display = 'none';
    successDiv.style.display = 'none';
    errorDiv.textContent = '';
    successDiv.textContent = '';
    
    // Validate passwords match
    if (password !== confirmPassword) {
        errorDiv.textContent = 'Passwords do not match';
        errorDiv.style.display = 'block';
        return;
    }
    
    // Validate password strength
    if (password.length < 6) {
        errorDiv.textContent = 'Password must be at least 6 characters long';
        errorDiv.style.display = 'block';
        return;
    }
    
    // Disable button during registration
    registerButton.disabled = true;
    registerButton.textContent = 'Creating account...';
    
    try {
        const response = await fetch(`${API_BASE_URL}/auth/register`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                username,
                email,
                password,
                fullName,
                phoneNumber: phone,
                role: 'CUSTOMER'
            })
        });
        
        const data = await response.json();
        
        if (response.ok) {
            successDiv.textContent = 'Registration successful! Redirecting to login...';
            successDiv.style.display = 'block';
            
            // Redirect to login after 2 seconds
            setTimeout(() => {
                window.location.href = 'login.html';
            }, 2000);
        } else {
            throw new Error(data.message || 'Registration failed');
        }
    } catch (error) {
        errorDiv.textContent = error.message || 'Registration failed. Please try again.';
        errorDiv.style.display = 'block';
        registerButton.disabled = false;
        registerButton.textContent = 'Register';
    }
}

// Check if user is already logged in
function checkAuth() {
    const token = localStorage.getItem('token');
    const user = localStorage.getItem('user');
    
    if (token && user) {
        const userData = JSON.parse(user);
        
        // Redirect based on role
        switch(userData.role) {
            case 'ADMIN':
                window.location.href = 'admin-dashboard.html';
                break;
            case 'CUSTOMER':
                window.location.href = 'customer-dashboard.html';
                break;
            case 'STORE_OWNER':
                window.location.href = 'store-dashboard.html';
                break;
            case 'DELIVERY_STAFF':
                window.location.href = 'delivery-dashboard.html';
                break;
        }
    }
}

// Logout function
function logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    window.location.href = 'login.html';
}

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    // Check if on login or register page
    const currentPage = window.location.pathname.split('/').pop();
    if (currentPage === 'login.html' || currentPage === 'register.html') {
        checkAuth();
    }
});
