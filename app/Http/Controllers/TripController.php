<?php

namespace App\Http\Controllers;

use App\Models\Covoiturage;
use App\Models\User;
use App\Models\Voiture;
use App\Models\Satisfaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Carbon\Carbon; // manipulation des dates

class TripController extends Controller
{
    use AuthorizesRequests, ValidatesRequests;

    public function index(Request $request)
    {
        // La recherche se fait:
        if ($request->has(['lieu_depart', 'lieu_arrivee', 'date'])) {
            return $this->performSearch($request);
        }

        // Si il n'y a pas ses paramètre, rien ne se passe
        return view('trips.index');
    }

    public function search(Request $request)
    {
        $request->validate([
            'lieu_depart' => 'required|string|max:255',
            'lieu_arrivee' => 'required|string|max:255',
            'date' => 'required|date|after_or_equal:today',
        ]);

        // => vers /trips avec les paramètres de recherche
        return redirect()->route('trips.index', [
            'lieu_depart' => $request->input('lieu_depart'),
            'lieu_arrivee' => $request->input('lieu_arrivee'),
            'date' => $request->input('date'),
        ]);
    }

    private function performSearch(Request $request)
    {
        $lieu_depart = $request->input('lieu_depart');
        $lieu_arrivee = $request->input('lieu_arrivee');
        $date_recherche = $request->input('date');

        $covoiturages = Covoiturage::where('city_dep', 'LIKE', '%' . $lieu_depart . '%')
            ->where('city_arr', 'LIKE', '%' . $lieu_arrivee . '%')
            ->where('departure_date', $date_recherche)
            ->where('n_tickets', '>', 0)
            ->where('trip_completed', 0)
            ->where('cancelled', 0)
            ->get();

        // Infos chauffeur
        foreach ($covoiturages as $covoiturage) {
            $driver = User::find($covoiturage->user_id);

            $covoiturage->pseudo_chauffeur = $driver->name;
            $covoiturage->photo_chauffeur_data = $driver->idphoto ? 'data:image/jpeg;base64,' . base64_encode($driver->idphoto) : null;
            $covoiturage->has_photo = !empty($driver->idphoto);

            // Calcul de la note moyenne
            $note_chauffeur = Satisfaction::where('user_id', $driver->user_id)
                ->whereNotNull('note')
                ->avg('note');
            $covoiturage->note_chauffeur = round($note_chauffeur, 1);
            if ($covoiturage->note_chauffeur == 0) {
                $covoiturage->note_chauffeur = 'Nouveau conducteur';
            }

            $covoiturage->places_restantes = $covoiturage->n_tickets;
            $covoiturage->prix = $covoiturage->price;
            $covoiturage->ecologique = $covoiturage->eco_travel;
        }

        if ($covoiturages->isEmpty()) {
            // Logique de suggestion de dates si aucun covoiturage trouvé
            $suggestions = [];
            for ($i = 1; $i <= 7; $i++) {
                $date_plus = Carbon::parse($date_recherche)->addDays($i)->format('Y-m-d');
                $date_moins = Carbon::parse($date_recherche)->subDays($i)->format('Y-m-d');

                $count_plus = Covoiturage::where('city_dep', 'LIKE', '%' . $lieu_depart . '%')
                    ->where('city_arr', 'LIKE', '%' . $lieu_arrivee . '%')
                    ->where('departure_date', $date_plus)
                    ->where('n_tickets', '>', 0)
                    ->where('trip_completed', 0)
                    ->where('cancelled', 0)
                    ->count();

                $count_moins = Covoiturage::where('city_dep', 'LIKE', '%' . $lieu_depart . '%')
                    ->where('city_arr', 'LIKE', '%' . $lieu_arrivee . '%')
                    ->where('departure_date', $date_moins)
                    ->where('n_tickets', '>', 0)
                    ->where('trip_completed', 0)
                    ->where('cancelled', 0)
                    ->count();

                if ($count_plus > 0) {
                    $suggestions[] = [
                        'date' => $date_plus,
                        'formatted_date' => Carbon::parse($date_plus)->format('d/m/Y'),
                        'diff' => 'dans ' . $i . ' jour(s)',
                        'count' => $count_plus
                    ];
                }
                if ($count_moins > 0) {
                    $suggestions[] = [
                        'date' => $date_moins,
                        'formatted_date' => Carbon::parse($date_moins)->format('d/m/Y'),
                        'diff' => 'il y a ' . $i . ' jour(s)',
                        'count' => $count_moins
                    ];
                }
            }

            // Trie des suggestions par date
            usort($suggestions, function ($a, $b) {
                return strtotime($a['date']) - strtotime($b['date']);
            });

            return view('trips.index', [
                'info' => 'Aucun covoiturage trouvé pour cette date.',
                'suggestions' => $suggestions,
                'lieu_depart' => $lieu_depart,
                'lieu_arrivee' => $lieu_arrivee,
                'date_recherche' => $date_recherche,
            ]);
        }

        return view('trips.index', [
            'covoiturages' => $covoiturages,
            'lieu_depart' => $lieu_depart,
            'lieu_arrivee' => $lieu_arrivee,
            'date_recherche' => $date_recherche,
        ]);
    }

    public function show($id)
    {
        $covoiturage = Covoiturage::find($id);

        if (!$covoiturage) {
            return response()->json(['error' => 'Covoiturage non trouvé.'], 404);
        }

        $driver = User::find($covoiturage->user_id);
        $voiture = Voiture::find($covoiturage->voiture_id);

        // Les avis du conducteur
        $reviews = Satisfaction::where('user_id', $driver->user_id)
            ->whereNotNull('comment')
            ->get();

        $covoiturageDetails = [
            'id' => $covoiturage->covoit_id,
            'departure_date' => Carbon::parse($covoiturage->departure_date)->format('d/m/Y'),
            'arrival_date' => Carbon::parse($covoiturage->arrival_date)->format('d/m/Y'),
            'departure_time' => substr($covoiturage->departure_time, 0, 5),
            'arrival_time' => substr($covoiturage->arrival_time, 0, 5),
            'city_dep' => $covoiturage->city_dep,
            'city_arr' => $covoiturage->city_arr,
            'departure_address' => $covoiturage->departure_address,
            'add_dep_address' => $covoiturage->add_dep_address,
            'postal_code_dep' => $covoiturage->postal_code_dep,
            'arrival_address' => $covoiturage->arrival_address,
            'add_arr_address' => $covoiturage->add_arr_address,
            'postal_code_arr' => $covoiturage->postal_code_arr,
            'price' => $covoiturage->price,
            'n_tickets' => $covoiturage->n_tickets,
            'max_travel_time' => substr($covoiturage->max_travel_time, 0, 5),
            'eco_travel' => $covoiturage->eco_travel ? 'Écologique' : 'Standard',
            'driver_pseudo' => $driver->name,
            'driver_photo' => $driver->idphoto ? 'data:image/jpeg;base64,' . base64_encode($driver->idphoto) : null,
            'driver_rating' => round(Satisfaction::where('user_id', $driver->user_id)->whereNotNull('note')->avg('note'), 1),
            'immat' => $voiture->immat,
            'brand' => $voiture->brand,
            'model' => $voiture->model,
            'color' => $voiture->color,
            'energie' => $voiture->energie,
            'pref_smoke' => $driver->pref_smoke,
            'pref_pet' => $driver->pref_pet,
            'pref_libre' => $driver->pref_libre,
            'reviews' => $reviews->map(function ($review) {
                $reviewer = User::find($review->user_id);
                return [
                    'reviewer_name' => $reviewer->name,
                    'comment' => $review->comment,
                    'note' => $review->note,
                    'date' => Carbon::parse($review->date)->format('d/m/Y'),
                ];
            }),
        ];

        return response()->json($covoiturageDetails);
    }

    public function participate($id)
    {
        // Logique de participation //////////////////////////////////////////////////////////////////////////////////
        // L'utilisateur est connecté?
        if (!Auth::check()) {
            return redirect()->route('login')->with('error', 'Vous devez être connecté pour participer à un covoiturage.');
        }

        $covoiturage = Covoiturage::find($id);

        if (!$covoiturage) {
            return redirect()->back()->with('error', 'Covoiturage non trouvé.');
        }

        // L'utilisateur est le conducteur?
        if ($covoiturage->user_id === Auth::id()) {
            return redirect()->back()->with('error', 'Vous ne pouvez pas participer à votre propre covoiturage.');
        }

        // Il reste des places?
        if ($covoiturage->n_tickets <= 0) {
            return redirect()->back()->with('error', 'Il n\'y a plus de places disponibles pour ce covoiturage.');
        }

        // Place en moins
        $covoiturage->n_tickets--;
        $covoiturage->save();

        // Vers la page de confirmation
        return redirect()->route('trips.confirm', ['id' => $covoiturage->covoit_id])->with('success', 'Votre participation a été enregistrée.');
    }

    public function confirm($id)
    {
        $covoiturage = Covoiturage::find($id);

        if (!$covoiturage) {
            return redirect()->route('trips.index')->with('error', 'Covoiturage non trouvé.');
        }

        return view('trips.confirm', compact('covoiturage'));
    }
}
