const API_BASE_URL = 'http://localhost:8000/api';
const authToken = localStorage.getItem('authToken');

// Helper for API requests
async function apiRequest(endpoint, options = {}) {
    const url = `${API_BASE_URL}${endpoint}`;
    const config = {
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            ...(authToken ? { 'Authorization': `Bearer ${authToken}` } : {})
        },
        ...options
    };
    const response = await fetch(url, config);
    const data = await response.json();
    if (!response.ok) throw new Error(data.message || 'Error');
    return data;
}

// Usuarios
async function loadUsers() {
    const users = await apiRequest('/usuarios');
    renderUserList(users);
}
function renderUserList(users) {
    const container = document.getElementById('userList');
    container.innerHTML = users.map(u => `
        <div>
            <span>${u.name} [${u.rol}] (${u.email || ''})</span>
            <div class="button-group">
                <button onclick="editUser(${u.id})">Editar</button>
                <button onclick="deleteUser(${u.id})">Eliminar</button>
            </div>
        </div>
    `).join('');
}
function showUserForm() {
    const container = document.getElementById('userFormContainer');
    container.style.display = 'block';
    container.innerHTML = `
        <div class="form-container">
            <h4>Nuevo Usuario</h4>
            <form id="newUserForm">
                <label>Nombre</label>
                <input type="text" name="name" required>
                <label>Email</label>
                <input type="email" name="email" required>
                <label>Contraseña</label>
                <input type="password" name="password" required>
                <label>Rol</label>
                <select name="rol" required>
                    <option value="">Selecciona un rol</option>
                    <option value="cliente">cliente</option>
                    <option value="mesero">mesero</option>
                    <option value="admin">admin</option>
                    <option value="cocinero">cocinero</option>
                </select>
                <div id="userError" style="color:red;"></div>
                <button type="submit">Guardar</button>
                <button type="button" onclick="closeUserForm()">Cancelar</button>
            </form>
        </div>
    `;
    document.getElementById('newUserForm').onsubmit = async function(e) {
        e.preventDefault();
        const form = e.target;
        const data = {
            name: form.name.value,
            email: form.email.value,
            password: form.password.value,
            rol: form.rol.value
        };
        try {
            await apiRequest('/usuarios', {
                method: 'POST',
                body: JSON.stringify(data)
            });
            closeUserForm();
            loadUsers();
        } catch (err) {
            document.getElementById('userError').textContent = err.message;
        }
    };
}
function closeUserForm() {
    const container = document.getElementById('userFormContainer');
    container.style.display = 'none';
    container.innerHTML = '';
}

function editUser(id) {
    apiRequest(`/usuarios/${id}`)
        .then(user => {
            const container = document.getElementById('userFormContainer');
            container.style.display = 'block';
            container.innerHTML = `
                <div class="form-container">
                    <h4>Editar Usuario</h4>
                    <form id="editUserForm">
                        <label>Nombre</label>
                        <input type="text" name="name" value="${user.name}" required>
                        <label>Email</label>
                        <input type="email" name="email" value="${user.email}" required>
                        <label>Contraseña (dejar vacío para no cambiar)</label>
                        <input type="password" name="password">
                        <label>Rol</label>
                        <select name="rol" required>
                            <option value="">Selecciona un rol</option>
                            <option value="cliente" ${user.rol === 'cliente' ? 'selected' : ''}>cliente</option>
                            <option value="mesero" ${user.rol === 'mesero' ? 'selected' : ''}>mesero</option>
                            <option value="admin" ${user.rol === 'admin' ? 'selected' : ''}>admin</option>
                            <option value="cocinero" ${user.rol === 'cocinero' ? 'selected' : ''}>cocinero</option>
                        </select>
                        <div id="userEditError" style="color:red;"></div>
                        <button type="submit">Actualizar</button>
                        <button type="button" onclick="closeUserForm()">Cancelar</button>
                    </form>
                </div>
            `;
            document.getElementById('editUserForm').onsubmit = async function(e) {
                e.preventDefault();
                const form = e.target;
                const data = {
                    name: form.name.value,
                    email: form.email.value,
                    rol: form.rol.value
                };
                if (form.password.value) data.password = form.password.value;
                try {
                    await apiRequest(`/usuarios/${id}`, {
                        method: 'PUT',
                        body: JSON.stringify(data)
                    });
                    closeUserForm();
                    loadUsers();
                } catch (err) {
                    document.getElementById('userEditError').textContent = err.message;
                }
            };
        });
}

// Productos
async function loadProducts() {
    const productos = await apiRequest('/productos');
    renderProductList(productos);
}
function renderProductList(productos) {
    const container = document.getElementById('productList');
    container.innerHTML = productos.map(p => `
        <div class="admin-list-item">
            <span>${p.nombre} - $${p.precio}</span>
            <div class="button-group">
                <button onclick="showEditProductForm(${p.id})">Editar</button>
                <button onclick="deleteProduct(${p.id})">Eliminar</button>
            </div>
        </div>
    `).join('');
}

function showProductForm() {
    const container = document.getElementById('productFormContainer');
    container.style.display = 'block';
    container.innerHTML = `
        <div class="form-container">
            <h4>Nuevo Producto</h4>
            <form id="newProductForm">
                <label>Nombre</label>
                <input type="text" name="nombre" required>
                <label>Precio</label>
                <input type="number" name="precio" step="0.01" required>
                <label>Descripción</label>
                <textarea name="descripcion"></textarea>
                <div id="productError" style="color:red;"></div>
                <button type="submit">Guardar</button>
                <button type="button" onclick="closeProductForm()">Cancelar</button>
            </form>
        </div>
    `;
    document.getElementById('newProductForm').onsubmit = async function(e) {
        e.preventDefault();
        const form = e.target;
        const data = {
            nombre: form.nombre.value,
            precio: form.precio.value,
            descripcion: form.descripcion.value
        };
        try {
            await apiRequest('/productos', {
                method: 'POST',
                body: JSON.stringify(data)
            });
            closeProductForm();
            loadProducts();
        } catch (err) {
            document.getElementById('productError').textContent = err.message;
        }
    };
}

function showEditProductForm(id) {
    apiRequest(`/productos/${id}`)
        .then(producto => {
            const container = document.getElementById('productFormContainer');
            container.style.display = 'block';
            container.innerHTML = `
                <div class="form-container">
                    <h4>Editar Producto</h4>
                    <form id="editProductForm">
                        <label>Nombre</label>
                        <input type="text" name="nombre" value="${producto.nombre}" required>
                        <label>Precio</label>
                        <input type="number" name="precio" step="0.01" value="${producto.precio}" required>
                        <label>Descripción</label>
                        <textarea name="descripcion">${producto.descripcion || ''}</textarea>
                        <div id="productEditError" style="color:red;"></div>
                        <button type="submit">Actualizar</button>
                        <button type="button" onclick="closeProductForm()">Cancelar</button>
                    </form>
                </div>
            `;
            document.getElementById('editProductForm').onsubmit = async function(e) {
                e.preventDefault();
                const form = e.target;
                const data = {
                    nombre: form.nombre.value,
                    precio: form.precio.value,
                    descripcion: form.descripcion.value
                };
                try {
                    await apiRequest(`/productos/${id}`, {
                        method: 'PUT',
                        body: JSON.stringify(data)
                    });
                    closeProductForm();
                    loadProducts();
                } catch (err) {
                    document.getElementById('productEditError').textContent = err.message;
                }
            };
        });
}

async function deleteProduct(id) {
    if (confirm('¿Seguro que deseas eliminar este producto?')) {
        await apiRequest(`/productos/${id}`, { method: 'DELETE' });
        loadProducts();
    }
}

function closeProductForm() {
    const container = document.getElementById('productFormContainer');
    container.style.display = 'none';
    container.innerHTML = '';
}

// Mesas
async function loadMesas() {
    const mesas = await apiRequest('/mesas');
    renderMesaList(mesas);
}
function renderMesaList(mesas) {
    const container = document.getElementById('mesaList');
    container.innerHTML = mesas.map(m => `
        <div>
            <span>${m.codigo} (${m.capacidad} personas)</span>
            <div class="button-group">
                <button onclick="editMesa(${m.id})">Editar</button>
                <button onclick="deleteMesa(${m.id})">Eliminar</button>
            </div>
        </div>
    `).join('');
}
function showMesaForm() {
    const container = document.getElementById('mesaFormContainer');
    container.style.display = 'block';
    container.innerHTML = `
        <div class="form-container">
            <h4>Nueva Mesa</h4>
            <form id="newMesaForm">
                <label>Código</label>
                <input type="text" name="codigo" required>
                <label>Capacidad</label>
                <input type="number" name="capacidad" required>
                <button type="submit">Guardar</button>
                <button type="button" onclick="closeMesaForm()">Cancelar</button>
            </form>
        </div>
    `;
    document.getElementById('newMesaForm').onsubmit = async function(e) {
        e.preventDefault();
        const form = e.target;
        const data = {
            codigo: form.codigo.value,
            capacidad: form.capacidad.value
        };
        await apiRequest('/mesas', {
            method: 'POST',
            body: JSON.stringify(data)
        });
        closeMesaForm();
        loadMesas();
    };
}

function editMesa(id) {
    apiRequest(`/mesas/${id}`)
        .then(mesa => {
            const container = document.getElementById('mesaFormContainer');
            container.style.display = 'block';
            container.innerHTML = `
                <div class="form-container">
                    <h4>Editar Mesa</h4>
                    <form id="editMesaForm">
                        <label>Código</label>
                        <input type="text" name="codigo" value="${mesa.codigo}" required>
                        <label>Capacidad</label>
                        <input type="number" name="capacidad" value="${mesa.capacidad}" required>
                        <div id="mesaEditError" style="color:red;"></div>
                        <button type="submit">Actualizar</button>
                        <button type="button" onclick="closeMesaForm()">Cancelar</button>
                    </form>
                </div>
            `;
            document.getElementById('editMesaForm').onsubmit = async function(e) {
                e.preventDefault();
                const form = e.target;
                const data = {
                    codigo: form.codigo.value,
                    capacidad: form.capacidad.value
                };
                try {
                    await apiRequest(`/mesas/${id}`, {
                        method: 'PUT',
                        body: JSON.stringify(data)
                    });
                    closeMesaForm();
                    loadMesas();
                } catch (err) {
                    document.getElementById('mesaEditError').textContent = err.message;
                }
            };
        });
}

// Pedidos
async function loadPedidos() {
    const pedidos = await apiRequest('/pedidos');
    renderPedidoList(pedidos);
}
function renderPedidoList(pedidos) {
    const container = document.getElementById('pedidoList');
    container.innerHTML = pedidos.map(p => `
        <div>
            Pedido #${p.id} - Estado: ${p.estado}
            <button onclick="viewPedido(${p.id})">Ver</button>
            <button onclick="deletePedido(${p.id})">Eliminar</button>
        </div>
    `).join('');
}
function viewPedido(id) { /* ... */ }
function deletePedido(id) { /* ... */ }

// Navegación por secciones
function showSection(sectionId) {
    document.querySelectorAll('main section').forEach(sec => {
        sec.classList.remove('active');
    });
    const target = document.getElementById(sectionId);
    if (target) target.classList.add('active');
}

// Evento para navegación
document.querySelectorAll('nav ul li a').forEach(link => {
    link.addEventListener('click', function(e) {
        const hash = this.getAttribute('href').replace('#', '');
        showSection(hash);
    });
});

// Mostrar la primera sección al cargar
document.addEventListener('DOMContentLoaded', () => {
    showSection('usuarios');
    loadUsers();
    loadProducts();
    loadMesas();
    loadPedidos();
});

