<?php

namespace App\Http\Controllers;

use App\Services\DetallePedidoService;
use Illuminate\Http\Request;

class DetallePedidoController extends Controller
{
    protected $detallePedidoService;

    public function __construct(DetallePedidoService $detallePedidoService)
    {
        $this->detallePedidoService = $detallePedidoService;
    }

    public function index()
    {
        return response()->json($this->detallePedidoService->getAll());
    }

    public function show($id)
    {
        return response()->json($this->detallePedidoService->getById($id));
    }

    public function store(Request $request)
    {
        return response()->json($this->detallePedidoService->create($request->all()), 201);
    }

    public function update(Request $request, $id)
    {
        return response()->json($this->detallePedidoService->update($id, $request->all()));
    }

    public function destroy($id)
    {
        return response()->json($this->detallePedidoService->delete($id));
    }
}