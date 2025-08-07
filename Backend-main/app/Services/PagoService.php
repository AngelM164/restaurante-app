<?php
namespace App\Services;

use App\Repositories\PagoRepository;

class PagoService
{
    protected $pagoRepository;

    public function __construct(PagoRepository $pagoRepository)
    {
        $this->pagoRepository = $pagoRepository;
    }

    public function getAll()
    {
        return $this->pagoRepository->all();
    }

    public function getById($id)
    {
        return $this->pagoRepository->find($id);
    }

    public function create(array $data)
    {
        return $this->pagoRepository->create($data);
    }

    public function update($id, array $data)
    {
        return $this->pagoRepository->update($id, $data);
    }

    public function delete($id)
    {
        return $this->pagoRepository->delete($id);
    }
}