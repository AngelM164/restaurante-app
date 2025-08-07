<?php

namespace App\Repositories;

use App\Models\Cocinero;

class CocineroRepository
{
    public function all()
    {
        return Cocinero::all();
    }

    public function find($id)
    {
        return Cocinero::findOrFail($id);
    }

    public function create(array $data)
    {
        return Cocinero::create($data);
    }

    public function update($id, array $data)
    {
        $cocinero = Cocinero::findOrFail($id);
        $cocinero->update($data);
        return $cocinero;
    }

    public function delete($id)
    {
        $cocinero = Cocinero::findOrFail($id);
        $cocinero->delete();
        return $cocinero;
    }
}