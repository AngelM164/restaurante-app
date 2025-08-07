<?php
namespace App\Repositories;

use App\Models\Pedido;

class PedidoRepository
{
    public function all()
    {
        return Pedido::all();
    }

    public function find($id)
    {
        return Pedido::findOrFail($id);
    }

    public function create(array $data)
    {
        return Pedido::create($data);
    }

    public function update($id, array $data)
    {
        $pedido = Pedido::findOrFail($id);
        $pedido->update($data);
        return $pedido;
    }

    public function delete($id)
    {
        $pedido = Pedido::findOrFail($id);
        $pedido->delete();
        return $pedido;
    }
}