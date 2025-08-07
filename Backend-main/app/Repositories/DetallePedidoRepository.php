<?php

namespace App\Repositories;

use App\Models\DetallePedido;

class DetallePedidoRepository
{
    public function all()
    {
        return DetallePedido::all();
    }

    public function find($id)
    {
        return DetallePedido::findOrFail($id);
    }

    public function create(array $data)
    {
        return DetallePedido::create($data);
    }

    public function update($id, array $data)
    {
        $detalle = DetallePedido::findOrFail($id);
        $detalle->update($data);
        return $detalle;
    }

    public function delete($id)
    {
        $detalle = DetallePedido::findOrFail($id);
        $detalle->delete();
        return $detalle;
    }
}