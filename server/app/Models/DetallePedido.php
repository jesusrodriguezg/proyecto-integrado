<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetallePedido extends Model
{
    use HasFactory;

    protected $table = "detalle_pedido";

    protected $primaryKey = ["pedido_id_pedido","producto_id_producto"];

    protected $fillable = [
        'pedido_id_pedido',
        'producto_id_producto',
        'cantidad',
        'devuelto'
    ];

    // Definimos la relación con las entidades PEDIDO y PRODUCTO

    /**
     * Devuelve el PEDIDO asociado al DETALLE_PEDIDO
     *
     * @return void
     */
    public function pedido(){
        return $this->belongsTo(Pedido::class, 'pedido_id_pedido','id_pedido');
    }

    /**
     * Devuelve el PRODUCTO asociado al DETALLE_PEDIDO
     *
     * @return void
     */
    public function producto(){
        return $this->belongsTo(Producto::class,'producto_id_producto','id_producto');
    }

    public $timestamps = false;
}
