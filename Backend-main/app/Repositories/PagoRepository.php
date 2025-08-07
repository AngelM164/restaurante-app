<?php
namespace App\Repositories;

use App\Models\Pago;

class PagoRepository
{
    public function all()
    {
        return Pago::all();
    }

    public function find($id)
    {
        return Pago::findOrFail($id);
    }

    public function create(array $data)
    {
        return Pago::create($data);
    }

    public function update($id, array $data)
    {
        $pago = Pago::findOrFail($id);
        $pago->update($data);
        return $pago;
    }

    public function delete($id)
    {
        $pago = Pago::findOrFail($id);
        $pago->delete();
        return $pago;
    }
}