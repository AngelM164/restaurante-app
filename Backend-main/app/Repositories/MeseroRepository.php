<?php

namespace App\Repositories;

use App\Models\Mesero;

class MeseroRepository
{
    public function all()
    {
        return Mesero::all();
    }

    public function find($id)
    {
        return Mesero::findOrFail($id);
    }

    public function create(array $data)
    {
        return Mesero::create($data);
    }

    public function update($id, array $data)
    {
        $mesero = Mesero::findOrFail($id);
        $mesero->update($data);
        return $mesero;
    }

    public function delete($id)
    {
        $mesero = Mesero::findOrFail($id);
        $mesero->delete();
        return $mesero;
    }
}