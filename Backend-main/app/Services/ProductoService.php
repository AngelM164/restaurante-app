<?php

namespace App\Services;

use App\Repositories\ProductoRepository;

class ProductoService
{
    protected $productoRepository;

    public function __construct(ProductoRepository $productoRepository)
    {
        $this->productoRepository = $productoRepository;
    }

    public function getAll()
    {
        return $this->productoRepository->all();
    }

    public function getById($id)
    {
        return $this->productoRepository->find($id);
    }

    public function create(array $data)
    {
        return $this->productoRepository->create($data);
    }

    public function update($id, array $data)
    {
        return $this->productoRepository->update($id, $data);
    }

    public function delete($id)
    {
        return $this->productoRepository->delete($id);
    }
}