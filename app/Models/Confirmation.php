<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Confirmation extends Model
{
    use HasFactory;

    protected $table = 'confirmation';
    protected $primaryKey = 'conf_id';

    protected $fillable = [
        'covoit_id',
        'user_id',
        'statut',
        'n_conf',
    ];

    public $timestamps = false;

    public function covoiturage()
    {
        return $this->belongsTo(Covoiturage::class, 'covoit_id', 'covoit_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }
}
