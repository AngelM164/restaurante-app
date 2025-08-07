<?php
use App\Http\Controllers\CocineroController;

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductoController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ClienteController;
use App\Http\Controllers\MesaController;
use App\Http\Controllers\DetallePedidoController;
use App\Http\Controllers\MeseroController;
use App\Http\Controllers\PagoController;
use App\Http\Controllers\PedidoController;
use App\Http\Controllers\UserController;


Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

Route::apiResource('clientes', ClienteController::class);
Route::apiResource('cocineros', CocineroController::class);
Route::apiResource('mesas', MesaController::class);
Route::apiResource('detallepedidos', DetallePedidoController::class);
Route::apiResource('productos', controller: ProductoController::class);
Route::apiResource('meseros', MeseroController::class);
Route::apiResource('pagos', PagoController::class);
Route::apiResource('pedidos', PedidoController::class);
Route::apiResource('usuarios', UserController::class);



Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    
});
