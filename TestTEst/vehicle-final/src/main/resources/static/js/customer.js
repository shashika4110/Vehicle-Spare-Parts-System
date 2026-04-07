// Customer Dashboard JavaScript
const API_BASE_URL = 'http://localhost:8080/api';

// Get current user from localStorage
let currentUser = null;

// Initialize on page load
document.addEventListener('DOMContentLoaded', async () => {
    const user = JSON.parse(localStorage.getItem('user'));
    if (!user || user.role !== 'CUSTOMER') {
        window.location.href = 'login.html';
        return;
    }
    currentUser = user;
    
    // Display user info
    document.getElementById('userName').textContent = user.username;
    
    // Load dashboard data
    await loadDashboardData();
});

// Load dashboard data
async function loadDashboardData() {
    try {
        const token = localStorage.getItem('token');
        
        // Load orders
        const ordersResponse = await fetch(`${API_BASE_URL}/orders/customer/${currentUser.id}`, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });
        
        if (ordersResponse.ok) {
            const orders = await ordersResponse.json();
            displayOrders(orders);
        }
        
        // Load warranties
        const warrantiesResponse = await fetch(`${API_BASE_URL}/warranties/my-warranties`, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });
        
        if (warrantiesResponse.ok) {
            const warranties = await warrantiesResponse.json();
            displayWarranties(warranties);
        }
        
    } catch (error) {
        console.error('Error loading dashboard data:', error);
    }
}

// Display orders
function displayOrders(orders) {
    const container = document.getElementById('ordersContainer');
    if (!container) return;
    
    if (orders.length === 0) {
        container.innerHTML = '<p>No orders yet</p>';
        return;
    }
    
    container.innerHTML = orders.map(order => `
        <div class="order-card">
            <h3>Order #${order.id}</h3>
            <p>Date: ${new Date(order.orderDate).toLocaleDateString()}</p>
            <p>Status: ${order.status}</p>
            <p>Total: $${order.totalAmount}</p>
        </div>
    `).join('');
}

// Display warranties
function displayWarranties(warranties) {
    const container = document.getElementById('warrantiesContainer');
    if (!container) return;
    
    if (warranties.length === 0) {
        container.innerHTML = '<p>No warranties yet</p>';
        return;
    }
    
    container.innerHTML = warranties.map(warranty => `
        <div class="warranty-card">
            <h3>${warranty.product?.name || 'Product'}</h3>
            <p>Status: ${warranty.status}</p>
            <p>Expiry: ${warranty.expiryDate}</p>
        </div>
    `).join('');
}

// Logout
function logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    window.location.href = 'login.html';
}

// Navigate to warranty claims
function goToWarrantyClaims() {
    window.location.href = 'warranty-claims.html';
}

// Navigate to products
function goToProducts() {
    window.location.href = 'products.html';
}
