<?php

namespace App\Http\Controllers;

use App\Services\ProductoService;
use Illuminate\Http\Request;

class ProductoController extends Controller
{
    protected $productoService;

    public function __construct(ProductoService $productoService)
    {
        $this->productoService = $productoService;
    }

    public function index()
    {
        return response()->json($this->productoService->getAll());
    }

    public function show($id)
    {
        return response()->json($this->productoService->getById($id));
    }

    public function store(Request $request)
    {
        return response()->json($this->productoService->create($request->all()), 201);
    }

    public function update(Request $request, $id)
    {
        return response()->json($this->productoService->update($id, $request->all()));
    }

    public function destroy($id)
    {
        return response()->json($this->productoService->delete($id));
    }
}