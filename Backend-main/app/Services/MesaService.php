<?php

namespace App\Services;

use App\Repositories\MesaRepository;

class MesaService
{
    protected $mesaRepository;

    public function __construct(MesaRepository $mesaRepository)
    {
        $this->mesaRepository = $mesaRepository;
    }

    public function getAll()
    {
        return $this->mesaRepository->all();
    }

    public function getById($id)
    {
        return $this->mesaRepository->find($id);
    }

    public function create(array $data)
    {
        return $this->mesaRepository->create($data);
    }

    public function update($id, array $data)
    {
        return $this->mesaRepository->update($id, $data);
    }

    public function delete($id)
    {
        return $this->mesaRepository->delete($id);
    }
}