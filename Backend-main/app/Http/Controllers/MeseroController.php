<?php

namespace App\Http\Controllers;

use App\Services\MeseroService;
use Illuminate\Http\Request;

class MeseroController extends Controller
{
    protected $meseroService;

    public function __construct(MeseroService $meseroService)
    {
        $this->meseroService = $meseroService;
    }

    public function index()
    {
        return response()->json($this->meseroService->getAll());
    }

    public function show($id)
    {
        return response()->json($this->meseroService->getById($id));
    }

    public function store(Request $request)
    {
        return response()->json($this->meseroService->create($request->all()), 201);
    }

    public function update(Request $request, $id)
    {
        return response()->json($this->meseroService->update($id, $request->all()));
    }

    public function destroy($id)
    {
        return response()->json($this->meseroService->delete($id));
    }
}