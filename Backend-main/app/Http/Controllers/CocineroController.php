<?php

namespace App\Http\Controllers;

use App\Services\CocineroService;
use Illuminate\Http\Request;

class CocineroController extends Controller
{
    protected $cocineroService;

    public function __construct(CocineroService $cocineroService)
    {
        $this->cocineroService = $cocineroService;
    }

    public function index()
    {
        return response()->json($this->cocineroService->getAll());
    }

    public function show($id)
    {
        return response()->json($this->cocineroService->getById($id));
    }

    public function store(Request $request)
    {
        return response()->json($this->cocineroService->create($request->all()), 201);
    }

    public function update(Request $request, $id)
    {
        return response()->json($this->cocineroService->update($id, $request->all()));
    }

    public function destroy($id)
    {
        return response()->json($this->cocineroService->delete($id));
    }
}