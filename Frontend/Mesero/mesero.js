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
    // Filtra solo los pedidos en preparación
    const enPreparacion = pedidos.filter(p => p.estado === 'en preparación');
    renderPedidoList(enPreparacion);
}

function renderPedidoList(pedidos) {
    const container = document.getElementById('pedidoList');
    container.innerHTML = pedidos.map(p => `
        <div class="admin-list-item">
            <span>Pedido #${p.id} - Estado: ${p.estado}</span>
            <button onclick="editEstadoPedido(${p.id}, '${p.estado}')">Marcar como 'servido'</button>
        </div>
    `).join('');
}


function editEstadoPedido(id, estadoActual) {
    // Obtiene el pedido actual para saber la mesa
    apiRequest(`/pedidos/${id}`)
        .then(pedido => {
            // Actualiza el estado del pedido a "servido"
            return apiRequest(`/pedidos/${id}`, {
                method: 'PUT',
                body: JSON.stringify({ estado: 'servido' })
            }).then(() => pedido);
        })
        .then(pedido => {
            // Si no hay relación mesa, busca la mesa por mesa_id
            if (pedido.mesa_id) {
                // Obtiene la mesa y verifica si está ocupada
                return apiRequest(`/mesas/${pedido.mesa_id}`)
                    .then(mesa => {
                        if (mesa.disponible === false) {
                            return apiRequest(`/mesas/${mesa.id}`, {
                                method: 'PUT',
                                body: JSON.stringify({ disponible: true })
                            });
                        }
                    });
            }
        })
        .finally(loadPedidos);
}

function logout() {
    localStorage.removeItem('authToken');
    localStorage.removeItem('user');
    window.location.href = '../Inicio/index.html';
}

document.addEventListener('DOMContentLoaded', loadPedidos);
