<?php

namespace App\Http\Controllers;

use App\Services\ClienteService;
use Illuminate\Http\Request;

class ClienteController extends Controller
{
    protected $clienteService;

    public function __construct(ClienteService $clienteService)
    {
        $this->clienteService = $clienteService;
    }

    public function index()
    {
        return response()->json($this->clienteService->getAll());
    }

    public function show($id)
    {
        return response()->json($this->clienteService->getById($id));
    }

    public function store(Request $request)
    {
        return response()->json($this->clienteService->create($request->all()), 201);
    }

    public function update(Request $request, $id)
    {
        return response()->json($this->clienteService->update($id, $request->all()));
    }

    public function destroy($id)
    {
        return response()->json($this->clienteService->delete($id));
    }
}