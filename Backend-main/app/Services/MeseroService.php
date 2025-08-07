<?php
namespace App\Services;

use App\Repositories\MeseroRepository;

class MeseroService
{
    protected $meseroRepository;

    public function __construct(MeseroRepository $meseroRepository)
    {
        $this->meseroRepository = $meseroRepository;
    }

    public function getAll()
    {
        return $this->meseroRepository->all();
    }

    public function getById($id)
    {
        return $this->meseroRepository->find($id);
    }

    public function create(array $data)
    {
        return $this->meseroRepository->create($data);
    }

    public function update($id, array $data)
    {
        return $this->meseroRepository->update($id, $data);
    }

    public function delete($id)
    {
        return $this->meseroRepository->delete($id);
    }
}