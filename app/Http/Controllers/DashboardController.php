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

        $profile_photo = null;
        $profile_photo_mime = null;
        $pendingSatisfactions = collect();
        $passengerHistory = collect();
        $driverHistory = collect();

        // TODO:
            // Logique pour récupérer la photo de profil et son type MIME
            //  Logique pour récupérer les satisfactions en attente
            // Logique pour récupérer l'historique passager et conducteur

        return view('dashboard.users', compact('trajets_chauffeur', 'vehicules', 'reservations', 'profile_photo', 'profile_photo_mime', 'pendingSatisfactions', 'passengerHistory', 'driverHistory'));
    }
}