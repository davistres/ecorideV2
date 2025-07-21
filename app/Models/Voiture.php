<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Voiture extends Model
{
    use HasFactory;

    protected $table = 'voiture';
    protected $primaryKey = 'voiture_id';

    protected $fillable = [
        'user_id',
        'immat',
        'date_first_immat',
        'brand',
        'model',
        'color',
        'n_place',
        'energie',
    ];

    public $timestamps = false;
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }
}
