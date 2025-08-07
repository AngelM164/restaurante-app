<?php

namespace App\Services;

use App\Repositories\DetallePedidoRepository;

class DetallePedidoService
{
    protected $detallePedidoRepository;

    public function __construct(DetallePedidoRepository $detallePedidoRepository)
    {
        $this->detallePedidoRepository = $detallePedidoRepository;
    }

    public function getAll()
    {
        return $this->detallePedidoRepository->all();
    }

    public function getById($id)
    {
        return $this->detallePedidoRepository->find($id);
    }

    public function create(array $data)
    {
        return $this->detallePedidoRepository->create($data);
    }

    public function update($id, array $data)
    {
        return $this->detallePedidoRepository->update($id, $data);
    }

    public function delete($id)
    {
        return $this->detallePedidoRepository->delete($id);
    }
}