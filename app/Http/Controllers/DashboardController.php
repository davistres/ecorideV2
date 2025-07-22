<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DashboardController extends Controller
{
    public function userDashboard()
    {
        $user = Auth::user();
        $trajets_chauffeur = collect();
        $vehicules = collect();
        $reservations = collect();

        if ($user->role == 'Conducteur' || $user->role == 'Les deux') {
            $trajets_chauffeur = $user->covoiturages;
            $vehicules = $user->voitures;
        }

        if ($user->role == 'Passager' || $user->role == 'Les deux') {
            $reservations = $user->confirmations;
        }

        return view('dashboard.users', compact('trajets_chauffeur', 'vehicules', 'reservations'));
    }
}
