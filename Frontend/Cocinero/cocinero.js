const API_BASE_URL = 'https://restaurante-app-production.up.railway.app/api';
const authToken = localStorage.getItem('authToken');

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

async function loadPedidos() {
    const pedidos = await apiRequest('/pedidos');
    // Filtra solo los pedidos pendientes
    const pendientes = pedidos.filter(p => p.estado === 'pendiente');
    renderPedidoList(pendientes);
}

function renderPedidoList(pedidos) {
    const container = document.getElementById('pedidoList');
    container.innerHTML = pedidos.map(p => `
        <div class="admin-list-item">
            <span>
                Pedido #${p.id} - Estado: ${p.estado}<br>
                Producto(s): ${
                    p.detalles && p.detalles.length
                        ? p.detalles.map(d => `${d.producto?.nombre} x${d.cantidad}`).join(', ')
                        : 'Sin productos'
                }
            </span>
            <button onclick="actualizarEstado(${p.id})">Marcar como 'en preparación'</button>
        </div>
    `).join('');
}


function actualizarEstado(id) {
    apiRequest(`/pedidos/${id}`, {
        method: 'PUT',
        body: JSON.stringify({ estado: 'en preparación' })
    }).then(loadPedidos);
}

function logout() {
    localStorage.removeItem('authToken');
    localStorage.removeItem('user');
    window.location.href = '../Inicio/index.html';
}

document.addEventListener('DOMContentLoaded', loadPedidos);
