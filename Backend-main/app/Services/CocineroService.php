<?php

namespace App\Services;

use App\Repositories\CocineroRepository;

class CocineroService
{
    protected $cocineroRepository;

    public function __construct(CocineroRepository $cocineroRepository)
    {
        $this->cocineroRepository = $cocineroRepository;
    }

    public function getAll()
    {
        return $this->cocineroRepository->all();
    }

    public function getById($id)
    {
        return $this->cocineroRepository->find($id);
    }

    public function create(array $data)
    {
        return $this->cocineroRepository->create($data);
    }

    public function update($id, array $data)
    {
        return $this->cocineroRepository->update($id, $data);
    }

    public function delete($id)
    {
        return $this->cocineroRepository->delete($id);
    }
}