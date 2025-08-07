// API Configuration
const API_BASE_URL = 'http://localhost:8000/api';

// Global variables
let currentUser = null;
let authToken = localStorage.getItem('authToken');
let carrito = [];
let productos = [];
let mesas = [];

// DOM Elements
const hamburger = document.querySelector('.hamburger');
const navMenu = document.querySelector('.nav-menu');
const loginModal = document.getElementById('loginModal');
const registerModal = document.getElementById('registerModal');
const menuGrid = document.getElementById('menuGrid');
const carritoItems = document.getElementById('carritoItems');
const carritoTotal = document.getElementById('carritoTotal');
const confirmarPedidoBtn = document.getElementById('confirmarPedido');
if (confirmarPedidoBtn) {
    confirmarPedidoBtn.addEventListener('click', handleConfirmarPedido);
}

// Initialize app
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
    setupEventListeners();
    if (authToken) {
        updateAuthUI();
    }
});

// Initialize application
async function initializeApp() {
    await loadProductos();
    await loadMesas();
    showSection('inicio');
    updateCarritoUI();
}

// Setup event listeners
function setupEventListeners() {
    // Mobile menu toggle
    hamburger.addEventListener('click', () => {
        navMenu.classList.toggle('active');
    });

    // Navigation links
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', (e) => {
            if (link.getAttribute('href').startsWith('#')) {
                e.preventDefault();
                const section = link.getAttribute('href').substring(1);
                if (section === 'login') {
                    showLoginModal();
                } else {
                    showSection(section);
                }
                navMenu.classList.remove('active');
            }
        });
    });

    // Category buttons
    document.querySelectorAll('.category-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.category-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            filterProducts(btn.dataset.category);
        });
    });

    // Modal close buttons
    document.querySelectorAll('.close').forEach(closeBtn => {
        closeBtn.addEventListener('click', () => {
            closeBtn.closest('.modal').style.display = 'none';
        });
    });

    // Click outside modal to close
    window.addEventListener('click', (e) => {
        if (e.target.classList.contains('modal')) {
            e.target.style.display = 'none';
        }
    });

    // Forms
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', handleRegister);
    }

    const reservaForm = document.getElementById('reservaForm');
    if (reservaForm) {
        reservaForm.addEventListener('submit', handleReserva);
    }

    const pedidoClienteForm = document.getElementById('pedidoClienteForm');
    if (pedidoClienteForm) {
        pedidoClienteForm.addEventListener('submit', handlePedidoCliente);
    }
    
    // Confirm order button
    confirmarPedidoBtn.addEventListener('click', handleConfirmarPedido);
}

// API Functions
async function apiRequest(endpoint, options = {}) {
    const url = `${API_BASE_URL}${endpoint}`;
    const config = {
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            ...options.headers
        },
        ...options
    };

    if (authToken) {
        config.headers['Authorization'] = `Bearer ${authToken}`;
    }

    try {
        const response = await fetch(url, config);
        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.message || 'Error en la petición');
        }
        
        return data;
    } catch (error) {
        console.error('API Error:', error);
        showNotification(error.message, 'error');
        throw error;
    }
}

// Load products from API
async function loadProductos() {
    try {
        productos = await apiRequest('/productos');
        renderProductos(productos);
    } catch (error) {
        console.error('Error loading products:', error);
        // Fallback data for demo
        productos = [
            {
                id: 1,
                nombre: 'Salmón a la Parrilla',
                precio: 28.50,
                descripcion: 'Salmón fresco con vegetales de temporada',
                categoria: 'principales',
                imagen: 'https://images.pexels.com/photos/1516415/pexels-photo-1516415.jpeg?auto=compress&cs=tinysrgb&w=400'
            },
            {
                id: 2,
                nombre: 'Ensalada César',
                precio: 15.00,
                descripcion: 'Lechuga romana, crutones, parmesano y aderezo césar',
                categoria: 'entradas',
                imagen: 'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=400'
            },
            {
                id: 3,
                nombre: 'Tiramisú',
                precio: 12.00,
                descripcion: 'Postre italiano tradicional con café y mascarpone',
                categoria: 'postres',
                imagen: 'https://images.pexels.com/photos/6880219/pexels-photo-6880219.jpeg?auto=compress&cs=tinysrgb&w=400'
            },
            {
                id: 4,
                nombre: 'Vino Tinto Reserva',
                precio: 35.00,
                descripcion: 'Vino tinto de la casa, cosecha especial',
                categoria: 'bebidas',
                imagen: 'https://images.pexels.com/photos/434311/pexels-photo-434311.jpeg?auto=compress&cs=tinysrgb&w=400'
            }
        ];
        renderProductos(productos);
    }
}

// Load mesas from API
async function loadMesas() {
    try {
        mesas = await apiRequest('/mesas');
        populateMesaSelects();
    } catch (error) {
        console.error('Error loading mesas:', error);
        // Fallback data for demo
        mesas = [
            { id: 1, codigo: 'M001', capacidad: 2, disponible: true },
            { id: 2, codigo: 'M002', capacidad: 4, disponible: true },
            { id: 3, codigo: 'M003', capacidad: 6, disponible: false },
            { id: 4, codigo: 'M004', capacidad: 8, disponible: true }
        ];
        populateMesaSelects();
    }
}

// Render products
function renderProductos(productosToRender) {
    menuGrid.innerHTML = '';
    
    productosToRender.forEach(producto => {
        const menuItem = document.createElement('div');
        menuItem.className = 'menu-item';
        menuItem.innerHTML = `
            <div class="menu-item-content">
                <h3>${producto.nombre}</h3>
                <p>${producto.descripcion}</p>
                <div class="menu-item-footer">
                    <span class="menu-item-price">$${producto.precio}</span>
                    <button class="add-to-cart" onclick="addToCarrito(${producto.id})">
                        Agregar
                    </button>
                </div>
            </div>
        `;
        menuGrid.appendChild(menuItem);
    });
}

// Filter products by category
function filterProducts(category) {
    if (category === 'all') {
        renderProductos(productos);
    } else {
        const filtered = productos.filter(p => p.categoria === category);
        renderProductos(filtered);
    }
}

// Populate mesa selects
function populateMesaSelects() {
    const selects = ['mesaSelect', 'mesaPedido'];
    
    selects.forEach(selectId => {
        const select = document.getElementById(selectId);
        if (select) {
            select.innerHTML = '<option value="">Seleccionar mesa</option>';
            mesas.filter(mesa => mesa.disponible).forEach(mesa => {
                const option = document.createElement('option');
                option.value = mesa.id;
                option.textContent = `${mesa.codigo} (${mesa.capacidad} personas)`;
                select.appendChild(option);
            });
        }
    });
}

// Authentication functions
async function handleLogin(email, password) {
    try {
        const response = await apiRequest('/login', {
            method: 'POST',
            body: JSON.stringify({ email, password })
        });
        // Guarda el token y usuario
        localStorage.setItem('authToken', response.token);
        localStorage.setItem('user', JSON.stringify(response.user));
        // Redirige según el rol
        if (response.user.rol === 'admin') {
            window.location.href = '../Admin/index.html';
        } else if (response.user.rol === 'mesero') {
            window.location.href = '../Mesero/index.html';
        } else if (response.user.rol === 'cocinero') {
            window.location.href = '../Cocinero/index.html';
        } else {
            // Cliente, permanece en index.html
            location.reload();
        }
    } catch (err) {
        document.getElementById('loginError').textContent = err.message;
    }
}

document.getElementById('loginForm').onsubmit = function(e) {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    handleLogin(email, password);
};

async function handleRegister(e) {
    e.preventDefault();
    const name = document.getElementById('registerName').value;
    const email = document.getElementById('registerEmail').value;
    const password = document.getElementById('registerPassword').value;
    
    try {
        await apiRequest('/register', {
            method: 'POST',
            body: JSON.stringify({ name, email, password })
        });
        
        registerModal.style.display = 'none';
        showNotification('Registro exitoso. Ahora puedes iniciar sesión', 'success');
        showLoginModal();
    } catch (error) {
        showNotification('Error en el registro', 'error');
    }
}

function updateAuthUI() {
    const loginBtn = document.querySelector('.login-btn');
    if (currentUser) {
        loginBtn.textContent = `Hola, ${currentUser.name}`;
        loginBtn.onclick = logout;
    }
}

async function logout() {
    try {
        await apiRequest('/logout', { method: 'POST' });
    } catch (error) {
        console.error('Logout error:', error);
    } finally {
        authToken = null;
        currentUser = null;
        localStorage.removeItem('authToken');
        localStorage.removeItem('currentUser');
        
        const loginBtn = document.querySelector('.login-btn');
        loginBtn.textContent = 'Iniciar Sesión';
        loginBtn.onclick = showLoginModal;
        
        showNotification('Sesión cerrada', 'success');
    }
}

// Cart functions
function addToCarrito(productoId) {
    const producto = productos.find(p => p.id === productoId);
    if (!producto) return;
    
    const existingItem = carrito.find(item => item.id === productoId);
    
    if (existingItem) {
        existingItem.cantidad++;
    } else {
        carrito.push({
            ...producto,
            cantidad: 1
        });
    }
    
    updateCarritoUI();
    showNotification(`${producto.nombre} agregado al carrito`, 'success');
}

function removeFromCarrito(productoId) {
    carrito = carrito.filter(item => item.id !== productoId);
    updateCarritoUI();
}

function updateQuantity(productoId, change) {
    const item = carrito.find(item => item.id === productoId);
    if (item) {
        item.cantidad += change;
        if (item.cantidad <= 0) {
            removeFromCarrito(productoId);
        } else {
            updateCarritoUI();
        }
    }
}

function updateCarritoUI() {
    if (carrito.length === 0) {
        carritoItems.innerHTML = '<p class="carrito-vacio">No hay productos en el carrito</p>';
        carritoTotal.textContent = '0.00';
        confirmarPedidoBtn.disabled = true;
        return;
    }
    
    carritoItems.innerHTML = '';
    let total = 0;
    
    carrito.forEach(item => {
        const subtotal = item.precio * item.cantidad;
        total += subtotal;
        
        const carritoItem = document.createElement('div');
        carritoItem.className = 'carrito-item';
        carritoItem.innerHTML = `
            <div class="carrito-item-info">
                <h4>${item.nombre}</h4>
                <p>$${item.precio} x ${item.cantidad} = $${subtotal.toFixed(2)}</p>
            </div>
            <div class="carrito-item-controls">
                <button class="quantity-btn" onclick="updateQuantity(${item.id}, -1)">-</button>
                <span>${item.cantidad}</span>
                <button class="quantity-btn" onclick="updateQuantity(${item.id}, 1)">+</button>
                <button class="quantity-btn" onclick="removeFromCarrito(${item.id})" style="background: var(--accent-color); margin-left: 0.5rem;">×</button>
            </div>
        `;
        carritoItems.appendChild(carritoItem);
    });
    
    carritoTotal.textContent = total.toFixed(2);
    confirmarPedidoBtn.disabled = false;
}

// Reservation handling
async function handleReserva(e) {
    e.preventDefault();
    
    const reservaData = {
        nombre: document.getElementById('nombreCliente').value,
        cedula: document.getElementById('cedulaCliente').value,
        telefono: document.getElementById('telefonoCliente').value,
        fecha: document.getElementById('fechaReserva').value,
        hora: document.getElementById('horaReserva').value,
        mesa_id: document.getElementById('mesaSelect').value
    };
    
    try {
        // First create or get client
        const clienteResponse = await apiRequest('/clientes', {
            method: 'POST',
            body: JSON.stringify({
                nombre: reservaData.nombre,
                cedula: reservaData.cedula,
                telefono: reservaData.telefono
            })
        });
        
        showNotification('Reserva confirmada exitosamente', 'success');
        document.getElementById('reservaForm').reset();
    } catch (error) {
        showNotification('Error al confirmar la reserva', 'error');
    }
}

// Order handling
let clienteData = null;

async function handlePedidoCliente(e) {
    e.preventDefault();
    
    clienteData = {
        nombre: document.getElementById('nombrePedido').value,
        cedula: document.getElementById('cedulaPedido').value,
        telefono: document.getElementById('telefonoPedido').value,
        mesa_id: document.getElementById('mesaPedido').value
    };
    
    showNotification('Información del cliente guardada. Agrega productos al carrito', 'success');
}

async function handleConfirmarPedido() {
    // Obtén los datos directamente del formulario
    const nombre = document.getElementById('nombrePedido')?.value;
    const cedula = document.getElementById('cedulaPedido')?.value;
    const telefono = document.getElementById('telefonoPedido')?.value;
    const mesa_id = document.getElementById('mesaPedido')?.value;

    if (!nombre || !cedula || !telefono || !mesa_id) {
        showNotification('Por favor completa la información del cliente primero', 'error');
        return;
    }

    if (carrito.length === 0) {
        showNotification('El carrito está vacío', 'error');
        return;
    }

    try {
        // Crear o buscar cliente
        const clienteResponse = await apiRequest('/clientes', {
            method: 'POST',
            body: JSON.stringify({
                nombre,
                cedula,
                telefono
            })
        });

        if (!clienteResponse.id) {
            showNotification('No se pudo crear el cliente', 'error');
            return;
        }

        // Crear pedido
        const pedidoData = {
            cliente_id: clienteResponse.id,
            mesa_id: Number(mesa_id),
            mesero_id: 1, // Cambia esto si tienes mesero logueado
            estado: 'pendiente'
        };

        const pedidoResponse = await apiRequest('/pedidos', {
            method: 'POST',
            body: JSON.stringify(pedidoData)
        });

        if (!pedidoResponse.id) {
            showNotification('No se pudo crear el pedido', 'error');
            return;
        }

        // Crear detalles del pedido
        for (const item of carrito) {
            await apiRequest('/detallepedidos', {
                method: 'POST',
                body: JSON.stringify({
                    pedido_id: pedidoResponse.id,
                    producto_id: item.id,
                    cantidad: item.cantidad,
                    subtotal: item.precio * item.cantidad
                })
            });
        }

        // Actualizar la mesa a no disponible
        await apiRequest(`/mesas/${mesa_id}`, {
            method: 'PUT',
            body: JSON.stringify({ disponible: false })
        });

        // Limpiar carrito y formulario
        carrito = [];
        updateCarritoUI();
        document.getElementById('pedidoClienteForm').reset();

        showNotification('Pedido confirmado exitosamente', 'success');
    } catch (error) {
        showNotification(error.message || 'Error al confirmar el pedido', 'error');
        console.error('Pedido error:', error);
    }
}

// UI Functions
function showSection(sectionId) {
    // Hide all sections
    document.querySelectorAll('section').forEach(section => {
        section.classList.add('hidden');
    });
    
    // Show target section
    const targetSection = document.getElementById(sectionId);
    if (targetSection) {
        targetSection.classList.remove('hidden');
    }
    
    // Update active nav link
    document.querySelectorAll('.nav-link').forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === `#${sectionId}`) {
            link.classList.add('active');
        }
    });
}

function showLoginModal() {
    loginModal.style.display = 'block';
}

function showRegisterModal() {
    loginModal.style.display = 'none';
    registerModal.style.display = 'block';
}

function showNotification(message, type = 'info') {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
        <span>${message}</span>
        <button onclick="this.parentElement.remove()">&times;</button>
    `;
    
    // Add styles
    notification.style.cssText = `
        position: fixed;
        top: 100px;
        right: 20px;
        background: ${type === 'success' ? '#27ae60' : type === 'error' ? '#e74c3c' : '#3498db'};
        color: white;
        padding: 1rem 1.5rem;
        border-radius: var(--border-radius);
        box-shadow: var(--shadow);
        z-index: 3000;
        display: flex;
        align-items: center;
        gap: 1rem;
        animation: slideInRight 0.3s ease-out;
    `;
    
    // Add animation styles
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
    `;
    document.head.appendChild(style);
    
    document.body.appendChild(notification);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        if (notification.parentElement) {
            notification.parentElement.removeChild(notification);
        }
    }, 5000);
}