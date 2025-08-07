<?php

namespace App\Services;

use App\Repositories\ClienteRepository;

class ClienteService
{
    protected $clienteRepository;

    public function __construct(ClienteRepository $clienteRepository)
    {
        $this->clienteRepository = $clienteRepository;
    }

    public function getAll()
    {
        return $this->clienteRepository->all();
    }

    public function getById($id)
    {
        return $this->clienteRepository->find($id);
    }

    public function create(array $data)
    {
        return $this->clienteRepository->create($data);
    }

    public function update($id, array $data)
    {
        return $this->clienteRepository->update($id, $data);
    }

    public function delete($id)
    {
        return $this->clienteRepository->delete($id);
    }
}