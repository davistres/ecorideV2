<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;

class User extends Authenticatable
{
    use HasFactory, Notifiable, SoftDeletes;

    protected $table = 'users';
    protected $primaryKey = 'user_id';
    public $timestamps = false;

    protected $fillable = [
        'name',
        'email',
        'password',
        'n_credit',
        'photo',
        'phototype',
        'role',
        'pref_smoke',
        'pref_pet',
        'pref_libre',
    ];

    protected $hidden = [
        'password',
    ];

    public function getRememberTokenName()
    {
        return null;
    }

    protected function casts(): array
    {
        return [
            'password' => 'hashed',
        ];
    }

    public function covoiturages()
    {
        return $this->hasMany(Covoiturage::class, 'user_id', 'user_id');
    }

    public function voitures()
    {
        return $this->hasMany(Voiture::class, 'user_id', 'user_id');
    }

    public function confirmations()
    {
        return $this->hasMany(Confirmation::class, 'user_id', 'user_id');
    }
}
