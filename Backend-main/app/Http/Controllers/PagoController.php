<?php

namespace App\Http\Controllers;

use App\Services\PagoService;
use Illuminate\Http\Request;

class PagoController extends Controller
{
    protected $pagoService;

    public function __construct(PagoService $pagoService)
    {
        $this->pagoService = $pagoService;
    }

    public function index()
    {
        return response()->json($this->pagoService->getAll());
    }

    public function show($id)
    {
        return response()->json($this->pagoService->getById($id));
    }

    public function store(Request $request)
    {
        return response()->json($this->pagoService->create($request->all()), 201);
    }

    public function update(Request $request, $id)
    {
        return response()->json($this->pagoService->update($id, $request->all()));
    }

    public function destroy($id)
    {
        return response()->json($this->pagoService->delete($id));
    }
}