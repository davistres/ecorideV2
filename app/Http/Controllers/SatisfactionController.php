<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Satisfaction;

class SatisfactionController extends Controller
{
    public function showForm($id)
    {
        $satisfaction = Satisfaction::findOrFail($id);
        // L'utilisateur a t'il déjà rempli le formulaire de satisfaction?
        return view('satisfaction.form', compact('satisfaction'));
    }
}
