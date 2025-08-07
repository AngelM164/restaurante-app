<?php

namespace App\Services;

use App\Repositories\PedidoRepository;

class PedidoService
{
    protected $pedidoRepository;

    public function __construct(PedidoRepository $pedidoRepository)
    {
        $this->pedidoRepository = $pedidoRepository;
    }

    public function getAll()
    {
        return $this->pedidoRepository->all();
    }

    public function getById($id)
    {
        return $this->pedidoRepository->find($id);
    }

    public function create(array $data)
    {
        return $this->pedidoRepository->create($data);
    }

    public function update($id, array $data)
    {
        return $this->pedidoRepository->update($id, $data);
    }

    public function delete($id)
    {
        return $this->pedidoRepository->delete($id);
    }
}