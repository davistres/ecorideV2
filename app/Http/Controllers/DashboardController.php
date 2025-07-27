<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class DashboardController extends Controller
{
    public function userDashboard()
    {
        try {
            $user = Auth::user();
            $trajets_chauffeur = collect();
            $vehicules = collect();
            $reservations = collect();

            if ($user && ($user->role == 'Conducteur' || $user->role == 'Les deux')) {
                try {
                    $trajets_chauffeur = $user->covoiturages ?? collect();
                    $vehicules = $user->voitures ?? collect();
                } catch (\Exception $e) {
                    Log::warning('Erreur lors de la récupération des données conducteur: ' . $e->getMessage());
                }
            }

            if ($user && ($user->role == 'Passager' || $user->role == 'Les deux')) {
                try {
                    $reservations = $user->confirmations ?? collect();
                }
                catch (\Exception $e) {
                    Log::warning('Erreur lors de la récupération des réservations: ' . $e->getMessage());
                }
            }

            $profile_photo = $user->profile_photo ?? null;
            $profile_photo_mime = $user->profile_photo_mime ?? null;
            $pendingSatisfactions = collect();
            $passengerHistory = collect();
            $driverHistory = collect();

            return view('dashboard.users', compact('trajets_chauffeur', 'vehicules', 'reservations', 'profile_photo', 'profile_photo_mime', 'pendingSatisfactions', 'passengerHistory', 'driverHistory'));
        } catch (\Exception $e) {
            Log::error('Erreur critique dans userDashboard: ' . $e->getMessage());
            return redirect()->route('welcome')->with('error', 'Une erreur s\'est produite lors du chargement de votre tableau de bord. Veuillez réessayer.');
        }
    }
}
