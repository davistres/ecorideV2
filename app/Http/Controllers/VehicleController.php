<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Voiture;

class VehicleController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'immat' => 'required|string|max:10|unique:voiture',
            'date_first_immat' => 'required|date',
            'brand' => 'required|string|max:12',
            'model' => 'required|string|max:24',
            'color' => 'required|string|max:12',
            'n_place' => 'required|integer|min:2|max:9',
            'energie' => 'required|in:Essence,Diesel/Gazole,Electrique,Hybride,GPL',
        ]);

        $vehicle = new Voiture($request->all());
        $vehicle->user_id = Auth::id();
        $vehicle->save();

        return response()->json(['success' => true, 'message' => 'Véhicule ajouté avec succès!', 'vehicle' => $vehicle]);
    }

    public function update(Request $request, $immat)
    {
        $request->validate([
            'date_first_immat' => 'required|date',
            'brand' => 'required|string|max:12',
            'model' => 'required|string|max:24',
            'color' => 'required|string|max:12',
            'n_place' => 'required|integer|min:2|max:9',
            'energie' => 'required|in:Essence,Diesel/Gazole,Electrique,Hybride,GPL',
        ]);

        $vehicle = Voiture::where('immat', $immat)->where('user_id', Auth::id())->firstOrFail();
        $vehicle->fill($request->all());
        $vehicle->save();

        return response()->json(['success' => true, 'message' => 'Véhicule mis à jour avec succès!', 'vehicle' => $vehicle]);
    }

    public function destroy($immat)
    {
        $vehicle = Voiture::where('immat', $immat)->where('user_id', Auth::id())->firstOrFail();

        // TODO: logique pour annuler les covoits

        $vehicle->delete();

        return response()->json(['success' => true, 'message' => 'Véhicule supprimé avec succès!']);
    }

    public function checkTrips($immat)
    {
        $vehicle = Voiture::where('immat', $immat)->where('user_id', Auth::id())->firstOrFail();
        $hasTrips = $vehicle->covoiturages()->exists();
        $trips = $vehicle->covoiturages()->get();

        return response()->json(['hasTrips' => $hasTrips, 'trips' => $trips]);
    }

    public function resetRole($immat)
    {
        $user = Auth::user();
        $vehicle = Voiture::where('immat', $immat)->where('user_id', $user->user_id)->firstOrFail();

        // Annuler les covoits liés à ce véhicule
        $cancelledTripsCount = 0;
        $upcomingTripsCount = 0;

        foreach ($vehicle->covoiturages as $covoiturage) {
            $covoiturage->cancelled = true;
            $covoiturage->save();
            $cancelledTripsCount++;

            // Covoit à venir ?
            if (strtotime($covoiturage->departure_date) > strtotime('today')) {
                $upcomingTripsCount++;
            }
        }

        $vehicle->delete();

        // L'utilisateur a d'autres véhicules ?
        if ($user->voitures()->count() === 0) {
            // Sinon => changer le rôle en 'Passager'
            $user->role = 'Passager';
            $user->save();
        }

        return response()->json([
            'success' => true,
            'message' => 'Véhicule supprimé et rôle mis à jour vers Passager.',
            'cancelledTrips' => $cancelledTripsCount,
            'upcomingTrips' => $upcomingTripsCount,
        ]);
    }
}
