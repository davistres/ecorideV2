<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Covoiturage extends Model
{
    use HasFactory;

    protected $table = 'covoiturage';
    protected $primaryKey = 'covoit_id';

    protected $fillable = [
        'user_id',
        'voiture_id',
        'departure_address',
        'add_dep_address',
        'postal_code_dep',
        'city_dep',
        'arrival_address',
        'add_arr_address',
        'postal_code_arr',
        'city_arr',
        'departure_date',
        'arrival_date',
        'departure_time',
        'arrival_time',
        'max_travel_time',
        'price',
        'n_tickets',
        'eco_travel',
        'trip_started',
        'trip_completed',
        'cancelled',
    ];

    public $timestamps = false;

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    public function voiture()
    {
        return $this->belongsTo(Voiture::class, 'voiture_id', 'voiture_id');
    }
}
